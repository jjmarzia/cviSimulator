% Solves analytically for C

clear
clc

r_p = 2.5e-5        % m
D_g = 2e-9          % argon, m^2/s
k_het = 1e6         % 1/s

C_0 = 12.2;         
DC_0 = 10;           

syms C(z)

DC = diff(C,z);
D2C = diff(C,z,2);

ode = D2C == (k_het/(r_p*D_g))*C;
cond1 = C(0) == C_0;
cond2 = DC(0) == DC_0;
conds = [cond1 cond2];

CSol(z) = dsolve(ode, conds)
CSol = simplify(CSol)

%fplot(z, CSol)

% Using C0 = 12.2, DC_0 = 10:

% CSol(z) =
% (4882812499999999^(1/2)*exp(64*4882812499999999^(1/2)*z)*(1952*4882812499999999^(1/2) + 25))/1562499999999999680 - exp(-64*4882812499999999^(1/2)*z)*((5*4882812499999999^(1/2))/312499999999999936 - 61/10)
