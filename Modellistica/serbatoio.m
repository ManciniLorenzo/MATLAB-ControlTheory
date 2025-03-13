%% Parametri del problema
S = 1; % Sezione del serbatoio (m^2)
h0 = 0; % Altezza iniziale del liquido (m)        
P_max =1/300; % Portata massima (m^3/s)

%% Simulazione numerica "open-loop"

dt = 1; % Passo di tempo (s)
t = 0:dt:600; % Vettore del tempo
h = zeros(size(t)); % Inizializzazione altezza
h(1) = h0; % Condizione iniziale
a = ones(size(t)); % Valvola completamente aperta

% Metodo di Eulero per integrare dh/dt = a(t) * Pmax
for k = 1:length(t)-1
    dh = a(k) * P_max * dt; % Incremento di h
    h(k+1) = h(k) + dh; % Aggiornamento altezza
end

% Plot dei risultati
figure;
subplot(2,1,1);
    plot(t, h, 'b', 'LineWidth', 2);
    xlabel('Tempo (s)');
    ylabel('Altezza del liquido (m)');
    title('Riempimento del serbatoio in open-loop');
    grid on;
subplot(2,1,2);
    plot(t, a, 'k', 'LineWidth', 2);
    xlabel('Tempo (s)');
    ylabel('Apertura valvola (-)');
    grid on;

%% Simulazione numerica "closed-loop"

dt = 1; % Passo di tempo (s)
t = 0:dt:1800; % Vettore del tempo
h = zeros(size(t)); % Inizializzazione altezza
h(1) = h0; % Condizione iniziale 
a = zeros(size(t)); % Valvola completamente aperta

% Metodo di Eulero per integrare dh/dt = a(t) * Pmax
hdes = 1; % Altezzadesiderata (m) 

for k = 1:length(t)-1
    a(k) = 1-h(k)/hdes;
    dh = a(k) * P_max * dt; % Incremento di h
    h(k+1) = h(k) + dh; % Aggiornamento altezza
end

% Plot dei risultati
figure;
subplot(2,1,1);
    plot(t, h, 'b', 'LineWidth', 2);
    xlabel('Tempo (s)');
    ylabel('Altezza del liquido (m)');
    title('Riempimento del serbatoio in closed-loop');
    grid on;
    ylim([0, 1.2]); % Margine superiore per chiarezza
subplot(2,1,2);
    plot(t, a, 'k', 'LineWidth', 2);
    xlabel('Tempo (s)');
    ylabel('Apertura valvola (-)');
    grid on;