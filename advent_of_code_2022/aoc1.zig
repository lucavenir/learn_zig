const std = @import("std");
const print = std.debug.print;
const file_utils = @import("utilities/files.zig");
const aoc = @import("utilities/aoc_result.zig");

pub fn aoc1(allocator: std.mem.Allocator) !aoc.AocResult {
    const buffer = try file_utils.readFile(allocator, "day_1/input.txt");
    defer allocator.free(buffer);
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

    const result = try std.fmt.allocPrint(allocator, "{d}", .{maximum_calories});

    return aoc.AocResult{ .result = result };
}
