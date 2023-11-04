const std = @import("std");
const expect = @import("std").testing.expect;

const cell = struct {
    x: usize,
    y: usize,
};

pub fn mazeTrasversal(n: u16, m: u16) !u128 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var memo = std.AutoHashMap(cell, u128).init(allocator);
    defer memo.deinit();

    for (1..n + 1) |v| {
        const c = cell{ .x = v, .y = 1 };
        try memo.put(c, 1);
    }
    for (1..m + 1) |v| {
        const c = cell{ .x = 1, .y = v };
        try memo.put(c, 1);
    }

    for (2..n + 1) |i| {
        for (2..m + 1) |j| {
            const prev_x = memo.get(cell{ .x = i - 1, .y = j }) orelse 0;
            const prev_y = memo.get(cell{ .x = i, .y = j - 1 }) orelse 0;
            try memo.put(cell{ .x = i, .y = j }, prev_x + prev_y);
        }
    }

    return memo.get(cell{ .x = n, .y = m }).?;
}

test "paths1" {
    const result = try mazeTrasversal(3, 2);
    try expect(result == 3);
}

test "paths2" {
    const result = try mazeTrasversal(18, 6);
    try expect(result == 26334);
}

test "paths3" {
    const result = try mazeTrasversal(75, 19);
    try expect(result == 5873182941643167150);
}
