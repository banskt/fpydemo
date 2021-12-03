import numpy as np
import argparse
import sys
import unittest
import mpi4py

mpi4py.rc.initialize = False
mpi4py.rc.finalize = False
from mpi4py import MPI

from fpydemo.stats import mathf2py
from fpydemo.utils.logs import MyLogger
from fpydemo.stats.tests.test_mathf2py import TestMathF2Py
from fpydemo.unittest_tester import UnittestTester
from fpydemo.utils import project

mlogger = MyLogger(__name__)

def parse_args():
    parser = argparse.ArgumentParser(description='FPyDemo: demonstration of packaging a command line tool written in Python and Fortran')
    parser.add_argument('-a',
                        type = float,
                        dest = 'val_a',
                        metavar = 'FLOAT',
                        help = 'first number')
    parser.add_argument('-b',
                        type = float,
                        dest = 'val_b',
                        metavar = 'FLOAT',
                        help = 'second number')
    parser.add_argument('--test',
                        dest = 'test',
                        action = 'store_true',
                        help = 'Perform unit tests')
    parser.add_argument('--lbfgsb',
                        dest = 'do_lbfgsb',
                        action = 'store_true',
                        help = 'Perform L-BFGS-B optimization of Rosenbrock')
    parser.add_argument('--array-check',
                        dest = 'do_array_check',
                        action = 'store_true',
                        help = 'Perform array operations with Fortran using Numpy arrays')
    parser.add_argument('-n',
                        type = int,
                        dest = 'dim_rosen',
                        default = 25,
                        metavar = 'INT',
                        help = 'dimension of Rosenbrock function')
    parser.add_argument('-r', 
                        type = float,
                        dest = 'param_rosen',
                        default = 4.0,
                        metavar = 'FLOAT',
                        help = 'parameter for Rosenbrock function')
    parser.add_argument('--version',
                        dest = 'version',
                        action = 'store_true',
                        help = 'Print version number')
    res = parser.parse_args()
    return res


def target(opts):
    print (f"The input values are {opts.val_a} and {opts.val_b}")
    x, y = mathf2py.fsumdiff(opts.val_a, opts.val_b)
    print (f"Sum: {x}")
    print (f"Diff: {y}")
    print (f"Print sum from Fortran submodule:")
    mathf2py.fsumprint(opts.val_a, opts.val_b)
    return


def run_lbfgsb(opts):
    mathf2py.optimize_rosenbrock(n = opts.dim_rosen, a = opts.param_rosen)
    return


def run_arraydivision(opts):
    mathf2py.farray_divide(4, 5, opts.val_a)
    return


def run_unittests():
    tester = UnittestTester(TestMathF2Py)
    tester.execute()
    del tester
    return


def main():

    MPI.Init()
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    ncore = comm.Get_size()

    if rank == 0:
        mlogger.info("Using MPI in {:d} cores".format(ncore))
        opts = parse_args()
    else:
        mlogger.info("Reporting from node {:d}".format(rank))
        opts = None

    opts = comm.bcast(opts, root = 0)
    comm.barrier()
    if rank != 0:
        option_string = ', '.join([f'{k}: {v}' for k, v in vars(opts).items()])
        mlogger.info("Node {:d}, Options: {:s}".format(rank, option_string))

    if rank == 0:
        if opts.test:
            run_unittests()
        elif opts.version:
            print ("FPyDemo version {:s}".format(project.version()))
        elif opts.do_lbfgsb:
            run_lbfgsb(opts)
        elif opts.do_array_check:
            run_arraydivision(opts)
        else:
            target(opts)
    MPI.Finalize()


if __name__ == "__main__":
    main()
