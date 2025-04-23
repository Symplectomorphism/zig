// models/user.zig
const std = @import("std");

pub const MAX_POWER = 100_000;

pub const User = struct { 
    power: u64 = 0,
    name: []const u8,

    pub const SUPER_POWER = 9000;

    pub fn init(name: []const u8, power: u64) User {
        return .{
            .name = name,
            .power = power,
        };
    }

    pub fn diagnose(user: User) void {
        if (user.power >= SUPER_POWER) {
            std.debug.print("it's over {d}!!!\n", .{SUPER_POWER});
        }
    }
};
