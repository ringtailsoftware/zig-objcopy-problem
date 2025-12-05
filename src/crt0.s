.section .initial_jump , "ax", %progbits
.global _start
.align 4
_start:
la	sp, _sstack
addi	sp,sp,-16
sw	ra,12(sp)
jal	ra, main
li      a5,0    # halt
csrw    0x138,a5
.section .data

