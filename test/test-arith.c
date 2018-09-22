/*
 * Copyright (c) 2018 - Now Herbert Shen <ishbguy@hotmail.com>
 *               All Rights Reserved.
 */

#include <criterion/criterion.h>
#include "../include/arith.h"

Test(cii, test_arith_max) {
    cr_assert(Arith_max(0, -1) == 0, "");
    cr_assert(Arith_max(0, 1) == 1, "");
    cr_assert(Arith_max(-1, -2) == -1, "");
}

Test(cii, test_arith_min) {
    cr_assert(Arith_min(0, -1) == -1, "");
    cr_assert(Arith_min(0, 1) == 0, "");
    cr_assert(Arith_min(-1, -2) == -2, "");
}

/* vim:set ft=c ts=4 sw=4: */
