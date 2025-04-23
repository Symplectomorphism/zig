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
}

// pub fn main() void {
//     const sum = add(8999, 2);
//     std.debug.print("8999 + 2 = {d}\n", .{sum});
// }

// Function parameters are constants!
fn add(a: i64, b: i64) i64 {
    return a + b;
}
