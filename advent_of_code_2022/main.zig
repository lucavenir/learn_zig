const std = @import("std");
const print = std.debug.print;
const command_line = @import("utilities/command_line.zig");
const aoc = @import("compute_challenge.zig");
const t = std.testing;
const file_system = std.fs;
const io = std.io;

pub fn main() !void {
    const arg = command_line.getFirstArg() catch |err| {
        switch (err) {
            command_line.CliError.ArgumentNotFound => {
                print("Usage: [x] (AoC day, integer)\n", .{});
            },
            command_line.CliError.InvalidInteger => {
                print("Invalid AoC day\n", .{});
            },
        }
        return;
    };

    print("Selected day: {}\n", .{arg});

    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var result = aoc.computeAocChallenge(allocator, arg) catch |err| {
        return switch (err) {
            aoc.AocError.AocNotFound => {
                print("{} This challenge hasn't been solved, yet\n", .{err});
            },
            else => {
                print("{}\n", .{err});
            },
        };
    };
    defer result.deinit(allocator);

    print("Challenge Answer: {s}\n", .{result.result});
}
