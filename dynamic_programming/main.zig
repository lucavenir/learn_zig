const std = @import("std");
const fibonacci = @import("fibonacci.zig");



pub fn main() !void {
    var args = std.process.args();
    _ = args.next();
    const arg = args.next();
    if(arg) |value| {
        const number = try std.fmt.parseUnsigned(u8, value, 10);
        // const fibonacci = fibonacci.naiveFibonacci(number);
        const f = try fibonacci.fibonacci(number);
        std.debug.print("Fibonacci result: {}\n", .{f});
    }
 }
