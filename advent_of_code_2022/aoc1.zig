const std = @import("std");
const print = std.debug.print;
const file_utils = @import("utilities/files.zig");
const aoc = @import("utilities/aoc_result.zig");

pub fn aoc1() !aoc.AocResult(u128) {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    const buffer = try file_utils.readFile(allocator, "day_1/input.txt");
    defer allocator.free(buffer);

    const maximum_calories = try aoc11(buffer);
    const top_three_maximum_calories = try aoc12(buffer);

    return aoc.AocResult(u128){
        .first_star = maximum_calories,
        .second_star = top_three_maximum_calories,
    };
}

fn aoc11(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n\n");
    var maximum_calories: u128 = 0;
    while (iterator.next()) |lines| {
        var inner_iterator = std.mem.splitSequence(u8, lines, "\n");
        var total_calories: u128 = 0;
        while (inner_iterator.next()) |line| {
            const calories = try std.fmt.parseUnsigned(u32, line, 10);
            total_calories += calories;
        }
        if (total_calories > maximum_calories) maximum_calories = total_calories;
    }

    return maximum_calories;
}

fn aoc12(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n\n");
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();
    var elves = std.ArrayList(u128).init(allocator);
    defer elves.deinit();

    while (iterator.next()) |lines| {
        var inner_iterator = std.mem.splitSequence(u8, lines, "\n");
        var total_calories: u128 = 0;
        while (inner_iterator.next()) |line| {
            const calories = try std.fmt.parseUnsigned(u32, line, 10);
            total_calories += calories;
        }
        try elves.append(total_calories);
    }

    var items = elves.items;
    std.sort.heap(u128, items, {}, std.sort.desc(u128));
    const top_three = items[0..3];
    var sum: u128 = 0;
    for (top_three) |v| {
        sum += v;
    }
    return sum;
}
