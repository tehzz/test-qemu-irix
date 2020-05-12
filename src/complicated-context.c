#include "complicated-context.h"

int globali;
float globalf;

void func_decl(void) {
    globali = 0;
}

short complicated_context(struct SomeStruct *arg, unsigned char should, union SomeUnion union_arg, ...)
{
    // This comment should be stripped
    /* This comment should also be stripped */
    /**
     * Even multi-line comments.
     */
    union SomeUnion stack_union;
    stack_union.double_innerfield = union_arg.double_innerfield;

    if (should)
    {
        globalf = arg->float_field;
        globali = arg->int_field;
        arg->data_field.char_innerfield = should;
    }
    else
    {
        arg->pointer_field = (void *)0;
        arg->data_field.double_innerfield = 0.;
    }
    return (short)arg->int_field;
}
