const expect = @import("std").testing.expect;

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    // Looks like you can use loops as expressions
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false; // and give default cases in case the loop doesn't break.
}

test "woops" {
    try expect(rangeHasNumber(0, 2, 3) == false); // 3 not in 0..2, thus false
}
