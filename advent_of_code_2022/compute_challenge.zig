const std = @import("std");
const aoc = @import("utilities/aoc_result.zig");
const aoc1 = @import("aoc1.zig");

pub fn computeAocChallenge(allocator: std.mem.Allocator, input: u8) !aoc.AocResult {
    const result = switch (input) {
        1 => aoc1.aoc1(allocator),
        else => AocError.AocNotFound,
    };
    return result;
}

pub const AocError = error{
    AocNotFound,
};
