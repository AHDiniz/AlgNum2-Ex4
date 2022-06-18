problems = [problem_one(), problem_two(), problem_three(), problem_four(), problem_five()];

for i = 1 : numel(problems)
    for j = 1 : numel(problems(i).subdivisions)
        n = problems(i).subdivisions(j);

        [x, u] = bvp(problems(i).a, problems(i).b, n, problems(i).p, problems(i).q, problems(i).r, problems(i).bc_a, problems(i).bc_b);

        hf = figure();
        plot(x, u);
        xlabel("x");
        ylabel("u");
        print(hf, sprintf("out/problem_%d-%d_subs.png", i, n), "-dpng");
    endfor
endfor
