% Lugar de las raices del sistema con compensador PI

close all; clear; clc;
pkg load control;

s = tf('s');
Rth = 6.375;
Cth = 10.9716;
tau = Rth * Cth;
Gact = 40;
H = 1;

FTLA = Gact * (Rth / (tau * s + 1)) * H;
Ti = tau;
PI = (s + 1/Ti) / s;
s1 = -1 / (0.20 * tau);

FTLA_PI = minreal(PI * FTLA);

fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
rlocus(FTLA_PI); hold on;
set(findobj(gca, 'Type', 'line'), 'LineWidth', 2.5);

% Cancelacion polo-cero y polo de diseno
plot(-1/tau, 0, 'kx', 'MarkerSize', 14, 'LineWidth', 2.5);
plot(-1/Ti, 0, 'ko', 'MarkerSize', 14, 'LineWidth', 2.5);
plot(real(s1), imag(s1), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 10);

grid on;
axis equal;
xlim([-0.12, 0.02]);
ylim([-0.03, 0.03]);

set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 16, 'LineWidth', 1.4);
set(gca, 'XTick', -0.12:0.04:0.02, 'YTick', -0.03:0.03:0.03);
title({'Lugar de Raices del sistema'; 'con compensador PI'}, 'FontSize', 19, 'FontWeight', 'bold');
xlabel('Eje Real', 'FontSize', 18);
ylabel('Eje Imaginario', 'FontSize', 18);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 04_rlocus_PI.png
