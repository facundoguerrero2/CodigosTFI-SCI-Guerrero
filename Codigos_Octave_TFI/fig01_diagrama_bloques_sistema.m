% Diagrama de bloques fisico del sistema

clear; clc; close all;

fig = figure('Color', [1 1 1], 'Position', [100 100 1260 320]);
axes('Position', [0 0 1 1], 'Color', [1 1 1]);
hold on;
axis equal;
axis off;
xlim([0 126]);
ylim([0 32]);

function dibujar_bloque(x, y, w, h, txt)
    rectangle('Position', [x+0.5, y-0.5, w, h], 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'none');
    rectangle('Position', [x, y, w, h], 'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 1.0);
    text(x+w/2, y+h/2, txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 11, 'FontName', 'Helvetica');
end

function dibujar_linea(pts, con_flecha)
    plot(pts(:,1), pts(:,2), 'k-', 'LineWidth', 1.1);
    if con_flecha
        p2 = pts(end,:);
        p1 = pts(end-1,:);
        v = p2 - p1;
        v = v / norm(v);
        perp = [-v(2), v(1)];
        L = 1.3;
        W = 0.5;
        tri = [p2; p2 - L*v + W*perp; p2 - L*v - W*perp];
        patch(tri(:,1), tri(:,2), 'k', 'EdgeColor', 'none');
    end
end

function texto_linea(x, y, txt)
    text(x, y, txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10.5, 'FontName', 'Helvetica');
end

yt = 22.5;
yb = 7.5;
h = 5.5;

% Sumador
cx = 18.5; cy = yt; r = 1.7;
t = linspace(0, 2*pi, 60);
patch(cx + r*cos(t) + 0.3, cy + r*sin(t) - 0.3, [0.8 0.8 0.8], 'EdgeColor', 'none');
patch(cx + r*cos(t), cy + r*sin(t), [1 1 1], 'EdgeColor', 'k', 'LineWidth', 1.0);
text(cx-1.1, cy, '+', 'FontSize', 11, 'HorizontalAlignment', 'center');
text(cx, cy-1.1, '-', 'FontSize', 12, 'HorizontalAlignment', 'center');

% Bloques del sistema
dibujar_bloque(28, yt-h/2, 18, h, {'Controlador'; '(Klipper / STM32)'});
dibujar_bloque(55, yt-h/2, 20, h, {'Actuador'; '(MOSFET + Cartucho)'});
dibujar_bloque(84, yt-h/2, 16, h, {'Planta'; '(Bloque Hotend)'});
dibujar_bloque(49, yb-h/2, 32, h, {'Sensor + Acondic. + ADC/Firmware'; '(NTC 100k\Omega + Divisor + Tabla)'});

% Flechas directas
dibujar_linea([3, yt; 16.8, yt], true);
texto_linea(9.5, yt+0.6, {'Entrada de referencia'; '[ °C ]'});

dibujar_linea([20.2, yt; 28, yt], true);
texto_linea(24.1, yt+0.6, {'Error'; '[ °C ]'});

dibujar_linea([46, yt; 55, yt], true);
texto_linea(50.5, yt+0.6, {'Control (PWM)'; '[ duty 0-1 ]'});

dibujar_linea([75, yt; 84, yt], true);
texto_linea(79.5, yt+0.6, {'Potencia'; '[ W ]'});

dibujar_linea([100, yt; 122, yt], true);
texto_linea(114.5, yt+0.6, {'Temperatura'; '[ °C ]'});

% Realimentacion
plot(108.5, yt, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 4);
dibujar_linea([108.5, yt; 108.5, yb; 81, yb], true);
texto_linea(94.75, yb+0.6, 'Temperatura [ °C ]');

dibujar_linea([49, yb; 18.5, yb; 18.5, yt-1.7], true);
texto_linea(33.75, yb+0.6, 'Temp. medida [ °C ]');

set(fig, 'PaperPositionMode', 'auto');
print -dpng -r300 01_diagrama_bloques_sistema.png
