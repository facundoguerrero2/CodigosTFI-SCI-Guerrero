% Respuesta al escalon del sistema compensado (FTLC)

close all; clear; clc;
pkg load control;

s = tf('s');
Rth = 6.375;
Cth = 10.9716;
tau = Rth * Cth;
Gact = 40;
FTLA = Gact * (Rth / (tau * s + 1));

Ti = tau;
PI = (s + 1/Ti) / s;
s1 = -1 / (0.20 * tau);
L = (Gact * Rth * (s1 + 1/Ti)) / (s1 * (tau * s1 + 1));
Kp = 1 / abs(L);

FTLC = minreal(feedback(Kp * PI * FTLA, 1));

fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
step(FTLC, 100);
grid on;

set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 17, 'LineWidth', 1.4);
set(gca, 'XTick', 0:20:100, 'YTick', 0:0.2:1.2);
set(findobj(gca, 'Type', 'line'), 'LineWidth', 2.8);
title({'Respuesta al escalon del sistema'; 'compensado (FTLC)'}, 'FontSize', 19, 'FontWeight', 'bold');
xlabel('Tiempo [s]', 'FontSize', 18);
ylabel('Amplitud normalizada', 'FontSize', 18);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 05_step_compensado.png
