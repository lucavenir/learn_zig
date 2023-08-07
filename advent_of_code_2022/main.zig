const std = @import("std");
const print = std.debug.print;
const command_line = @import("utilities/command_line.zig");
const aoc = @import("compute_challenge.zig");
const t = std.testing;
const file_system = std.fs;
const io = std.io;

pub fn main() !void {
    const day = command_line.getFirstArg() catch |err| {
        switch (err) {
            command_line.CliError.ArgumentNotFound => {
                print("Usage: zig run main.dart -- <AoC day, as integer>\n", .{});
            },
            command_line.CliError.InvalidInteger => {
                print("Invalid AoC day\n", .{});
            },
        }
        return;
    };

    print("Selected day: {}\n", .{day});

    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    var result = aoc.computeAocChallenge(allocator, day) catch |err| {
        return switch (err) {
            aoc.AocError.AocNotFound => {
                print("{} This challenge hasn't been solved, yet\n", .{err});
            },
            else => {
                print("Uh oh. {}\n", .{err});
            },
        };
    };

    print("Challenge {d}.1. Answer: {s}\n", .{ day, result.first_star });
    print("Challenge {d}.2. Answer: {s}\n", .{ day, result.second_star });
}
