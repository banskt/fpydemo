module fsvd_mod
    use env_precision
    implicit none
    private
    public fsvd_mod_dgesvd, print_extmod

    contains

    subroutine print_extmod()
        write(6, *) "r16k = ", r16k
    end subroutine print_extmod

    subroutine fsvd_mod_dgesvd(A, k, nrow, ncol, U, S, VT)
        implicit none
        external :: dgesvd
        integer, intent(in)   :: nrow, ncol, k
        real(r8k), intent(in)  :: A(nrow, ncol)
        real(r8k), intent(out) :: U(nrow, k), S(k), VT(k, ncol)
!       local variables
        integer(i4k) :: ldmax, lwork, info, i, j
        real(r8k), allocatable :: work(:)
        real(r8k) :: Acopy(nrow, ncol)

        do j = 1, ncol
            do i = 1, nrow
                Acopy(i, j) = A(i, j)
            end do
        end do
 
        ldmax = max(nrow, ncol)
        lwork = max(1, 3 * k + ldmax, 5 * k)
        allocate(work(lwork))
        call dgesvd('S', 'S', nrow, ncol, Acopy, nrow, S, U, nrow, VT, k, work, lwork, info)

        end subroutine fsvd_mod_dgesvd

end module fsvd_mod
