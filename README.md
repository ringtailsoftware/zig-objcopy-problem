(update: This /is/ a zig bug, https://ziggit.dev/t/addobjcopy-producing-zero-padding-at-start-of-binary/13384)

Demonstration of problem with zig 0.15.2 adding invalid padding in `addObjCopy()`

    zig version
    0.15.2

    zig build

The build produces an ELF binary and a raw binary:

    file zig-out/bin/hello
    zig-out/bin/hello: ELF 32-bit LSB executable, UCB RISC-V, soft-float ABI, version 1 (SYSV), statically linked, stripped

    file zig-out/bin/hello.bin
    zig-out/bin/hello.bin: data

The binary is zero padded at the beginning. The presence and length of this padding seems to come and go depending on the program size.

    xxd zig-out/bin/hello.bin
    00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000020: 0000 0000 0000 0000 0000 0000 1701 0000  ................
    00000030: 1301 9113 1301 01ff 2326 1100 ef00 c000  ........#&......
    00000040: 9307 0000 7390 8713 3705 0080 1305 c502  ....s...7.......
    00000050: 7310 3512 6780 0000 4865 6c6c 6f20 776f  s.5.g...Hello wo
    00000060: 726c 6400 00                             rld..

Using GNU objcopy on zig's ELF file to create a binary works fine.

    riscv64-unknown-elf-objcopy zig-out/bin/hello -O binary out.bin

    xxd out.bin
    00000000: 1701 0000 1301 9113 1301 01ff 2326 1100  ............#&..
    00000010: ef00 c000 9307 0000 7390 8713 3705 0080  ........s...7...
    00000020: 1305 c502 7310 3512 6780 0000 4865 6c6c  ....s.5.g...Hell
    00000030: 6f20 776f 726c 6400 00                   o world..


