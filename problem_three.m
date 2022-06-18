function [problem] = problem_three()
    problem.a = 0;
    problem.b = 1;
    problem.subdivisions = [10, 50, 100];

    cref = 10e-3;

    problem.p = @(x) 0;
    problem.q = @(x) 0;
    problem.r = @(x) cref * ((20.2 - 1414) / 10e-3);

    problem.bc_a.type = "value";
    problem.bc_a.boundaries = [160];

    problem.bc_b.type = "mixed";
    problem.bc_b.boundaries = [10e-3, cref, cref * 70];
endfunction