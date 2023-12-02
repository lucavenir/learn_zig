const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;
const file_utils = @import("utilities/files.zig");
const aoc = @import("utilities/aoc_result.zig");

pub fn aoc2() !aoc.AocResult(u128) {
    var gpa = std.heap.GeneralPurposeAllocator(.{ .safety = true }){};
    const allocator = gpa.allocator();

    const buffer = try file_utils.readFile(allocator, "day_2/input.txt");
    defer allocator.free(buffer);

    const total_score = try aoc21(buffer);
    const total_correct_score = try aoc22(buffer);

    return aoc.AocResult(u128){
        .first_star = total_score,
        .second_star = total_correct_score,
    };
}

const GameChoice = enum {
    scissors,
    paper,
    rock,

    pub fn compare(self: GameChoice, other: GameChoice) GameOutcome {
        if (self == other) return GameOutcome.draw;

        const me = @intFromEnum(self);
        const they = @intFromEnum(other);
        if ((me + 1) % 3 == they) return GameOutcome.win;

        return GameOutcome.lose;
    }

    pub fn baseScore(self: GameChoice) u4 {
        return switch (self) {
            GameChoice.scissors => 3,
            GameChoice.paper => 2,
            GameChoice.rock => 1,
        };
    }
};

const GameOutcome = enum(u4) {
    win = 6,
    draw = 3,
    lose = 0,

    pub fn computeChoice(self: GameOutcome, other: GameChoice) GameChoice {
        const add: u4 = switch (self) {
            GameOutcome.draw => 0,
            GameOutcome.lose => 1,
            GameOutcome.win => 2,
        };
        const o = @intFromEnum(other);
        const result = (o + add) % 3;
        return @enumFromInt(result);
    }
};

test "compute choice" {
    const win = GameOutcome.win;
    const lose = GameOutcome.lose;
    const draw = GameOutcome.draw;

    const win_with_scissors = win.computeChoice(GameChoice.paper);
    try expect(win_with_scissors == GameChoice.scissors);
    const win_with_rock = win.computeChoice(GameChoice.scissors);
    try expect(win_with_rock == GameChoice.rock);
    const win_with_paper = win.computeChoice(GameChoice.rock);
    try expect(win_with_paper == GameChoice.paper);

    const lose_with_scissors = lose.computeChoice(GameChoice.rock);
    try expect(lose_with_scissors == GameChoice.scissors);
    const lose_with_rock = lose.computeChoice(GameChoice.paper);
    try expect(lose_with_rock == GameChoice.rock);
    const lose_with_paper = lose.computeChoice(GameChoice.scissors);
    try expect(lose_with_paper == GameChoice.paper);

    const draw_with_scissors = draw.computeChoice(GameChoice.scissors);
    try expect(draw_with_scissors == GameChoice.scissors);
    const draw_with_rock = draw.computeChoice(GameChoice.rock);
    try expect(draw_with_rock == GameChoice.rock);
    const draw_with_paper = draw.computeChoice(GameChoice.paper);
    try expect(draw_with_paper == GameChoice.paper);
}

fn aoc21(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n");
    var score: u128 = 0;
    while (iterator.next()) |line| {
        const opponent = line[0];
        const opponent_choice = switch (opponent) {
            'A' => GameChoice.rock,
            'B' => GameChoice.paper,
            'C' => GameChoice.scissors,
            else => unreachable,
        };

        const player = line[2];
        const player_choice = switch (player) {
            'X' => GameChoice.rock,
            'Y' => GameChoice.paper,
            'Z' => GameChoice.scissors,
            else => unreachable,
        };

        const outcome = player_choice.compare(opponent_choice);

        score += player_choice.baseScore() + @intFromEnum(outcome);
    }

    return score;
}

fn aoc22(buffer: []const u8) !u128 {
    var iterator = std.mem.splitSequence(u8, buffer, "\n");
    var score: u128 = 0;
    while (iterator.next()) |line| {
        const opponent = line[0];
        const opponent_choice = switch (opponent) {
            'A' => GameChoice.rock,
            'B' => GameChoice.paper,
            'C' => GameChoice.scissors,
            else => unreachable,
        };

        const player = line[2];
        const player_outcome = switch (player) {
            'X' => GameOutcome.lose,
            'Y' => GameOutcome.draw,
            'Z' => GameOutcome.win,
            else => unreachable,
        };

        score += player_outcome.computeChoice(opponent_choice).baseScore() + @intFromEnum(player_outcome);
    }

    return score;
}
