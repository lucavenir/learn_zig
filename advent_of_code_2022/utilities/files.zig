const std = @import("std");
const t = std.testing;
const file_system = std.fs;
const io = std.io;

// TODO change this function so that it supprts buffering
pub fn readFile(allocator: std.mem.Allocator, file_name: []const u8) ![]const u8 {
    // Opens our file
    const file = try file_system.cwd().openFile(file_name, .{ .mode = .read_only });
    defer file.close();

    // Read the file
    const file_buffer = try file.readToEndAlloc(allocator, 65536);
    errdefer allocator.free(file_buffer);

    return file_buffer;
}

test "can't open a file that doesn't exist" {
    const expectedError = file_system.File.OpenError.FileNotFound;
    const invocation = readFile(t.allocator, "./foobar.zig");

    try t.expectError(expectedError, invocation);
}

// test "reads a file" {
//     const contents = try readFile(t.allocator, "./file");
//     defer t.allocator.free(contents);

//     try t.expectEqualStrings(contents, "this is a file.\n");
// }
