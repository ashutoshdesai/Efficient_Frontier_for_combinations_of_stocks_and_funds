%Finding the Efficient Frontier

%Matrix of covariances for Objective function
H = [0.00139853 0.0000518732 0.000870317 -0.0000052597 0.001083873 -0.00046048 0.000891931 0.001405849; %Quadratic term
     0.0000518732 0.000162273 7.81009E-05 -0.000158712 0.00020745 -0.000167076 7.9175E-05 8.79412E-05;
     0.000870317 7.81009E-05 0.00125878 -0.000308662 0.000666315 -0.000496918 0.000186355 0.000659169;
    -5.25973E-06 -0.000158712 -0.000308662 0.002178836 0.000609822 0.001354822 0.000813501 0.000175788;
     0.001083873 0.00020745 0.000666315 0.000609822 0.00297518 -0.000180849 0.000975808 0.001432282;
    -0.000460484 -0.000167076 -0.000496918 0.001354822 -0.000180849 0.00428542 9.82755E-05 -0.000220857;
     0.000891931 7.9175E-05 0.000186355 0.000813501 0.000975808 9.82755E-05 0.002568618 0.001169308;
     0.001405849 8.79412E-05 0.000659169 0.000175788 0.001432282 -0.000220857 0.001169308 0.002536295];
c = []; %Linear term (not present)
A = [];
b = [];
Aeq = [0.011453728 0.00304658 0.003237079 0.015436017 0.019460872 0.008713119 0.013593254 0.016792777; 1 1 1 1 1 1 1 1];
ub = [inf; inf; inf; inf; inf; inf; inf; inf];

%No short selling
lb_no_short = [0; 0; 0; 0; 0; 0; 0; 0];
%With short selling
lb_short = [-inf; -inf; -inf; -inf; -inf; -inf; -inf; -inf];

% To save vales of x matrix
wt1 = [];
wt2 = [];

%To save values  of standard deviations and variances
Std1 = [];
Std2 = [];
var_p1 = [];
var_p2 = [];


%To run optimization between minimum and maximum value of return
for r = [0.0039: 0.0008: 0.0195]
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
plot(Std1,[0.0039: 0.0008: 0.0195]);
plot(Std2,[0.0039: 0.0008: 0.0195]);
hold off
title("Efficient Frontier - 8 Assets");
xlabel("Standard Deviation of Portfolio");
ylabel("Expected Return of Portfolio");
[hleg, hobj, hout, mout] = legend({'NO SHORT SELLING','SHORT SELLING'},'Location','southeast','Orientation','vertical','LineWidth',1);
set(hobj,'linewidth',1.5);

%Plotting the 2 tables
T1 = array2table(wt1,'VariableNames',{'X1','X2','X3','X4','X5','X6','X7','X8'}); %No short weights
T2 = array2table(wt2,'VariableNames',{'X1','X2','X3','X4','X5','X6','X7','X8'}); %Short weights 
T3 = array2table([0.0039: 0.0008: 0.0195]','VariableNames',{'Expected Return of portfolio'}); %Returns column
T4 = array2table(var_p1','VariableNames',{'Portfolio Variance'}); %var No short
T5 = array2table(var_p2','VariableNames',{'Portfolio Variance'}); %var short

T_nshort = [T3 T1 T4];
T_short = [T3 T2 T5];