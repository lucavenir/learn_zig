const std = @import("std");
const expect = @import("std").testing.expect;

const AllocationError = error{OutOfMemory};

pub fn main() void {
    const result = function();
    std.debug.print("Hello, {}!\n", .{result catch 0}); // Hello, 2!

    const anotherResult = vectors();
    std.debug.print("Here's a vector, I wonder how it prints out: {s}\n", .{anotherResult});

    const yetAnotherResult = slices();
    std.debug.print("Here's a slice, I wonder how it prints out: {s}\n", .{yetAnotherResult});
}

fn function() AllocationError!u16 {
    return 2;
}

fn vectors() [5]u8 {
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

    return b;
}

fn slices() []const u8 {
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

    return b[0..4];
}

test "test deez slice" {
    const s = slices();
    try expect(s.len == 4);

    const a = s[0..2];
    try (expect(a.len == 2));
}
