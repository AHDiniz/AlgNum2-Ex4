function [x, u] = bvp(a, b, n, p, q, r, bc_a, bc_b)

    h = (b - a) / (n - 1);

    x = (linspace(a, b, n))';
    xp = arrayfun(p, x);
    xq = arrayfun(q, x);
    xr = arrayfun(r, x);

    [A, f, xa, xb, xc] = bvp_system(a, b, xp, xq, xr, h, n);

    switch bc_a.type
        case "value"
            f(1) = bc_a.boundaries(1);
        case "derivative"
            A(1, 1) = xa(1) + xb(1);
            A(1, 2) = xc(1);
            f(1) = f(1) + xb(1) * h * bc_a.boundaries(1);
        case "mixed"
            A(1, 1) = xa(1) + xb(1) * (1 + h * (bc_a.boundaries(2) / bc_a.boundaries(1)));
            A(1, 2) = xc(1);
            f(1) = f(1) + xb(1) * h * (bc_a.boundaries(3) / bc_a.boundaries(1)); 
        otherwise
            printf("Boundary condition error.\n");
    end

    switch bc_b.type
        case "value"
            f(n) = bc_b.boundaries(1);
        case "derivative"
            A(n, n) = xa(n) + xc(n);
            A(n, n - 1) = xb(n);
            f(n) = f(n) - xc(n) * h * bc_b.boundaries(1);
        case "mixed"
            A(n, n) = xa(n) + xc(n) * (1 - h * (bc_b.boundaries(2) / bc_b.boundaries(1)));
            A(n, n - 1) = xb(n);
            f(n) = f(n) - xc(n) * h * (bc_b.boundaries(3) / bc_b.boundaries(1));
        otherwise
            printf("Boundary condition error.\n");
    end

    u = A \ f;

endfunction