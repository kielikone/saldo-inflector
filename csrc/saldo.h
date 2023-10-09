#pragma once

extern "C" void saldoInit(void);
extern "C" void saldoExit(void);
extern "C" char** c_infl(const char*, const char*, const char*, int*);
extern "C" void c_free_arr(char**, int);