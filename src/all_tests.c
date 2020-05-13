#include "abs-sqrt.h"
#include "andor-assign.h"
#include "complicated-context.h"
#include "custom-return.h"
#include "loop-nested.h"
#include "math-util.h"
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

    {
        Mat4 mtx;
        Mat4 mtx2;
        Vec3f t = {0.0, 1.0, 0.0};
        mtxf_identity(mtx);
        mtxf_identity(mtx2);
        mtxf_translate(mtx, t);
        mtxf_mul(mtx2, mtx, mtx2);
    }

    return;
}
