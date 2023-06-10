const aoc1 = @import("aoc1.zig");

pub fn computeAocChallenge(input: u8) ![]const u8 {
    const result = switch (input) {
        1 => aoc1.aoc1(),
        else => AocError.AocNotFound,
    };
    return result;
}

pub const AocError = error{
    AocNotFound,
};
