const std = @import("std");
const t = std.testing;
const p = std.process;

pub fn getFirstArg() !u8 {
    var args = p.args();
    _ = args.next();
    const arg = args.next();
    if (arg) |value| {
        return std.fmt.parseUnsigned(u8, value, 10) catch CliError.InvalidInteger;
    }
    return CliError.ArgumentNotFound;
}

pub const CliError = error{
    ArgumentNotFound,
    InvalidInteger,
};
