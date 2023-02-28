// Draw pyramid using height from a user
// However, note, that here code related to user input are commented out because
// that requires functions from cs50 library that is only available in cs50 codespace

// #include <cs50.h> // available only in cs50 codespace
#include <stdio.h>

// int get_height(void);
void draw_pyramid(int height);
void draw_n_symbols(int n, string symbol);

int main(void)
{
    // get height of the pyramid from the user
    // int height = get_height(); // available only in cs50 codespace
    int height = 7;

    // draw pyramid using height from the user
    draw_pyramid(height);
}

/*
int get_height(void)
{
    int height;
    do
    {
        height = get_int("Give height (integer between 1 and 8): ");
    }
    while (height < 1 || height > 8);

    return height;
}
*/

void draw_pyramid(int height)
{
    int i;

    // draw "height" lines high pyramig by looping through "height" and drawing one row on each iteration
    for (i = 0; i < height; i++)
    {
        // draw each row of the pyramid
        int n_white = height - i - 1;
        int n_bricks = height - n_white;
        int n_space = 2;
        string symbol_space = " ";
        string symbol_brick = "#";

        // draw pyramid row by drawing...
        // white spaces
        draw_n_symbols(n_white, symbol_space);

        // briks
        draw_n_symbols(n_bricks, symbol_brick);

        // space between left and right side
        draw_n_symbols(n_space, symbol_space);

        // briks
        draw_n_symbols(n_bricks, symbol_brick);

        // print new line to switch to the next row
        printf("\n");
    }
}

void draw_n_symbols(int n, string symbol)
{
    int i;
    for (i = 0; i < n; i++)
    {
        printf("%s", symbol);
    }
}