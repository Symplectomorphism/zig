const std = @import("std");
const user = @import("models/user.zig");
const User = user.User;
const MAX_POWER = user.MAX_POWER;

// This code won't compile if `main` isn't `pub` (public)
pub fn main() void {
    const myuser: User = User{
        .power = 9001,
        .name = "Goku",
    };

    const otheruser = User.init("iCute", 9000);

    myuser.diagnose();
    // The above is syntctical sugar for:
    User.diagnose(myuser);

    otheruser.diagnose();

    std.debug.print("{s}'s power is {d}\n", .{myuser.name, myuser.power});
    std.debug.print("{s}'s power is {d}\n", .{otheruser.name, otheruser.power});

    const a = [_]i32{1, 2, 3, 4, 5};

    // because `end` is declared var, it isn't compile-time known
    var end: usize = 3;

    // but because it's ` var` we need to mutate it, else the compiler
    // will insist we make it `const`.
    end += 1;

    const b = a[1..end];
    std.debug.print("b is: {any}\n", .{b});
    std.debug.print("{any}\n\n", .{@TypeOf(b)});

    var aa = [_]i32{1, 2, 3, 4, 5};
    // var end: usize = 3;
    // end += 1;
    const bb = aa[1..end];
    bb[2] = 99;
    // bb = bb[1..];

    if (std.ascii.eqlIgnoreCase("GET", "GET")) {
        std.debug.print("Checking if statements\n", .{});
    }

    std.debug.print("Anniversary name: {s}\n", .{anniversaryName(1)});
    std.debug.print("Arrival time: {s}\n", .{arrivalTimeDisc(4, true)});
}

// pub fn main() void {
//     const sum = add(8999, 2);
//     std.debug.print("8999 + 2 = {d}\n", .{sum});
// }

// Function parameters are constants!
fn add(a: i64, b: i64) i64 {
    return a + b;
}

fn anniversaryName(years_married: u16) []const u8 {
    switch (years_married) {
        1 => return "paper",
        2 => return "cotton",
        3 => return "leather",
        4 => return "flower",
        5 => return "wood",
        6 => return "sugar",
        else => return "no more gifts for you",
    }
}

fn arrivalTimeDisc(minutes: u16, is_late: bool) []const u8 {
    switch (minutes) {
        0 => return "arrived",
        1, 2 => return "soon",
        3...5 => return "no more than 5 minutes",
        else => {
            if (!is_late) {
                return "sorry, it'll be a while";
            }
            // todo, something is very wrong
            return "never";
        }
    }
}
