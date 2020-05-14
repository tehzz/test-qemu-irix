#ifndef COMPLICATED_CONTEXT_H
#define COMPLICATED_CONTEXT_H

union SomeUnion {
    double double_innerfield;
    char char_innerfield;
};

enum SomeEnum
{
    FIRST_ELEM = 1,
    SECOND_ELEM = 2
};

struct SomeBitfield {
    char char_bit : 1;
    int int_bit : 4;
    short short_bit : 16;
    char : 0;
    unsigned char unsigned_bit : 7;
};

struct SomeStruct
{
    int int_field;
    float float_field;
    void *pointer_field;
    union SomeUnion data_field;
    enum SomeEnum enum_field;
    long long long_long_field;
    struct SomeBitfield bitfield_field;
    int array_arithmetic_1[1 + 1];
    int array_arithmetic_2[2 - 1];
    int array_arithmetic_3[1 * 1];
    int array_arithmetic_4[1 << 1];
    int array_arithmetic_5[2 >> 1];
};

short complicated_context(struct SomeStruct *arg, unsigned char should, union SomeUnion union_arg, ...);

#endif
