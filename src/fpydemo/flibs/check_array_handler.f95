program check_array_handler
    implicit none
    integer, parameter :: nrow = 4, ncol = 5, dp = kind(1.0d0)
    real(dp) :: x(nrow, ncol), y(nrow, ncol)
    integer :: xshape(2)
    integer :: i, j
    real(dp) :: va(ncol), vb(nrow), res(nrow)

    do i = 1, ncol
        do j = 1, nrow
            x(j, i) = 3.d0 * i
        end do
    end do

    xshape = shape(x)
    write (6, *) "Columns in x =", size(x, 2)

    call array_division(x, 3.d0, nrow, ncol, y)
    write (6, *) "Output array =>"
    call print_array2d(y, nrow, ncol)

    do i = 1, ncol
        va(i) = 1.d0 * i
    end do

    do i = 1, nrow
        vb(i) = 1.d0
        res(i) = 1.d0
    end do

    call sub_dgemv(x, va, vb, 3.d0, 0.d0, nrow, ncol, res)
    write (6, '(5(2X, F7.2))') va
    write (6, '(4(2X, F7.2))') res

end program check_array_handler
