%Finding the minimum variance and return on that minimum variance

%Matrix of covariances for Objective function
H = [0.001398528 0.0000518732 0.000870317; %Quadratic term
    0.0000518732 0.000162273 0.0000781009;
    0.000870317 0.0000781009 0.00125878];
c = []; %Linear term (Not present)
A = []; 
b = [];
Aeq = [1 1 1];
beq = [1];
ub = [inf; inf; inf];

%No short selling
lb_no_short = [0; 0; 0];

%With short selling
lb_short = [-inf; -inf; -inf];

%Calling the quadprog function
[x1, fval1] = quadprog(H, c, A, b, Aeq, beq, lb_no_short,ub); %No short selling
[x2, fval2] = quadprog(H, c, A, b, Aeq, beq, lb_short,ub); %Short selling

%Expected Geometric Returns of each asset
expr = [0.011453728 0.00304658 0.003237079];

%Return of Portfolio 
R1 = expr*x1;
R2 = expr*x2;

%Standard Deviation of Portfolio
Std1 = sqrt(x1'*H*x1);
Std2 = sqrt(x2'*H*x2);


fprintf("Portfolio Return for Minimum Risk - WITHOUT SHORT SELLING");
disp(R1);
fprintf("Minimum Risk of Portfolio - WITHOUT SHORT SELLING");
disp(Std1);

fprintf("Portfolio Return for Minimum Risk - WITH SHORT SELLING");
disp(R2);
fprintf("Minimum Risk of Portfolio - WITH SHORT SELLING");
disp(Std2);