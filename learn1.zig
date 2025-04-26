const std = @import("std");

pub fn main() void {
    const h = [_]u32{1, 2, 3, 4, 5};
    const n: u32 = 3;

    const slice = h[0..5];

    // std.debug.print("{any}", .{@TypeOf(h)});
    std.debug.print("{}\n", .{ contains(h[1..4], n) });
    std.debug.print("{}\n", .{ eql(u32, h[1..4], slice) });

    for (0..10) |i| {
        std.debug.print("Iteration: {d}\n", .{i});
    }

    std.debug.print("{?}\n", .{ indexOf(h[1..4], n+2) });

    const src: []const u8 = "Goku \\ Pentel";
    var escape_count: usize = 0;
    // {
    //     var i: usize = 0;
    //     while (i < src.len) {
    //         // backslash is used as an escape charcter, thus we need to escape it...
    //         // with a backslash.
    //         if (src[i] == '\\') {
    //             i += 2;
    //             escape_count += 1;
    //         } else {
    //             i += 1;
    //         }
    //     }
    //     std.debug.print("How many: {d}\n", .{i});
    // }
    {
        var i: usize = 0;
        while (i < src.len) : (i += 1) {
            if (src[i] == '\\') {
                // +1 here, and +1 above == +2
                i += 1;
                escape_count += 1;
            }
        }
        std.debug.print("How many: {d}\n", .{i});
    }

    outer: for (1..10) |i| {
        for (i..10) |j| {
            if (i * j > (i+1 + j+j)) continue :outer;
            std.debug.print("{d} + {d} > {d} * {d}\n", .{i+i, j+j, i, j});
        }
    }

    // const personality_analysis = personality(5, 4);
    const tea_vote = 5;
    const coffee_vote = 4;
    const personality_analysis = blk: {
        if (tea_vote > coffee_vote) break :blk "sane";
        if (tea_vote == coffee_vote) break :blk "whatever";
        if (tea_vote < coffee_vote) break :blk "dangerous";
    };
    std.debug.print("{s}\n", .{personality_analysis});
}

fn indexOf(haystack: []const u32, needle: u32) ?usize {
    for (haystack, 0..) |value, i| {
        if (needle == value) {
            return i;
        }
    }
    return null;
}

fn contains(haystack: []const u32, needle: u32) bool {
    for (haystack) |value| {
        if (needle == value) {
            return true;
        }
    }
    return false;
}

pub fn eql(comptime T: type, a: []const T, b: []const T) bool {
    // if they aren't the same length, they can't be equal
    if (a.len != b.len) return false;

    for (a, b) |a_elem, b_elem| {
        if (a_elem != b_elem) return false;
    }

    return true;
}

pub fn personality(tea_vote: u32, coffee_vote: u32) []const u8 {
    const hop = blk: {
        if (tea_vote > coffee_vote) break :blk "sane";
        if (tea_vote == coffee_vote) break :blk "whatever";
        if (tea_vote < coffee_vote) break :blk "dangerous";
    };
    return hop;
}
