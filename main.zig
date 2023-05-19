const std = @import("std");
const AllocationError = error{OutOfMemory};

pub fn main() void {
    const result = function();
    std.debug.print("Hello, {}!\n", .{result catch 0}); // Hello, 2!
}

fn function() AllocationError!u16 {
    return 2;
}
