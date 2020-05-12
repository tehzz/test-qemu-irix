#include "rodata-literals.h"
#include "custom-return.h"

void nested_inc(void) {
    rodata_literals();
    custom_return;

    return;
}
