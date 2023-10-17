#pragma once

extern "C" void saldoInit(void);
extern "C" void saldoExit(void);
extern "C" char** c_infl(const char*, const char*, const char*, uint64_t*);
extern "C" void c_paradigm(char*, char*, uint64_t*, char***, uint64_t**, char***);
extern "C" void c_free_arr(char**, uint64_t);
extern "C" void c_free_int_arr(uint64_t*);