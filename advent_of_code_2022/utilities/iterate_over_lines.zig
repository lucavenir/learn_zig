const std = @import("std");
const t = std.testing;

pub fn iterateOverLines(bytes: []const u8) std.mem.SplitIterator(u8, .sequence) {
    return std.mem.splitSequence(u8, bytes, "\n");
}

test "iterate over three lines" {
    const something = "my\nthree\nlines";
    var iterator = iterateOverLines(something);

    var i: u8 = 0;
    if (iterator.next()) |line| {
        try t.expectEqualStrings(line, "my");
        i += 1;
    }
    if (iterator.next()) |line| {
        try t.expectEqualStrings(line, "three");
        i += 1;
    }
    if (iterator.next()) |line| {
        try t.expectEqualStrings(line, "lines");
        i += 1;
    }

    try t.expect(i == 3);
}
