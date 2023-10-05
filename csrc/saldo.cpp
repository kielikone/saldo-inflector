#include <stdlib.h>
#include <iostream>
#include "HsFFI.h"

#include "saldo.h"
#include "Saldo_stub.h"


void saldoInit(void){
  int argc = 2;
  char *argv[] = { (char *)"+RTS", (char *)"-A32m", NULL };
  char **pargv = argv;

  // Initialize Haskell runtime
  hs_init(&argc, &pargv);
}

void saldoExit(void){
  hs_exit();
}

char** c_infl(const char* word, int* ret_val) {
    return (char **) infl((char*) word, ret_val);
}

void c_free_arr(char** arr, int len) {
    free_arr(arr, len);
}