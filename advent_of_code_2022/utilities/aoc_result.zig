const std = @import("std");

pub const AocResult = struct {
    result: []u8,

    pub fn next(self: *AocResult) ?[]const u8 {
        return self.line_it.next();
    }

    pub fn deinit(self: *AocResult, allocator: std.mem.Allocator) void {
        allocator.free(self.result);
        self.* = undefined;
    }
};
