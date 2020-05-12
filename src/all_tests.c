#include "abs-sqrt.h"
#include "andor-assign.h"
#include "complicated-context.h"
#include "custom-return.h"
#include "loop-nested.h"
#include "nested-inc.h"
#include "rodata-literals.h"
#include "switch.h"
#include "unreachable_return.h"

void test_frame() {
    struct SomeStruct sstest;
    union SomeUnion sutest;
    unsigned int i;

    abs_sqrt_test(1.0);
    andor_assign(1,2,3,4);
    complicated_context(&sstest, 1, sutest);
    custom_return();
    loop_nested(100);
    rodata_literals();
    switch_test(13);
    for (i = 0; i < 100; i++) {
        switch_test(i);
    }
    unreachable_return();

    nested_inc();

    return;
}
