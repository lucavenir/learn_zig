const expect = @import("std").testing.expect;

pub fn findIndex(v: []const isize, e: isize) ?usize {
    for (v, 0..) |current, i| {
        if (e == current) return i;
    }

    return null;
}

test "optionals are great.." {
    const data = [_]isize{ 1, 2, 3, 4, 5, 6, 7, 8, 12 };
    const index = findIndex(data[0..], 10);
    try expect(index == null);
}

test "..because they're safe and sound" {
    var a: ?u8 = null;
    var b = a orelse 0; // same type of a, but with this default
    // var c = a orelse false; // yes, this is a compile-time error (int or bool ambiguity)
    try expect(b == 0);
    try expect(@TypeOf(b) == u8);
}

test ".. and you can still write null assertions" {
    var z: ?u8 = null;
    // const b = z orelse unreachable; // This panics. "Reached unreachable code"
    z = 10;
    const b = z orelse unreachable;
    const c = z.?; // exactly as above
    _ = c;
    _ = b;
}

test ".. AND you can payload capture it" {
    var a: ?u4 = 1;
    if (a) |*val| {
        val.* += 1;
    }

    try expect(a.? == 2);
}

fn subtractOrNull(a: *u32) ?u32 {
    if (a.* == 0) return null;
    a.* -= 1;
    return a.*;
}

test "more null payload capturing shanenigans" {
    var sum: u32 = 0;
    var initialValue: u32 = 4;
    while (subtractOrNull(&initialValue)) |value| {
        sum += value;
    }
    try expect(sum == 6);
}
