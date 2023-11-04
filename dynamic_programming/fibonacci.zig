const std = @import("std");
pub fn naiveFibonacci(input: u32) u128 {
    if(input <= 2) {
        return 1;
    }
    return naiveFibonacci(input-1) + naiveFibonacci(input-2);
}

pub fn fibonacci(input: u32) !u128 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    var memo = std.AutoHashMap(u32, u128).init(allocator);
    defer memo.deinit();
    try memo.put(1, 1);
    try memo.put(2, 1);
    var i: u32 = 3;
    while (i <= input) {
        const previous1: u128 = memo.get(i-1).?;
        const previous2: u128 = memo.get(i-2).?;
        try memo.put(i, previous1+previous2);
        i = i + 1;
    }
    
    const result = memo.get(input).?;
    return result;
}