const expect = @import("std").testing.expect;
const Point3D = struct {
    x: f32,
    y: f32,
    z: f32,
};
const Point4D = struct {
    x: f32,
    y: f32,
    z: f32,
    w: f32 = undefined,
};

test "structs can be allocated and used as you'd expect" {
    const point = Point3D{
        .x = 0,
        .y = 0,
        .z = 0, // unsurprisingly, you can't forget some fields
    };
    _ = point;
    const point2 = Point4D{
        .x = 1,
        .y = 1,
        .z = 1,
        // here, instead, `w` is optional
    };
    _ = point2;
}

const Point2D = struct {
    x: f32,
    y: f32,
    fn originMirror(self: *Point2D) void {
        self.x = -self.x;
        self.y = -self.y;
    }
};

test "mirroring from origin works" {
    var point = Point2D{ .x = 5, .y = 3 };
    point.originMirror();
    try expect(point.x == -5);
    try expect(point.y == -3);
}
