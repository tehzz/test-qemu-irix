typedef unsigned short u16;
u16 cr_foo(int x);

int cr_glob;

int custom_return(void) {
    unsigned short temp = cr_foo(1);
    if (temp != 0) {
        return temp;
    }

    if (cr_glob != 123)
        return cr_foo(2);
    else
        return cr_foo(3);
}

u16 cr_foo(int x) { return 1; }
