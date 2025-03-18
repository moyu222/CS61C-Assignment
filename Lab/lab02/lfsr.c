#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t num = *reg;
    int bit = (num ^ (num>>2) ^ (num>>3) ^ (num>>5)) & 1;
    *reg = ((*reg>>1) & ~(1U<<15)) | (bit<<15);
}

