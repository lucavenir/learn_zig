const expect = @import("std").testing.expect;
const BikeType = enum(u16) {
    used = 0,
    new = 2,
    vintage = 4,

    pub fn isOnMarket(self: BikeType) bool {
        return self == BikeType.new or self == BikeType.used;
    }

    var bikeTypes: u32 = 3;
};

test "enums have internal indexing, namely tag types" {
    try expect(@enumToInt(BikeType.new) == 2);
}

test "vintage bikes are not on the market" {
    try expect(BikeType.vintage.isOnMarket() == false);
    // apparently this is *also* valid syntax?
    try expect(BikeType.isOnMarket(.vintage) == false);
}

test "there are three bike types atm, but that can be changed later on" {
    try expect(BikeType.bikeTypes == 3);
    BikeType.bikeTypes += 1;
    try expect(BikeType.bikeTypes == 4);
}
