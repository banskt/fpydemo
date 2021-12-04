
subroutine array_division(x, a, nrow, ncol, y)
    implicit none
    integer, parameter    :: dp = kind(1.0d0)
    integer, intent(in)   :: ncol, nrow
    real(dp), intent(in)  :: x(nrow, ncol)
    real(dp), intent(in)  :: a
    real(dp), intent(out) :: y(nrow, ncol)
    integer               :: i, j
    character(len=100)    :: fmt1, fmt2

    write(6, *) "(array_division) Input array = "
    call print_array2d(x, nrow, ncol)

    do j = 1, ncol
        do i = 1, nrow
            y(i, j) = x(i, j) / a
        end do
    end do

end subroutine

subroutine sub_dgemv(A, x, y, alpha, beta, nrow, ncol, res)
    implicit none
    external :: dgemv
    integer, parameter    :: dp = kind(1.0d0)
    integer, intent(in)   :: ncol, nrow
    real(dp), intent(in)  :: alpha, beta
    real(dp), intent(in)  :: A(nrow, ncol)
    real(dp), intent(in)  :: x(ncol), y(nrow)
    real(dp), intent(out) :: res(nrow)
    integer :: i, j
    do i = 1, nrow
        res(i) = y(i)
    end do
    call dgemv('N', nrow, ncol, alpha, A, nrow, x, 1, beta, res, 1)
end subroutine

subroutine print_array2d(x, m, n)
!
!   x is an input array of size (m, n)
!
    implicit none
    integer, parameter    :: dp = kind(1.0d0)
    integer, intent(in)   :: m, n
    real(dp), dimension(m, n), intent(in)  :: x
    character(len=100)    :: fmt1
!
!   Format for each row should be:
!   fmt1 = '(n(2X,F7.2))'
!
    write (fmt1, '(A,I0,A)') '(', n, '(2X, F7.3))'
    write (6, fmt1) transpose(x)
!
end subroutine print_array2d
