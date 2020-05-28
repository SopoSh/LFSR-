#include <stdint.h>
#include <stdio.h>
int main(void)
{
    //populate seed
    unsigned long rand = lfsr32(0x5AA5F348); /* Any nonzero start state(seed) will work. */
    printf("1) %lu \n", rand);
    //call the function 20 times for the first twenty 32bit values
    for (int i = 2; i <= 20; i++) {
        rand = lfsr32(rand);
        printf("%d) %lu \n", i, rand);
    }
    return 0;
}
unsigned long lfsr32(unsigned long seed) {   //can run s^32-1 times

    unsigned long lfsr = seed;
    uint32_t  bit;        /* Must be 32bit to allow bit<<31 later in the code */

        /* number of taps are even and relatively prime
        taps: 32 30 26 25; feedback polynomial: x^32 + x^30 + x^26 + x^25 + 1 (maximal-length polynomial for 32 bits)*/
        /*external XOR gates configuration*/
    bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 6) ^ (lfsr >> 7)) & 1;
    lfsr = (lfsr >> 1) | (bit << 31);
    return lfsr;
}


