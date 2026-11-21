% Simulacion de respuesta temporal ante escalon de 200 °C

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

Tref = 200;
t = (0:0.001:120)';
[y, t] = step(Tref * FTLC, t);

% Parametros de la respuesta (criterio del 2%)
y_ss = Tref * dcgain(FTLC);
Mp = max(0, (max(y) - y_ss) / y_ss * 100);
idx_2pct = find(abs(y - y_ss) >= 0.02 * y_ss, 1, 'last');
ts_sim = t(idx_2pct);
ts_teorico = 4 * (0.20 * tau);

printf('Valor final: %.4f °C\n', y_ss);
printf('Sobrepasamiento: %.2f %%\n', Mp);
printf('Tiempo de establecimiento simulado (2%%): %.4f s\n', ts_sim);
printf('Tiempo de establecimiento teorico (4*tau_cl): %.4f s\n', ts_teorico);

fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
plot(t, y, 'b-', 'LineWidth', 2.8); hold on;
plot([0 120], [Tref Tref], 'r--', 'LineWidth', 1.8);
plot([0 120], [0.98*Tref 0.98*Tref], 'k:', 'LineWidth', 1.4);
plot(ts_sim, y(idx_2pct), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
grid on;

ylim([0 220]);
set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 17, 'LineWidth', 1.4);
set(gca, 'XTick', 0:20:120, 'YTick', 0:50:200);
title({'Simulacion de respuesta temporal'; 'ante escalon de 200 °C (FTLC)'}, 'FontSize', 18, 'FontWeight', 'bold');
xlabel('Tiempo [s]', 'FontSize', 18);
ylabel('Temperatura [°C]', 'FontSize', 18);
h_leg = legend('Respuesta compensada', 'Referencia (200 °C)', 'Banda del 98% (196 °C)', 'Location', 'southeast');
set(h_leg, 'FontSize', 12);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 07_simulacion_escalon_200C.png
