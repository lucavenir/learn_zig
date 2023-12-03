const std = @import("std");
const print = std.debug.print;
const command_line = @import("utilities/command_line.zig");
const aoc1 = @import("aoc1.zig");
const aoc2 = @import("aoc2.zig");
const aoc3 = @import("aoc3.zig");
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

    const result = switch (day) {
        1 => aoc1.aoc1(),
        2 => aoc2.aoc2(),
        3 => aoc3.aoc3(),
        else => AocError.AocNotFound,
    } catch |err| {
        return switch (err) {
            AocError.AocNotFound => {
                print("{} This challenge hasn't been solved, yet\n", .{err});
            },
            else => {
                print("Uh oh. {}\n", .{err});
            },
        };
    };

    print("Challenge {d}.1. Answer: {any}\n", .{ day, result.first_star });
    print("Challenge {d}.2. Answer: {any}\n", .{ day, result.second_star });
}

pub const AocError = error{
    AocNotFound,
};
