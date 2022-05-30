import ctypes

mod = ctypes.cdll.LoadLibrary("build/libShow.so")
add = mod.add_c
add.argtypes = (ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int))
add.restype = None

A_list = [1, 2, 3, 4, 3]
B_list = [10, 0, 4, 1, 1]

A = (ctypes.c_int * len(A_list))(*A_list)
B = (ctypes.c_int * len(B_list))(*B_list)

add(A, B)

print(B[0:])