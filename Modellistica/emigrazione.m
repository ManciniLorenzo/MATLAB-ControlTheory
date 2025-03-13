%% Parametri iniziali
x1_0 = 58e6; % Popolazione residente in Italia all'inizio
x2_0 = 5e6;  % Popolazione italiana all'estero all'inizio
T = 50; %8000;     % Numero di anni da simulare

%% Inizializzazione delle variabili
x1 = zeros(1, T+1);
x2 = zeros(1, T+1);
x1(1) = x1_0;
x2(1) = x2_0;

%% Simulazione della dinamica nel tempo
for k = 1:T
    x1(k+1) = x1(k) - x1(k)/1000;
    x2(k+1) = x2(k) + x1(k)/1000;
end

% Plot dei risultati
figure;
hold on; box on;
plot(0:T, x1, '.-b', 'MarkerSize', 12, 'LineWidth',0.5); % Residenti in Italia
plot(0:T, x2, '.-r', 'MarkerSize', 12, 'LineWidth',0.5);% Residenti all'estero
xlabel('Anni');
ylabel('Popolazione');
legend('Residenti in Italia', 'Residenti all''estero');
title('Dinamica della Popolazione Italiana');
grid on;
hold off;