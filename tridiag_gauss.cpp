#include "octave/oct.h"

DEFUN_DLD(tridiag_gauss, args, nargout, "Gaussian Elimination for tridiagonal systems")
{
    Matrix A = args(0).matrix_value();
    ColumnVector f = args(1).column_vector_value();

    int n = A.rows();

    ColumnVector u(n);
    u.fill(.0f);

    for (int i = 0; i < n - 1; ++i)
    {
        A(i, i) -= A(i, i - 1) / A(i - 1, i);
        f(i) -= (A(i, i - 1) / A(i - 1, i) * f(i - 1));
    }

    u(n - 1) = r(n - 1) / A(n - 1, n - 1);

    for (int i = n - 1; i > 0; --i)
    {
        u(i) = (r(i) - A(i, i + 1) * u(i - 1)) / A(i, i);
    }

    return u;
}
