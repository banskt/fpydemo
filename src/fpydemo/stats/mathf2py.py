import numpy as np
import importlib
from fpydemo.utils import project

def import_with_prefix(module_name):
    prefix = project.libprefix()
    module_name = f"{prefix}_{module_name}"
    return importlib.import_module(module_name)

fmath = import_with_prefix('fmath')
    
#import libfpydemo_fmath as fmath

def fsumdiff(a, b):
    x, y = fmath.fmath.fsumdiff(a, b)
    return x, y

def fsumprint(a, b):
    fmath.fmath.fsumprint(a, b)
    return
