const std = @import("std");
const AllocationError = error{OutOfMemory};

pub fn main() void {
    const result = function();
    std.debug.print("Hello, {}!\n", .{result catch 0}); // Hello, 2!

    const anotherResult = vectors();
    std.debug.print("Here's a vector, I wonder how it prints out: {s}\n", .{anotherResult});

    const yetAnotherResult = vectors();
    std.debug.print("Here's a slice, I wonder how it prints out: {s}\n", .{yetAnotherResult});
}

fn function() AllocationError!u16 {
    return 2;
}

fn vectors() [5]u8 {
    const b = [5]u8{ 'w', 'o', 'r', 'l', 'd' };

    return b;
}

fn slices() []u8 {
    const b = [5]u8{ 'w', 'o', 'r', 'l', 'd' };

    return b[0..2];
}
