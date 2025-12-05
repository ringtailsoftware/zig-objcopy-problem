pub inline fn println(val: []const u8) void {
    asm volatile ("csrw 0x123, %[arg1]"
        :
        : [arg1] "r" (val.ptr),
    );
}

export fn main() void {
    println("Hello world\x00");
}
