% Diagrama de polos y ceros a lazo abierto (FTLA)

close all; clear; clc;
pkg load control;

s = tf('s');
Rth = 6.375;
Cth = 10.9716;
tau = Rth * Cth;
FTLA = 40 * (Rth / (tau * s + 1));

fig = figure(1);
set(fig, 'Color', [1 1 1], 'Position', [100 100 540 430]);
pzmap(FTLA);
grid on;
xlim([-0.03, 0.01]);
ylim([-0.02, 0.02]);

set(gca, 'Position', [0.21 0.18 0.73 0.64]);
set(gca, 'FontSize', 16, 'LineWidth', 1.4);
set(gca, 'XTick', -0.03:0.01:0.01, 'YTick', -0.02:0.01:0.02);

h_polos = findobj(gca, 'Type', 'line', 'Marker', 'x');
set(h_polos, 'MarkerSize', 16, 'LineWidth', 3.0);
h_leg = findobj(fig, 'Type', 'axes', 'Tag', 'legend');
if ~isempty(h_leg)
    set(h_leg, 'FontSize', 15);
end

title({'Diagrama de polos y ceros de FTLA'; '(sin compensar)'}, 'FontSize', 19, 'FontWeight', 'bold');
xlabel('Eje Real', 'FontSize', 18);
ylabel('Eje Imaginario', 'FontSize', 18);

set(fig, 'PaperUnits', 'inches', 'PaperSize', [5.0 4.0], 'PaperPosition', [0 0 5.0 4.0]);
print -dpng -r300 03_pzmap_lazo_abierto.png
