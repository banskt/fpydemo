module fmath
    use fmathmod
    implicit none
    private
    public fsumdiff, fsumprint

    contains

    subroutine fsumdiff(a, b, s, d)
        real, intent(in) :: a, b
        real, intent(out) :: s, d
        call fsum(a, b, s)
        call fdiff(a, b, d)
        print *, 'This is from subroutine of fsumdiff module'
    end subroutine

    subroutine fsumprint(a, b)
        real, intent(in) :: a, b
        print *, a + b
    end subroutine

end module fmath
