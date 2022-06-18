function [problem] = problem_one()
    problem.a = 0;
    problem.b = 10;
    problem.subdivisions = [10, 50, 100];

    problem.p = @(x) 0;
    problem.q = @(x) 0;
    problem.r = @(x) -0.01 * (20 - x);

    problem.bc_a.type = "value";
    problem.bc_a.boundaries = [40];

    problem.bc_b.type = "value";
    problem.bc_b.boundaries = [200];
endfunction