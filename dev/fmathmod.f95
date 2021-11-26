module fmathmod
    implicit none
    private
    public fsum, fdiff

contains

    subroutine fsum(a, b, res)
        implicit none
        real, intent(in)  :: a
        real, intent(in)  :: b
        real, intent(out) :: res
        res = a + b
        write(*,*) "Hello from the Fortran sum subroutine!"
    end subroutine

    subroutine fdiff(a, b, res)
        implicit none
        real, intent(in)  :: a
        real, intent(in)  :: b
        real, intent(out) :: res
        res = a - b
        write(*,*) "Hello from the Fortran diff subroutine!"
    end subroutine

end module fmathmod
