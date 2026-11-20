% Diagrama de bloques del sistema compensado (con funciones de transferencia)

clear; clc; close all;

fig = figure('Color', [1 1 1], 'Position', [100 100 1260 340]);
axes('Position', [0 0 1 1], 'Color', [1 1 1]);
hold on;
axis equal;
axis off;
xlim([0 126]);
ylim([0 34]);

function dibujar_bloque(x, y, w, h, txt)
    rectangle('Position', [x+0.5, y-0.5, w, h], 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'none');
    rectangle('Position', [x, y, w, h], 'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 1.0);
    text(x+w/2, y+h/2, txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 10.5, 'FontName', 'Helvetica');
end

function dibujar_bloque_fraccion(x, y, w, h, num_txt, den_txt, prefijo_txt)
    rectangle('Position', [x+0.5, y-0.5, w, h], 'FaceColor', [0.8 0.8 0.8], 'EdgeColor', 'none');
    rectangle('Position', [x, y, w, h], 'FaceColor', [1 1 1], 'EdgeColor', 'k', 'LineWidth', 1.0);
    ym = y + h/2;
    if isempty(prefijo_txt)
        xc = x + w/2;
        fw = w * 0.72;
        plot([xc - fw/2, xc + fw/2], [ym, ym], 'k-', 'LineWidth', 1.0);
        text(xc, ym + 0.35, num_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10.5, 'FontName', 'Helvetica');
        text(xc, ym - 0.35, den_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 10.5, 'FontName', 'Helvetica');
    else
        xp = x + w*0.26;
        xc = x + w*0.70;
        fw = w * 0.46;
        text(xp, ym, prefijo_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 10.5, 'FontName', 'Helvetica');
        plot([xc - fw/2, xc + fw/2], [ym, ym], 'k-', 'LineWidth', 1.0);
        text(xc, ym + 0.35, num_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10.5, 'FontName', 'Helvetica');
        text(xc, ym - 0.35, den_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 10.5, 'FontName', 'Helvetica');
    end
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
    text(x, y, txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'FontName', 'Helvetica');
end

function titulo_bloque(x, y, txt)
    text(x, y, txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 9.5, 'FontName', 'Helvetica', 'Color', [0.25 0.25 0.25]);
end

yt = 24.0;
yb = 8.0;
h = 6.2;

% Sumador
cx = 16.5; cy = yt; r = 1.7;
t = linspace(0, 2*pi, 60);
patch(cx + r*cos(t) + 0.3, cy + r*sin(t) - 0.3, [0.8 0.8 0.8], 'EdgeColor', 'none');
patch(cx + r*cos(t), cy + r*sin(t), [1 1 1], 'EdgeColor', 'k', 'LineWidth', 1.0);
text(cx-1.05, cy, '+', 'FontSize', 11, 'HorizontalAlignment', 'center');
text(cx, cy-1.05, '-', 'FontSize', 12, 'HorizontalAlignment', 'center');

% Bloques con funciones de transferencia
% Controlador PI: C(s) = 0,019608 * (s + 0,014297) / s
dibujar_bloque_fraccion(25, yt-h/2, 26, h, 's + 0,014297', 's', '0,019608 \cdot');
titulo_bloque(25 + 13, yt - h/2 - 0.9, 'Controlador PI  C(s)');

% Actuador: G_act(s) = 40
dibujar_bloque(60, yt-h/2, 13, h, '40');
titulo_bloque(60 + 6.5, yt - h/2 - 0.9, 'Actuador  G_{act}(s)');

% Planta: G(s) = 6,375 / (69,94s + 1)
dibujar_bloque_fraccion(82, yt-h/2, 20, h, '6,375', '69,94 s + 1', '');
titulo_bloque(82 + 10, yt - h/2 - 0.9, 'Planta  G(s)');

% Sensor: H(s) = 1
dibujar_bloque(56, yb-h/2, 16, h, '1');
titulo_bloque(56 + 8, yb - h/2 - 0.9, 'Sensor  H(s)');

% Flechas directas
dibujar_linea([2.5, yt; 14.8, yt], true);
texto_linea(8.5, yt+0.7, {'R(s)'; '[ °C ]'});

dibujar_linea([18.2, yt; 25, yt], true);
texto_linea(21.6, yt+0.7, {'E(s)'; '[ °C ]'});

dibujar_linea([51, yt; 60, yt], true);
texto_linea(55.5, yt+0.7, {'U(s)'; '[ duty ]'});

dibujar_linea([73, yt; 82, yt], true);
texto_linea(77.5, yt+0.7, {'P(s)'; '[ W ]'});

dibujar_linea([102, yt; 123, yt], true);
texto_linea(115.5, yt+0.7, {'T(s)'; '[ °C ]'});

% Realimentacion
plot(109.5, yt, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 4);
dibujar_linea([109.5, yt; 109.5, yb; 72, yb], true);
texto_linea(90.75, yb+0.6, 'T(s) [ °C ]');

dibujar_linea([56, yb; 16.5, yb; 16.5, yt-1.7], true);
texto_linea(36.25, yb+0.6, 'B(s) [ °C ]');

set(fig, 'PaperPositionMode', 'auto');
print -dpng -r300 08_diagrama_bloques_compensado.png
