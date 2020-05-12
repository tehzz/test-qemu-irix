int switch_glob;

int switch_test(int x) {
    switch (x) {
    case 1:
        return x*x;
    case 2:
        x--;
        // fallthrough
    case 3:
        return x*2;
    case 4:
        x++;
        break;
    case 6:
    case 7:
        x *= 2;
        break;
    default:
        x /= 2;
        break;
    }
    switch_glob = x;
    return 2;
}
