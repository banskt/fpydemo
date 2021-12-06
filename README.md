# FPyDemo

## About
Demonstration of **packaging** a _command line tool_ written in Python and Fortran.
This minimum working example (MWE) provides implementation of the following features:
  - [x] use native Fortran codes for the shared libraries.    
  - [x] the shared libraries are compiled using F2Py.    
  - [x] use LAPACK routines for linear algebra in the FORTRAN code.    
  - [x] use `mpi4py` for MPI parallelization.    
  - [x] call a third-party Fortran library as `use third_party_library` from the main Fortran library.    

<!--
Packaging the MWE is done with `setuptools.setup()`.
Compiling the CBLAS routines demands system-specific libraries, 
includes, compile flags and macros.
The `system_info` provided by the setuptools 
in [`numpy`](https://github.com/numpy/numpy) package
is a comprehensive source of such information. 
Here, I have used their implementation.
-->

## Installation
**Prerequisites.**
  - any LAPACK library (MKL, OpenBLAS, libFLAME, Atlas, LAPACK (NetLIB))
  - MPI library.

For a quickstart, try:
```
conda install pip git
pip install git+git://github.com/banskt/fpydemo.git
```
Note this will automatically install the required packages. 
If you want to maintain the dependencies using conda,
you can preinstall the dependencies before running `pip install` for `fpydemo`.
```
conda install numpy scipy mpi4py
pip install git+git://github.com/banskt/fpydemo.git
```
You can also clone the repository, change to the cloned directory and install using pip
```
git clone git@github.com:banskt/fpydemo.git
cd fpydemo
pip install .
```
If you are developing, install using the `-e` flag ("editable"). 
It allows real time changes in the code and the package does not need re-installing every time you make a change.
```
pip install -e .
```

## Check installation
If installation finished without error, the `fpydemo` command line tool will become available.
You can check the command line tool using:
```
fpydemo --test # run all tests 
fpydemo -a 3.2 -b 2.1 # print the sum and difference of the two numbers provided by the flags -a and -b
fpydemo -h # help
```
For testing MPI integration run 
```
mpirun -n 8 fpydemo --test
```

## Directory structure
```
$ tree . -I "__pycache__|*.egg-info"

├── configs.ini
├── dev
│   ├── fmath.cpython-39-x86_64-linux-gnu.so
│   ├── fmath.f95
│   ├── fmathmod.f95
│   ├── main.f95
│   └── primes.f95
├── LICENSE
├── MANIFEST.in
├── pyproject.toml
├── README.md
├── setup.py
└── src
    ├── cpuinfo.py
    ├── fpydemo
    │   ├── flibs
    │   │   ├── fmath.f95
    │   │   └── fmathmod.f95
    │   ├── __init__.py
    │   ├── main.py
    │   ├── stats
    │   │   ├── __init__.py
    │   │   ├── mathf2py.py
    │   │   └── tests
    │   │       └── test_mathf2py.py
    │   ├── unittest_tester.py
    │   ├── utils
    │   │   ├── __init__.py
    │   │   ├── logs.py
    │   │   └── project.py
    │   └── version.py
    ├── libfpydemo_fmath.cpython-39-x86_64-linux-gnu.so
    └── system_info.py

```

## Resources
1. Documentations
 - Read details and sources from my other packaging repository [cpydemo](https://github.com/banskt/cpydemo).
2. Example packaing
 - [`jasmcaus/caer`](https://github.com/jasmcaus/caer)
 - [`numpy/numpy`](https://github.com/numpy/numpy)
 - [`mpi4py/mpi4py`](https://github.com/mpi4py/mpi4py)
