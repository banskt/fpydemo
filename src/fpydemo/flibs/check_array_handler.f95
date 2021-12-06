program check_array_handler
    use fsvd_mod
    implicit none
    integer, parameter :: nrow = 6, ncol = 5, dp = kind(1.0d0)
    real(dp) :: x(nrow, ncol), y(nrow, ncol)
    integer :: xshape(2)
    integer :: i, j
    real(dp) :: va(ncol), vb(nrow), res(nrow)
!   for SVD
    integer :: k
    real(dp), allocatable :: U(:, :), S(:), VT(:, :)

    do i = 1, ncol
        do j = 1, nrow
            x(j, i) = 3.d0 * i
        end do
    end do

    xshape = shape(x)
    write (6, *) "Rows in x =", size(x, 1)
    write (6, *) "Columns in x =", size(x, 2)

    write (6, *)
    write (6, *) "********************"
    write (6, *) "Test | Array division"
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

    write (6, *)
    write (6, *) "********************"
    write (6, *) "Test | dgemv from subroutine"
    call sub_dgemv(x, va, vb, 3.d0, 0.d0, nrow, ncol, res)
    write (6, *) "Input vector =>"
    call print_vector(va, ncol)
    write (6, *) "Output [3.d0 * dot(x, y)] =>"
    call print_vector(res, nrow)

    
    write (6, *)
    write (6, *) "********************"
    write (6, *) "Test | SVD from subroutine"
      DATA             x/                    &
       8.79, 6.11,-9.15, 9.57,-3.49, 9.84,   &
       9.93, 6.91,-7.93, 1.64, 4.02, 0.15,   &
       9.83, 5.04, 4.86, 8.83, 9.80,-8.99,   &
       5.45,-0.27, 4.85, 0.74,10.00,-6.02,   &
       3.16, 7.98, 3.01, 5.80, 4.27,-5.31    &
                       /
    write (6, *) "Input matrix =>"
    call print_array2d(x, nrow, ncol)
    k = min(nrow, ncol)
    allocate (U(nrow, k), S(k), VT(k, ncol))
    do j = 1, k
        do i = 1, nrow
            U(i, j) = 0.d0
        end do
    end do
    do j = 1, ncol
        do i = 1, k
            VT(i, j) = 0.d0
        end do
    end do
    do i = 1, k
        S(i) = 0.d0
    end do
    call sub_dgesvd(x, k, nrow, ncol, U, S, VT)
    call print_svd_result(U, S, VT, k, nrow, ncol)


    write (6, *)
    write (6, *) "********************"
    write (6, *) "Test | SVD from module"
    write (6, *) "Input matrix =>"
    call print_array2d(x, nrow, ncol)
    call print_extmod()
!    call sub_dgesvd(x, k, nrow, ncol, U, S, VT)
    call fsvd_mod_dgesvd(x, k, nrow, ncol, U, S, VT)
    call print_svd_result(U, S, VT, k, nrow, ncol)

end program check_array_handler

subroutine print_svd_result(U, S, VT, k, nrow, ncol)
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    integer, intent(in) :: k, nrow, ncol
    real(dp), intent(in) :: U(nrow, k), S(k), VT(k, ncol)
    write (6, *) "Output U =>"
    call print_array2d(U, nrow, k)
    write (6, *) "Output S =>"
    call print_vector(S, k)
    write (6, *) "Output transpose(V) =>"
    call print_array2d(VT, k, ncol)
end subroutine print_svd_result
