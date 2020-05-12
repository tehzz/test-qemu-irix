float a;
double b, c;
const char *d;

void rodata_literals(void) {
    a = 1.2f;
    b = 13.0;
    c = 1.4e10;
    d = "\"hello\"\n\x01";
    "world  /* comment */ #";
}
