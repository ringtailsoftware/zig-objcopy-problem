OUTPUT_ARCH("riscv")
ENTRY(_start)

BASE_ADDRESS = 0x80000000;

SECTIONS
{
    . = BASE_ADDRESS;
    .text : ALIGN(0) {
        *(.initial_jump);
        *(.text);
    }

    .rodata : ALIGN(0) {
        *(.rodata);
    }

    .data : ALIGN(0) {
        *(.data);
    }

    .bss : ALIGN(0) {
        *(.bss);
    }

    PROVIDE(_bss_start = ADDR(.bss));
    PROVIDE(_bss_end = _bss_start + SIZEOF(.bss));
    PROVIDE(_sstack = _bss_end + 0x100);
}

