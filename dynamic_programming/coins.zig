const std = @import("std");
const expect = @import("std").testing.expect;

const available_coins = [_]u16{ 1, 4, 5, 8 };

pub fn naiveCoins(input: u32) ?u32 {
    if (input == 0) {
        return 0;
    }

    var min: ?u32 = null;
    for (available_coins) |coin| {
        if (input < coin) {
            continue;
        }
        const subproblem = input - coin;

        const compute = naiveCoins(subproblem);
        if (compute == null) {
            continue;
        }

        const computation = compute.? + 1;
        if (min == null) {
            min = computation;
            continue;
        }

        if (computation < min.?) {
            min = computation;
        }
    }

    return min.?;
}

pub fn coins(input: u32) !u32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var memo = std.AutoHashMap(u32, u32).init(allocator);
    defer memo.deinit();
    try memo.put(0, 0);
    var i: u32 = 1;
    while (i <= input) {
        for (available_coins) |coin| {
            if (i < coin) {
                continue;
            }
            const sub = i - coin;

            const sub_computation = memo.get(sub);
            if (sub_computation == null) {
                continue;
            }
            const computation = sub_computation.? + 1;

            const current = memo.get(i);
            if (current == null) {
                try memo.put(i, computation);
                continue;
            }

            if (computation < current.?) {
                try memo.put(i, computation);
            }
        }
        i += 1;
    }
    return memo.get(input).?;
}

pub fn coinWays(input: u16) !u128 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var memo = std.AutoHashMap(u16, u128).init(allocator);
    defer memo.deinit();
    try memo.put(0, 1);
    var i: u16 = 1;
    while (i <= input) {
        try memo.put(i, 0);
        for (available_coins) |coin| {
            if (i < coin) {
                continue;
            }
            const sub = memo.get(i - coin).?;
            const current = memo.get(i).?;
            try memo.put(i, sub + current);
        }
        i += 1;
    }
    return memo.get(input).?;
}

// test "coins" {
//     const result = try coins(13);
//     try expect(result == 3);
// }

test "coins ways" {
    const result = try coinWays(87);
    try expect(result == 3306149332861088);
}
