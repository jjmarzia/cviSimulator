% Solves r_p at various C

clear
clc

figure(3)
for C = 1:3:21
khet = 1; Ms = 40.11e-3; rhos = 3.217e3;
t = linspace(0,50000,100);
rp  = 5e-6*exp(-khet*C*Ms/rhos*t);
plot(t, rp)
hold on 
set(gca, 'FontSize', 20)
title('r_p''=-r_pkCMs/rhos','k=1, Ms=40.11e-3, rhos=3.217e3')
end
hold off 
legend('C=1', 'C=4', 'C=7', 'C=10', 'C=13', 'C=16', 'C=19', 'C=21')
xlabel('t')
ylabel('r_p')
