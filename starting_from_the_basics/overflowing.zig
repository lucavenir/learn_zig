const expect = @import("std").testing.expect;

test "well defined overflow" {
    var x: u4 = 15;
    // by default this panics on safe modes, no overflow are allowed in zig
    // x += 1;
    // this operator explicitly allows overflows
    x +%= 1;

    try expect(x == 0);
}
