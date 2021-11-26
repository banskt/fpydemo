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


if __name__ == '__main__':
    tester.main()
