int main(int argc, char *argv[])
{
    int x, y;
    x = 1;
    switch (x)
    {
    case 0:
        y = 10;
        break;
    case 1:
        y = 11;
        break;
    default:
        y = 13;
        break;
    }
    return y;
}