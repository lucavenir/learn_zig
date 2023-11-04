const std = @import("std");
const fibonacci = @import("fibonacci.zig");
const coins = @import("coins.zig");



pub fn main() !void {
    var args = std.process.args();
    _ = args.next();
    const arg = args.next();
    if(arg) |value| {
        const number = try std.fmt.parseUnsigned(u8, value, 10);
        // const n = fibonacci.naiveFibonacci(number);
        // const n = try fibonacci.fibonacci(number);
        const n = try coins.coins(number);
        std.debug.print("Result: {}\n", .{n});
    }
 }
