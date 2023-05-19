const std = @import("std");

pub fn main() void {
    const result = function();
    std.debug.print("Hello, {}!\n", .{result});
}

fn function() i32 {
    return 2;
}
