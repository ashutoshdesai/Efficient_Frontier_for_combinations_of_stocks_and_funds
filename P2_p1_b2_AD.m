%Finding the maximum variance and return on that maximum variance

%Matrix of Expected returns for objective function
c = -[0.011453728 0.00304658 0.003237079]'; %Linear term
A = [];
b = [];
Aeq = [1 1 1];
beq = [1];
ub = [inf; inf; inf];

%No short selling
lb_no_short = [0; 0; 0];

%Calling the linprog function
[x1, fval1] = linprog(c, A, b, Aeq, beq, lb_no_short,ub); %No short selling

%Matrix of covariances for Objective function
H = [ 0.001398528 0.0000518732 0.000870317; %Quadratic term
    0.0000518732 0.000162273 0.0000781009;
    0.000870317 0.0000781009 0.00125878];

%Standard Deviation of Portfolio
Std1 = sqrt(x1'*H*x1);

fprintf("Portfolio Return for Maximum Risk - WITHOUT SHORT SELLING");
disp(-fval1);
fprintf("Maximum Risk of Portfolio - WITHOUT SHORT SELLING");
disp(Std1);
