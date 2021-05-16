%Finding the Efficient Frontier

%Matrix of Covariances for Objective function
H = [0.001398528 0.0000518732 0.000870317; %Quadratic term to be minimized
    0.0000518732 0.000162273 0.0000781009;
    0.000870317 0.0000781009 0.00125878];
c = []; %Linear term (not present)
A = [];
b = [];
Aeq = [0.011453728 0.00304658 0.003237079; 1 1 1];
ub = [inf; inf; inf];

%No short selling
lb_no_short = [0; 0; 0];
%With short selling
lb_short = [-inf; -inf; -inf];

% To save vales of x matrix
wt1 = [];
wt2 = [];

%To save values  of standard deviations and variances
Std1 = [];
Std2 = [];
var_p1 = [];
var_p2 = [];

%To run optimization between minimum and maximum value of return
for r = [0.0036: 0.0004: 0.0115] %Range of expected portfolio return
    beq = [r 1];
    [x1, fval1] = quadprog(H, c, A, b, Aeq, beq, lb_no_short,ub); %No short selling
    [x2, fval2] = quadprog(H, c, A, b, Aeq, beq, lb_short,ub); %Short selling
    wt1 = [wt1; x1'];
    wt2 = [wt2; x2'];
    Std1 = [Std1 sqrt(x1'*H*x1)];
    Std2 = [Std2 sqrt(x2'*H*x2)];
    var_p1 = [var_p1 ((x1'*H*x1)/0.5)];
    var_p2 = [var_p2 ((x2'*H*x2)/0.5)];
end

%Plotting Efficient Frontier Graph
figure
hold on
plot(Std1,[0.0036: 0.0004: 0.0115]);
plot(Std2,[0.0036: 0.0004: 0.0115]);
hold off
title("Efficient Frontier - 3 Assets");
xlabel("Standard Deviation of Portfolio");
ylabel("Expected Return of Portfolio");
[hleg, hobj, hout, mout] = legend({'NO SHORT SELLING','SHORT SELLING'},'Location','southeast','Orientation','vertical','LineWidth',1);
set(hobj,'linewidth',1.5);


%Plotting the 2 tables
T1 = array2table(wt1,'VariableNames',{'X1','X2','X3'}); %No short weights
T2 = array2table(wt2,'VariableNames',{'X1','X2','X3'}); %Short weights 
T3 = array2table([0.0036: 0.0004: 0.0115]','VariableNames',{'Expected Return of portfolio'}); %Returns column
T4 = array2table(var_p1','VariableNames',{'Portfolio Variance'}); %var No short
T5 = array2table(var_p2','VariableNames',{'Portfolio Variance'}); %var short

T_nshort = [T3 T1 T4];
T_short = [T3 T2 T5];