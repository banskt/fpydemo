
subroutine array_division(x, a, nrow, ncol, y)
    use env_precision
    implicit none
    integer, intent(in)   :: ncol, nrow
    real(r8k), intent(in)  :: x(nrow, ncol)
    real(r8k), intent(in)  :: a
    real(r8k), intent(out) :: y(nrow, ncol)
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

subroutine sub_dgesvd(A, k, nrow, ncol, U, S, VT)
    implicit none
    external :: dgesvd
    integer, parameter    :: dp = kind(1.0d0)
    integer, intent(in)   :: nrow, ncol, k
    real(dp), intent(in)  :: A(nrow, ncol)
    real(dp), intent(out) :: U(nrow, k), S(k), VT(k, ncol)

!   local variables
    integer(kind = 4) :: ldmax, lwork, info, i, j
    real(dp), allocatable :: work(:)
    real(dp) :: Acopy(nrow, ncol)

    do j = 1, ncol
        do i = 1, nrow
            Acopy(i, j) = A(i, j)
        end do
    end do

    ldmax = max(nrow, ncol)
    lwork = max(1, 3 * k + ldmax, 5 * k)
    allocate(work(lwork))
    call dgesvd('S', 'S', nrow, ncol, Acopy, nrow, S, U, nrow, VT, k, work, lwork, info) 
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

subroutine print_vector(x, m)
    implicit none
    integer, parameter    :: dp = kind(1.0d0)
    integer, intent(in)   :: m
    real(dp), dimension(m), intent(in)  :: x
    character(len=100)    :: fmt1
!
!   Format for each row should be:
!   fmt1 = '(m(2X,F7.2))'
!
    write (fmt1, '(A,I0,A)') '(', m, '(2X, F7.3))'
    write (6, fmt1) x
!
end subroutine print_vector
