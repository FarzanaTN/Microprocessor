int main()
{
    unsigned char data;
    char count;
    while (data)
    {
        data = data & (data - 1);
        count++;
    }
}
