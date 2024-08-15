clear all; close all; clc;
pkg load symbolic;

% Dados de entrada
distancias = [140 493 738 738 1247 891 2000 3132]; % distâncias em metros
rssis = [-89.24 -95.42 -109.43 -102.57 -109.50 -93.00 -90.77 -91.45]; % RSSI


% Definir uma função para minimizar
n = sym('n');
E = rssis(1) - 10*n*log10(distancias./distancias(1));
J_n = sum((rssis - E).^2);
derivada_J_n = (diff(J_n));

exp_perda = vpa(solve(derivada_J_n),4);

PL_dBm = vpa(rssis(1) - 10*exp_perda*log10(distancias./distancias(1)), 4)


