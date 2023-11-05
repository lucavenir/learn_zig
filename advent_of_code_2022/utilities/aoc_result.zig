const std = @import("std");

pub fn AocResult(comptime T: type) type {
    return struct {
        first_star: T,
        second_star: T,
    };
}
