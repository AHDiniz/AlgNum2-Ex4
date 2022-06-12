a = 0;
b = 1;
subdivisions = [10, 20, 30, 40, 50, 100, 150, 200, 250, 500, 1000];

p = @(x) x;
q = @(x) 1;
r = @(x) 4 * x ^ 3 + 4 * x + 1;
result = @(x) x ^ 3 - x + 1;

bc_a.type = "value";
bc_a.boundaries = [1];

bc_b.type = "mixed";
bc_b.boundaries = [2, 1, 5];

for i = 1 : numel(subdivisions)

    n = subdivisions(i);

    [x, u] = bvp(a, b, n, p, q, r, bc_a, bc_b);
    results = arrayfun(result, x);

    avg_diff = 0;

    for j = 1 : numel(u)
        avg_diff += abs(results(j) - u(j));
    endfor

    avg_diff /= n;

    printf("Avarage difference = %f\n", avg_diff);

endfor
