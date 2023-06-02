const print = @import("std").debug.print;

pub fn main() void {
    // apparently you can basically pre-allocate some memory BEFORE doing anything
    // Translated into English, undefined means:
    // "Not a meaningful value. Using this value would be a bug. The value will be unused, or overwritten before being used."
    var x: i32 = undefined; // meaningless values - 0xAA bytes - are written to memory here
    print("{d}\n", .{x}); // depends on architecture, but I got -1431655766
    x = 1;
    print("{d}\n", .{x}); // 1, which is great, no more undefined
    x = undefined; // This basically means "Here, mark this memory as dirty" (e.g. deinit)
    print("{d}\n", .{x}); // -1431655766 again
}
