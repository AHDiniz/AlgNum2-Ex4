#include "octave/oct.h"

DEFUN_DLD(bvp_system, args, nargout, "Create boundary value problem linear equation system")
{
    octave_value_list result;

    double a = args(0).double_value();
    double b = args(1).double_value();
    ColumnVector p = args(2).column_vector_value();
    ColumnVector q = args(3).column_vector_value();
    ColumnVector r = args(4).column_vector_value();
    double h = args(5).double_value();
    int n = args(6).int_value();

    Matrix A(n, n);
    A.fill(.0f);
    ColumnVector f(n);
    f.fill(.0f);
    ColumnVector xa(n);
    xa.fill(.0f);
    ColumnVector xb(n);
    xb.fill(.0f);
    ColumnVector xc(n);
    xc.fill(.0f);

    for (int i = 0; i < n; ++i)
    {
        xa(i) = q(i) - 2 / (h * h);
        xb(i) = 1 / (h * h) - p(i) / (2 * h);
        xc(i) = 1 / (h * h) + p(i) / (2 * h);
    }

    A(0, 0) = 1.0f;
    f(0) = a;
    for (int i = 1; i < n - 1; ++i)
    {
        A(i, i - 1) = xb(i);
        A(i, i) = xa(i);
        A(i, i + 1) = xc(i);
        f(i) = r(i);
    }
    A(n - 1, n - 1) = 1.0f;
    f(n - 1) = b;

    result(0) = A;
    result(1) = f;
    result(2) = xa;
    result(3) = xb;
    result(4) = xc;

    return result;
}
