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

// paradigm_name_ word_ form_name_qty form_names forms_qty inflected_forms

void c_paradigm(char* paradigm_name, char* word, uint64_t* form_name_qty, char*** form_names, uint64_t** forms_qty, char*** inflected_forms) {
  paradigm(paradigm_name, word, form_name_qty, form_names, forms_qty, inflected_forms);
}

void c_free_arr(char** arr, uint64_t len) {
    free_arr(arr, len);
}

void c_free_int_arr(uint64_t* arr) {
    free_int_arr(arr);
}