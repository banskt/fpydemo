import os
import unittest
import numpy as np
import logging

from fpydemo.stats import mathf2py
from fpydemo.utils.logs import MyLogger
import fpydemo.unittest_tester as tester

mlogger = MyLogger(__name__, level = logging.DEBUG)

class TestMathF2Py(unittest.TestCase):

    def __init__(self, *args, **kwargs):
        super(TestMathF2Py, self).__init__(*args, **kwargs)
        self.a = 3.5 
        self.b = 2.4 


    def test_fsumdiff(self):
        x, y = mathf2py.fsumdiff(self.a, self.b)
        mlogger.info(f"{self.a} + {self.b} = {x}")
        mlogger.info(f"{self.a} - {self.b} = {y}")
        self.assertAlmostEqual(x, self.a + self.b, places = 3, msg = "Error in mathf2py.fsumdiff")
        self.assertAlmostEqual(y, self.a - self.b, places = 3, msg = "Error in mathf2py.fsumdiff")


    def test_array(self):
        nrow = 3
        ncol = 4
        alpha = 4.5
        nelem = nrow * ncol
        X = np.linspace(0, 1, nelem).reshape(nrow, ncol)
        res = mathf2py.farray_divide(X * alpha, alpha) 
        success = np.allclose(res, X)
        self.assertTrue(success, msg = "Error in mathf2py.farray_divide")
        mlogger.info (f"Pass: array handling between Fortran and Python")


    def test_fdgemv(self):
        nrow = 30
        ncol = 40 
        alpha = 2.0 
        beta  = 3.0 
        nelem = nrow * ncol
        A = np.linspace(0, 1, nelem).reshape(nrow, ncol)
        X = np.linspace(1, ncol, ncol)
        Y = np.ones(nrow)
        res_py  = alpha * np.dot(A, X) + beta * Y 
        res_f   = mathf2py.fdgemv(A, X, Y, alpha, beta)
        success = np.allclose(res_py, res_f)
        self.assertTrue(success, msg = "Error in mathf2py.fdgemv")
        mlogger.info (f"Pass: dgemv with matrix of size {nrow} x {ncol}")


    def test_fsvd_subroutine(self):
        self.mathf2py_fsvd(method = 'subroutine')

    def test_fsvd_module(self):
        self.mathf2py_fsvd(method = 'module')

    def mathf2py_fsvd(self, method = 'module'):
        nrow = 30
        ncol = 40
        A = np.random.normal(0, 1, size = nrow * ncol).reshape(nrow, ncol)
        np_U, np_S, np_VT = np.linalg.svd(A, full_matrices = False)
        U, S, VT = mathf2py.fsvd(A, method = method)
        check_sv = np.allclose(S, np_S)
        check_reconstruct = np.allclose(A, np.dot(U, np.dot(np.diag(S), VT)))
        self.assertTrue(check_sv, msg = "SVD do not match numpy.linalg.svd")
        self.assertTrue(check_reconstruct, msg = "SVD from f2py cannot reconstruct original matrix")
        mlogger.info(f"Pass: dgesvd FORTRAN LAPACK using {method} call")


if __name__ == '__main__':
    tester.main()
