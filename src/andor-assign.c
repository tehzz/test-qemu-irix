int aoa_foo(int arg) {
    return arg + 1;
}

int andor_assign(int a, int b, int c, int d) {
    int var1;
    int var2;
    int ret;

    var1 = a + b;
    var2 = b + c;

    ret = 0;
    if (var1 || var2 || (var2 = aoa_foo(var2)) || d) {
        ret = 1;
    }
    return ret;
}
