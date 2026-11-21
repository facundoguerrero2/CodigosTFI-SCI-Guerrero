% Diagrama de polos y ceros del sistema compensado (FTLC)

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

FTLC_sin_minreal = feedback(Kp * PI * FTLA, 1);

fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
pzmap(FTLC_sin_minreal);
grid on;
xlim([-0.10, 0.02]);
ylim([-0.03, 0.03]);

set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 16, 'LineWidth', 1.4);
set(gca, 'XTick', -0.10:0.04:0.02, 'YTick', -0.03:0.03:0.03);

h_polos = findobj(gca, 'Type', 'line', 'Marker', 'x');
h_ceros = findobj(gca, 'Type', 'line', 'Marker', 'o');
set(h_polos, 'MarkerSize', 16, 'LineWidth', 3.0);
set(h_ceros, 'MarkerSize', 14, 'LineWidth', 2.8);
h_leg = findobj(fig, 'Type', 'axes', 'Tag', 'legend');
if ~isempty(h_leg)
    set(h_leg, 'FontSize', 15);
end

title({'Diagrama de polos y ceros del'; 'sistema compensado (FTLC)'}, 'FontSize', 19, 'FontWeight', 'bold');
xlabel('Eje Real', 'FontSize', 18);
ylabel('Eje Imaginario', 'FontSize', 18);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 06_pzmap_compensado.png
