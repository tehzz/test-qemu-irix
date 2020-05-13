SECTIONS 
{
    .text 0x80000000 : SUBALIGN(0x10)
    {
        BUILD_DIR/src/abs-sqrt.o(.text);
        BUILD_DIR/src/all_tests.o(.text);
        BUILD_DIR/src/andor-assign.o(.text);
        BUILD_DIR/src/complicated-context.o(.text);
        BUILD_DIR/src/custom-return.o(.text);
        BUILD_DIR/src/loop-nested.o(.text);
        BUILD_DIR/src/math-util.o(.text);
        BUILD_DIR/src/nested-inc.o(.text);
        BUILD_DIR/src/rodata-literals.o(.text);
        BUILD_DIR/src/switch.o(.text);
        BUILD_DIR/src/unreachable-return.o(.text);
    }

    .data : SUBALIGN(0x10)
    {
        BUILD_DIR/src/abs-sqrt.o(.data);
        BUILD_DIR/src/all_tests.o(.data);
        BUILD_DIR/src/andor-assign.o(.data);
        BUILD_DIR/src/complicated-context.o(.data);
        BUILD_DIR/src/custom-return.o(.data);
        BUILD_DIR/src/loop-nested.o(.data);
        BUILD_DIR/src/math-util.o(.data);
        BUILD_DIR/src/nested-inc.o(.data);
        BUILD_DIR/src/rodata-literals.o(.data);
        BUILD_DIR/src/switch.o(.data);
        BUILD_DIR/src/unreachable-return.o(.data);
    }

    .rodata : SUBALIGN(0x10)
    {
        BUILD_DIR/src/abs-sqrt.o(.rodata);
        BUILD_DIR/src/all_tests.o(.rodata);
        BUILD_DIR/src/andor-assign.o(.rodata);
        BUILD_DIR/src/complicated-context.o(.rodata);
        BUILD_DIR/src/custom-return.o(.rodata);
        BUILD_DIR/src/loop-nested.o(.rodata);
        BUILD_DIR/src/math-util.o(.rodata);
        BUILD_DIR/src/nested-inc.o(.rodata);
        BUILD_DIR/src/rodata-literals.o(.rodata);
        BUILD_DIR/src/switch.o(.rodata);
        BUILD_DIR/src/unreachable-return.o(.rodata);
    }

    .bss(NOLOAD) : SUBALIGN(0x10)
    {
        BUILD_DIR/src/abs-sqrt.o(.bss);
        BUILD_DIR/src/all_tests.o(.bss);
        BUILD_DIR/src/andor-assign.o(.bss);
        BUILD_DIR/src/complicated-context.o(.bss);
        BUILD_DIR/src/custom-return.o(.bss);
        BUILD_DIR/src/loop-nested.o(.bss);
        BUILD_DIR/src/math-util.o(.bss);
        BUILD_DIR/src/nested-inc.o(.bss);
        BUILD_DIR/src/rodata-literals.o(.bss);
        BUILD_DIR/src/switch.o(.bss);
        BUILD_DIR/src/unreachable-return.o(.bss);
    }

   /* Discard everything not specifically mentioned above. */
   /DISCARD/ :
   {
      *(*);
   }
}
