from cffi import FFI
from sys import platform
import pathlib

class Saldo:

    def __init__(self):

        self.ffi = FFI()
        self.ffi.cdef("void saldoInit();")
        self.ffi.cdef("void saldoExit();")
        self.ffi.cdef("char** c_infl(char*, char*, char*, uint64_t*);")
        self.ffi.cdef("void c_paradigm(char*, char*, uint64_t*, char***, uint64_t**, char***);")
        self.ffi.cdef("void c_free_int_arr(uint64_t*);")
        self.ffi.cdef("void c_free_arr(char**, uint64_t);")

        libdir = pathlib.Path(__file__).parent.resolve().joinpath("lib")
        if platform == "darwin":
            self.lib = self.ffi.dlopen(str(libdir.joinpath("libsaldo.dylib")))
        elif platform == "linux":
            self.lib = self.ffi.dlopen(str(libdir.joinpath("libsaldo.so")))
        else:
            raise ValueError("Unsupported OS")

        self.lib.saldoInit()
    
    def inflect(self, paradigm, word, form):
        n_ret = self.ffi.new("uint64_t*")
        result = self.lib.c_infl(paradigm.encode("utf-8"), word.encode("utf-8"), form.encode("utf-8"), n_ret)

        if result == self.ffi.NULL:
            return None

        returnable = []

        for i in range(n_ret[0]):
            returnable.append(self.ffi.string(result[i]).decode("utf-8"))
        
        self.lib.c_free_arr(result, n_ret[0])
        
        return returnable
    
    def paradigm(self, paradigm_name, word):

        # Allocate caller-allocated structures

        form_names_qty = self.ffi.new("uint64_t*") # Gets GC'd

        # Allocate handles to callee-allocated structures

        form_names = self.ffi.new("char***")
        form_names[0] = self.ffi.NULL

        forms_qty = self.ffi.new("uint64_t**")
        forms_qty[0] = self.ffi.NULL

        inflected_forms = self.ffi.new("char***")
        inflected_forms[0] = self.ffi.NULL

        # Call

        self.lib.c_paradigm(paradigm_name.encode("utf-8"), word.encode("utf-8"), form_names_qty, form_names, forms_qty, inflected_forms)

        if form_names_qty[0] == -1:

            # GC takes care of deallocating our pointers

            return None

        else:

            # Extract result

            result = []
            form_value_idx = 0

            for i in range(form_names_qty[0]):
                name = self.ffi.string(form_names[0][i]).decode("utf-8")
                values = []
                for _ in range(forms_qty[0][i]):
                    values.append(self.ffi.string(inflected_forms[0][form_value_idx]).decode("utf-8"))
                    form_value_idx += 1
                result.append((name, values))
            
            # Deallocate callee-allocated structures

            self.lib.c_free_int_arr(forms_qty[0])
            self.lib.c_free_arr(inflected_forms[0], form_value_idx)
            self.lib.c_free_arr(form_names[0], form_names_qty[0])

            # form_names_qty gets GC'd

            return result



    
    def __del__(self):
        self.lib.saldoExit()
