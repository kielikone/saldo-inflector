from cffi import FFI

class Saldo:

    def __init__(self, saldopath):

        self.ffi = FFI()
        self.ffi.cdef("void saldoInit();")
        self.ffi.cdef("void saldoExit();")
        self.ffi.cdef("char** c_infl(char*, int*);")
        self.ffi.cdef("void c_free_arr(char**, int);")

        self.lib = self.ffi.dlopen("capp/libsaldo.dylib")

        self.lib.saldoInit()
    
    def inflect(self, s):
        n_ret = self.ffi.new("int*")
        result = self.lib.c_infl(s.encode("utf-8"), n_ret)

        if result == self.ffi.NULL:
            return None

        returnable = []

        for i in range(n_ret[0]):
            returnable.append(self.ffi.string(result[i]).decode("utf-8"))
        
        self.lib.c_free_arr(result, n_ret[0])
        
        return returnable
    
    def __del__(self):
        self.lib.saldoExit()