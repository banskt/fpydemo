program fmath
    use fmathmod
    implicit none
    real :: a, b
    real :: s
    real :: d

    print *, 'Please enter first number: '
    read (*, *) a
    print *, 'Please enter second number: '
    read (*, *) b
    call fsum(a, b, s)
    call fdiff(a, b, d)
    print *, 'Sum is: ', s
    print *, 'Difference is: ', d

end program fmath
