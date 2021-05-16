%Finding the maximum variance and return on that maximum variance

%Matrix of Expected returns for objective function
c = -[0.011453728 0.00304658 0.003237079 0.015436017 0.019460872 0.008713119 0.013593254 0.016792777]'; %Linear term
A = [];
b = [];
Aeq = [1 1 1 1 1 1 1 1];
beq = [1];
ub = [inf; inf; inf; inf; inf; inf; inf; inf];

%No short selling
lb_no_short = [0; 0; 0; 0; 0; 0; 0; 0];

%Calling the linprog function
[x1, fval1] = linprog(c, A, b, Aeq, beq, lb_no_short,ub); %No short selling

%Matrix of covariances for Objective function
H = [0.00139853 0.0000518732 0.000870317 -0.0000052597 0.001083873 -0.00046048 0.000891931 0.001405849; %Quadratic term
     0.0000518732 0.000162273 7.81009E-05 -0.000158712 0.00020745 -0.000167076 7.9175E-05 8.79412E-05;
     0.000870317 7.81009E-05 0.00125878 -0.000308662 0.000666315 -0.000496918 0.000186355 0.000659169;
    -5.25973E-06 -0.000158712 -0.000308662 0.002178836 0.000609822 0.001354822 0.000813501 0.000175788;
     0.001083873 0.00020745 0.000666315 0.000609822 0.00297518 -0.000180849 0.000975808 0.001432282;
    -0.000460484 -0.000167076 -0.000496918 0.001354822 -0.000180849 0.00428542 9.82755E-05 -0.000220857;
     0.000891931 7.9175E-05 0.000186355 0.000813501 0.000975808 9.82755E-05 0.002568618 0.001169308;
     0.001405849 8.79412E-05 0.000659169 0.000175788 0.001432282 -0.000220857 0.001169308 0.002536295];

%Standard Deviation of Portfolio
Std1 = sqrt(x1'*H*x1);

fprintf("Portfolio Return for Maximum Risk - WITHOUT SHORT SELLING");
disp(-fval1);
fprintf("Maximum Risk of Portfolio - WITHOUT SHORT SELLING");
disp(Std1);
