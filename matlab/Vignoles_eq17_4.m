% Solves \tau_i at various C_i = {1:100:21}

figure(2)
i = 1;
for C = linspace(1,21, 100)
r = 5e-6;
sig_v = 2/r;
tau(i) = rhos/Ms * 1/C /sig_v / khet;
i = i + 1;
end
plot(linspace(1,21, 100), tau)
xlabel('C')
ylabel('\tau')
title('Characteristic Time', '\tau = \rho_s/M_s(1/C)(1/\sigma_v/k) k=1, Ms=40.11e-3, rhos=3.217e3')
set(gca, 'FontSize', 20)
