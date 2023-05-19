const expect = @import("std").testing.expect;
var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    defer problems += 1;
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 100);
        return;
    };
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}
