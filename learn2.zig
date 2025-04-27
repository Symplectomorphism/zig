const std = @import("std");

pub fn main() !void {
    const myStatus = Status.ok;
    const myStage = Stage.confirmed;

    std.debug.print("{any}\n", .{myStatus});
    std.debug.print("{}\n\n", .{myStage.isComplete()});

    const n = Number{.int = 32};
    std.debug.print("{d}\n", .{n.int});

    const ts = Timestamp{.unix = 1693278411};
    std.debug.print("{d}\n", .{ts.seconds()});

    const home: ?[]const u8 = null;
    var name: ?[]const u8 = "Leto";

    name = "Leto";

    std.debug.print("{s}\n", .{name.?});

    if (home) |h| {
        // h is a []const u8
        // we have a home value
        std.debug.print("{s}\n", .{h.?});
    } else {
        // we don't have a home value
        const char = "d";
        std.debug.print("{c}\n", .{char});
    }


    var pseudo_uuid: [16]u8 = undefined;
    std.crypto.random.bytes(&pseudo_uuid);

    // This is the line you want to focus on
    const save = (try Save.loadLast()) orelse Save.blank();
    std.debug.print("{any}\n", .{save});

    // return OpenError.AccessDenied;
    return error.AccessDenied;
}

// could be "pub"
const Status = enum {
    ok,
    bad,
    unknown,
};

const Stage = enum {
    validate,
    awaiting_confirmation,
    confirmed,
    err,

    fn isComplete(self: Stage) bool {
        return self == .confirmed or self == .err;
    }
};


const Number = union {
    int: i64,
    float: f64,
    nan: void,
};


const TimestampType = enum {
    unix,
    datetime,
};

const Timestamp = union(TimestampType) {
    unix: i32,
    datetime: DateTime,

    const DateTime = struct {
        year: u16,
        month: u8, 
        day: u8,
        hour: u8,
        minute: u8,
        second: u8,
    };

    fn seconds(self: Timestamp) u16 {
        switch (self) {
            .datetime => |dt| return dt.second,
            .unix => |ts| {
                const seconds_since_midnight: i32 = @rem(ts, 86400);
                return @intCast(@rem(seconds_since_midnight, 60));
            },
        }
    }
};


pub const Save = struct {
    lives: u8,
    level: u16,

    pub fn loadLast() !?Save {
        // todo
        return null;
    }

    pub fn blank() Save {
        return .{
            .lives = 3,
            .level = 1,
        };
    }
};


// Like our strcut in Part 1, OpenError can be marked as "pub"
// to make it accessible outside of the file it is defined in
const OpenError = error {
    AccessDenied,
    NotFound,
};
