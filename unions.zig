const expect = @import("std").testing.expect;
const std = @import("std");

const MyResult = union {
    int: i64,
    float: f64,
    bool: bool,
};

test "my union can be used!" {
    var result = MyResult{ .int = 321 };
    result = MyResult{ .float = 0.2 };
    // result = false; // ERROR, expected union.MyResult
}

const SomeEnum = enum { a, b, c };
const SomeUnion = union(SomeEnum) { a: u4, b: u8, c: u16 };

test "we can match unions with enums, while capturing their reference" {
    var value = SomeUnion{ .c = 99 };
    switch (value) {
        // when capturing this match, we get a constant value
        // thus, to mutate "X", we need a pointer to "X" and dereference it
        .a => |*a| a.* = 0,
        .b => |*b| b.* = 1,
        .c => |*c| c.* = 2,
    }
    try expect(value.c == 2);
}
