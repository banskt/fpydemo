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
fsvd_mod = import_with_prefix('fsvd_mod')
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


def fdgemv(X, v1, v2, alpha, beta):
    '''
    return alpha * np.dot(X, v1) + beta * v2
    '''
    nrow, ncol = X.shape
    return farr_handler.sub_dgemv(X, v1, v2, alpha, beta, nrow, ncol)


def farray_divide(X, a):
    '''
    Return X / a 
    where X is an array and a is scalar
    '''
    nrow, ncol = X.shape
    return farr_handler.array_division(X, a, nrow, ncol)


def fsvd(X, method = 'module'):
    nrow, ncol = X.shape
    k = np.min([nrow, ncol])
    if method == 'module':
        U, S, VT = fsvd_mod.fsvd_mod.fsvd_mod_dgesvd(X, k, nrow, ncol)
    elif method == 'subroutine':
        U, S, VT = farr_handler.sub_dgesvd(X, k, nrow, ncol)
    return U, S, VT
