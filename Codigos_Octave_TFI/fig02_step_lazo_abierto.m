% Respuesta al escalon a lazo abierto (sin compensar)

close all; clear; clc;
pkg load control;

s = tf('s');
Rth = 6.375;
Cth = 10.9716;
tau = Rth * Cth;
Gact = 40;
H = 1;

G = Rth / (tau * s + 1);
FTLA = Gact * G * H;

tfinal = 450;
fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
step(FTLA, tfinal);
grid on;

set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 17, 'LineWidth', 1.4);
set(gca, 'XTick', 0:100:450, 'YTick', 0:50:300);
set(findobj(gca, 'Type', 'line'), 'LineWidth', 2.8);
title({'Respuesta al escalon a lazo abierto'; '(sin compensacion)'}, 'FontSize', 19, 'FontWeight', 'bold');
xlabel('Tiempo [s]', 'FontSize', 18);
ylabel({'Incremento de'; 'temperatura [°C]'}, 'FontSize', 18);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 02_step_lazo_abierto.png
