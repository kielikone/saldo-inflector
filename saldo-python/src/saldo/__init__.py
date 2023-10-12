from cffi import FFI
from sys import platform
import pathlib

class Saldo:

    def __init__(self):

        self.ffi = FFI()
        self.ffi.cdef("void saldoInit();")
        self.ffi.cdef("void saldoExit();")
        self.ffi.cdef("char** c_infl(char*, char*, char*, int*);")
        self.ffi.cdef("void c_free_arr(char**, int);")

        libdir = pathlib.Path(__file__).parent.resolve().joinpath("lib")
        if platform == "darwin":
            self.lib = self.ffi.dlopen(str(libdir.joinpath("libsaldo.dylib")))
        elif platform == "linux":
            self.lib = self.ffi.dlopen(str(libdir.joinpath("libsaldo.so")))
        else:
            raise ValueError("Unsupported OS")

        self.lib.saldoInit()
    
    def inflect(self, paradigm, word, form):
        n_ret = self.ffi.new("int*")
        result = self.lib.c_infl(paradigm.encode("utf-8"), word.encode("utf-8"), form.encode("utf-8"), n_ret)

        if result == self.ffi.NULL:
            return None

        returnable = []

        for i in range(n_ret[0]):
            returnable.append(self.ffi.string(result[i]).decode("utf-8"))
        
        self.lib.c_free_arr(result, n_ret[0])
        
        return returnable
    
    def __del__(self):
        self.lib.saldoExit()
