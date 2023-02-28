#include <cs50.h>
#include <stdio.h>

long get_card_number(void);

string check_card_validity(long card_number);
int get_num_array(long, int);
int get_luhn_checksum(long card_number);

int main(void)
{
 long card_number = get_card_number();
 printf("Your card number is: %li\n", card_number);

 printf("Your card is\n%s\n", check_card_validity(card_number));

}


long get_card_number(void)
{
    long card_number;

    do
    {
        // ask for card number
        card_number = get_long("What is your card number: ");
    }
    // allow only positive values
    while (card_number < 0);

    /// todo: other crietria???
    return card_number;
}


string check_card_validity(long card_number)
{
    // get length fof the card number
     int num_length = 0;

     while(card_number)
     {
        int digit = card_number % 10;
        printf("%i\n", digit);
        card_number /= 10;
        num_length++;
     }

     printf("length of card number: %i\n", num_length);

    // go to testing other validity criteria basded on the number length

    // check if valid American Express
    if (num_length == 15)
    {
        // put number to an array to access first digits
        printf("card_number: %li\n", card_number);
        int num_array[15] = {};
        num_array = get_num_array(card_number, 15);
        // printf("1st digit: %d\n", num_array[0]);
        return "might be American Express";
    }

    // check if valid MasterCard
    else if (num_length == 16)
    {
        return "might be MarterCard";
    }

    // check if valid Visa
    else if (num_length == 16 || num_length == 13)
    {
        return "might be Visa";
    }

    // else invalid
    else
    {
        return "INVALID\n";
    }
}

int get_num_array(long card_number, int card_num_len)
{
    // set i to index of last item of the array
    int i = card_num_len - 1;

    // array for card umber digits
    // need to write array size for each case because "variable-sized object may not be initialized"
    int num_array[15] = {};

    // loops card number from end to start
    // save digits into array from end to strat to get them in correct order
    while(card_number)
     {
        int digit = card_number % 10;
        printf("%i\n", digit);
        card_number /= 10;
        num_array[i] = digit;
        i--;
     }

     return num_array;
}

int get_luhn_checksum(long card_number)
{
    // Luhn’s Algorithm to get credit card checksum

    //Multiply every other digit by 2, starting with the number’s second-to-last digit, and then add those products’ digits together.
    // Add the sum to the sum of the digits that weren’t multiplied by 2.
    // If divisible by 10 (i.e. the total modulo 10 is congruent to 0, or simply, the total’s last digit is 0), the number is valid!
    return 1;
}