import numpy as np
import importlib
from fpydemo.utils import project

def import_with_prefix(module_name):
    prefix = project.libprefix()
    module_name = f"{prefix}_{module_name}"
    return importlib.import_module(module_name)

fmath = import_with_prefix('fmath')
fdriver3 = import_with_prefix('driver3')
farr_handler = import_with_prefix('array_handler')
#import libfpydemo_fmath as fmath

def fsumdiff(a, b):
    x, y = fmath.fmath.fsumdiff(a, b)
    return x, y

def fsumprint(a, b):
    fmath.fmath.fsumprint(a, b)
    return

def optimize_rosenbrock(n = 1000, a = 4.0):
    #fdriver3.rosenbrock(n, a)
    fdriver3.rosenbrock(n, a)
    return


def farray_divide(m, n, a):
    x = np.ones((m, n))
    for i in range(n):
        x[:, i] = a * (i + 1)
    y = np.zeros((m, n))
    y = farr_handler.array_division(x, a, m, n)
    print ("Output array in python =>")
    print (y)
    return
