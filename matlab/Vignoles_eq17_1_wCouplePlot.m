
close all

% [t,y] = ode45(@cvi,[0 10e-6],[12.2 10]);
% figure(1)
% plot(t,y(:,1),'-o')
%     %,t,y(:,2),'-o')
% title('rp=5e-5 [m] Dg=9e-5 [m^2/s] khet=1 m/s  C(0)=12.2 mol/m^3 C''(0)=1');
% xlabel('z');
% ylabel('c');
% legend('c[1]')
% set(gca, 'FontSize', 20)
% % set(gca, 'YScale', 'log')

% figure(2)
% % for C = linspace(1,20,5)
% [t,y] = ode45(@cvi,[0 10],[5e-6 0]);
% 
% plot(t,y(:,1),'-o')
% hold on
% %,t,y(:,2),'-o')
% title('rp=5e-5 [m] Dg=9e-5 [m^2/s] khet=1 m/s  C(0)=12.2 mol/m^3 C''(0)=1');
% xlabel('z');
% ylabel('c');
% legend('c[1]')
% set(gca, 'FontSize', 20)
% % end
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

figure(4)
i = 1;
for C = linspace(1,21, 100)
r = 5e-6;
sig_v = 2/r;
tau(i) = rhos/Ms * 1/C /sig_v / khet;
i = i +1;
end
plot(linspace(1,21, 100), tau)
xlabel('C')
ylabel('\tau')
title('Characteristic Time', '\tau = \rho_s/M_s(1/C)(1/\sigma_v/k) k=1, Ms=40.11e-3, rhos=3.217e3')
set(gca, 'FontSize', 20)

%% Plot of coupled rp and C
rp = ones(1, 100);
rp_init = rp;
C = (-tanh(linspace(0,1,100)*5-2)+1)/2;
C_init = C;
dt = 1/1000; 
dz = 1/100;
khet = 1; Ms = 40.11e-3; rhos = 3.217e3;
% Vs = Ms/rhos;
Vs = 1;
Dg = 1;
rp_old = rp;
for t = 1:1000
    for z = 1: 100
        rp(z) = 1/(1 + dt * khet * C(z) * Vs) * rp_old(z);  
    end
    rp_old = rp;
    C_old = C;
    for z = 2:99
        C(z) = 1/(2 - 2 * khet / rp(z) / Dg * dz^2) * (C_old(z+1) + C_old(z-1));
    end
%     C(1) = -(dz * (2*khet/ rp(1,t+1) /Dg)) * C(1) + C(1+1);
% Left BC    assume flux=0
    z = 1;
    C(z) = C(z+1);
    z = 100;
    C(z) = C(z-1);
%     C(end) = C_old(end-1);
end
C
figure(9)
plot(C, LineWidth= 4)
hold on
plot(rp, LineWidth= 4)
plot(C_init, 'b--', LineWidth=2)
plot(rp_init, 'r-o', LineWidth=2)
hold off
legend('C', 'r_p', 'C_{init}', 'r_p_{init}')
title('t=1.0 s', 'Vs=Dg=khet=1')
set(gca, 'FontSize', 20)
xlabel('z (cm)')
ylabel('Concentration / pore radius')
%%
function dcdz = cvi(z, c)
rp  = 5e-6;
Dg = 9e-5;
khet = 1;

dcdz = [c(2); -2*khet/(rp*Dg) * c(1)];
end

function drdt = cvi2(t, r, C)
khet = 1;
C = 12.2;
Ms = 40.11e3;
rhos = 3.217e3;
rp  =5e-6;
drdt = [r(2); -rp*khet*C*Ms/rhos];
end