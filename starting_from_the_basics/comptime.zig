const print = @import("std").debug.print;
const expect = @import("std").testing.expect;

fn Matrix(comptime T: type, comptime width: comptime_int, comptime height: comptime_int) type {
    return [height][width]T;
}

test "return a type" {
    const a = Matrix(f32, 4, 4);
    try expect(a == [4][4]f32);
}
