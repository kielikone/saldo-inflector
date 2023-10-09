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

char** c_infl(const char* paradigm, const char* word, const char* form, int* ret_val) {
    // Casts to (char *) are motivated: Haskell won't ever modify these
    return (char **) infl((char*) paradigm, (char*) word, (char*) form, ret_val);
}

void c_free_arr(char** arr, int len) {
    free_arr(arr, len);
}