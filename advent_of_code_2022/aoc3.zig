const std = @import("std");
const testing = std.testing;
const print = std.debug.print;
const ascii = std.ascii;
const file_utils = @import("utilities/files.zig");
const aoc = @import("utilities/aoc_result.zig");

pub fn aoc3() !aoc.AocResult(u128) {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    const buffer = try file_utils.readFile(allocator, "day_3/input.txt");
    defer allocator.free(buffer);

    const total_priorities = try aoc31(buffer);
    const total_common_priorities = try aoc32(buffer);

    return aoc.AocResult(u128){
        .first_star = total_priorities,
        .second_star = total_common_priorities,
    };
}

fn priority(letter: u8) u8 {
    const is_upper = ascii.isUpper(letter);
    const base_value: u8 = if (is_upper) 27 else 1;
    const letter_value: u8 = if (is_upper) letter - 'A' else letter - 'a';
    const result = base_value + letter_value;
    return result;
}

test "priority" {
    try testing.expect(priority('A') == 27);
    try testing.expect(priority('P') == 42);
    try testing.expect(priority('t') == 20);
}

fn toMap(input: []const u8, allocator: std.mem.Allocator) !std.AutoHashMap(u8, void) {
    var map = std.AutoHashMap(u8, void).init(allocator);
    for (input) |el| {
        try map.put(el, {});
    }
    return map;
}

// shit implementation, but who cares atm
fn findCommon(first: []const u8, second: []const u8) !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    var first_map = try toMap(first, allocator);
    defer first_map.deinit();

    var second_map = try toMap(second, allocator);
    defer second_map.deinit();

    var iterator = first_map.keyIterator();
    while (iterator.next()) |el| {
        if (second_map.contains(el.*)) return el.*;
    }

    unreachable;
}

// even more shit, coz i can't figure out how to perform set intersection in zig
fn findCommonBetween(first: []const u8, second: []const u8, third: []const u8) !u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    var first_map = try toMap(first, allocator);
    defer first_map.deinit();

    var second_map = try toMap(second, allocator);
    defer second_map.deinit();
    var third_map = try toMap(third, allocator);
    defer third_map.deinit();

    var iterator = first_map.keyIterator();
    while (iterator.next()) |el| {
        if (second_map.contains(el.*)) {
            if (third_map.contains(el.*)) return el.*;
        }
    }

    unreachable;
}

test "find" {
    const first_1 = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    const second_1 = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

    try testing.expect(try findCommon(&first_1, &second_1) == 'o');

    const first_2 = [_]u8{
        'v',
        'J',
        'r',
        'w',
        'p',
        'W',
        't',
        'w',
        'J',
        'g',
        'W',
        'r',
    };
    const second_2 = [_]u8{
        'h',
        'c',
        's',
        'F',
        'M',
        'M',
        'f',
        'F',
        'F',
        'h',
        'F',
        'p',
    };

    const o = findCommon(&first_2, &second_2);

    try testing.expect(try o == 'p');
}

fn aoc31(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n");
    var sum: u128 = 0;
    while (iterator.next()) |line| {
        const compartment_length = line.len / 2;
        const first_compartment = line[0..compartment_length];
        const second_compartment = line[compartment_length..];

        const occurrence = try findCommon(first_compartment, second_compartment);
        sum += priority(occurrence);
    }

    return sum;
}

test "aoc31" {
    const allocator = testing.allocator;

    const buffer = try file_utils.readFile(allocator, "day_3/testing.txt");
    defer allocator.free(buffer);

    const total_priorities = try aoc31(buffer);
    try testing.expect(total_priorities == 157);
}

fn aoc32(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n");
    var score: u128 = 0;
    while (iterator.next()) |first_line| {
        const second_line = iterator.next().?;
        const third_line = iterator.next().?;

        const occurrence = try findCommonBetween(first_line, second_line, third_line);
        score += priority(occurrence);
    }

    return score;
}
