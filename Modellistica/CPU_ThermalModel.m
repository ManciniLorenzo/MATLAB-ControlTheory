%% Simulazione della dinamica della temperatura di una CPU con raffreddamento ad aria
% ingresso costante

% Parametri del sistema
M = 0.05;       % Massa equivalente della CPU + dissipatore (kg)
cp = 500;       % Calore specifico medio (J/kg·K)
u = 1;          % Coefficiente di scambio termico (W/K)
Theta_a = 20;   % Temperatura ambiente (°C)
Phi_gen = 60;   % Potenza generata dalla CPU (W)

% Condizioni iniziali
Theta0 = Theta_a; % Temperatura iniziale della CPU (°C)
t_final = 300;  % Tempo di simulazione (s)

% Discretizzazione temporale
dt = 1; % Passo tempo (s) di discretizzazione
t = 0:dt:t_final; % Vettore del tempo (discreto)
Theta = zeros(size(t)); % Inizializzazione vettore della temperatura
Theta(1) = Theta0; % Condizione iniziale 

% Simulazione con metodo di Eulero
for i = 1:length(t)-1
    Qconv = u*(Theta(i) - Theta_a);  % Flusso di calore per convezione
    dThetadt = (Phi_gen - Qconv) / (M * cp); % Equazione di bilancio termico
    Theta(i+1) = Theta(i) + dThetadt * dt; % Aggiornamento della temperatura
end

% Grafico dei risultati
figure(1); grid on; box on; hold on; 
plot(t, Theta, '.-r', 'LineWidth', 1);
xlabel('Tempo [s]');
ylabel('Temperatura CPU [°C]');
title('Dinamica della temperatura della CPU');

%% Simulazione della dinamica della temperatura di una CPU con raffreddamento ad aria
% diversi valori di ingresso costante

% Parametri del sistema
M = 0.05;       % Massa equivalente della CPU + dissipatore (kg)
cp = 500;       % Calore specifico medio (J/kg·K)

Theta_a = 20;   % Temperatura ambiente (°C)
Phi_gen = 60;   % Potenza generata dalla CPU (W)

% Condizioni iniziali
Theta0 = Theta_a; % Temperatura iniziale della CPU (°C)
t_final = 300;  % Tempo di simulazione (s)

% Discretizzazione temporale
dt = 1; % Passo tempo (s) di discretizzazione
t = 0:dt:t_final; % Vettore del tempo (discreto)
Theta = zeros(size(t)); % Inizializzazione vettore della temperatura
Theta(1) = Theta0; % Condizione iniziale 

for u = 1:1:3 % Coefficiente di scambio termico (W/K)
    % Simulazione con metodo di Eulero
    for i = 1:length(t)-1
        Qconv = u*(Theta(i) - Theta_a);  % Flusso di calore per convezione
        dThetadt = (Phi_gen - Qconv) / (M * cp); % Equazione di bilancio termico
        Theta(i+1) = Theta(i) + dThetadt * dt; % Aggiornamento della temperatura
    end
    
    % Grafico dei risultati
    figure(1);
    subplot(2,1,1); grid on; box on; hold on;  title('Dinamica della temperatura della CPU');
    plot(t, Theta, '.-', 'LineWidth', 1);
    xlabel('Tempo [s]');
    ylabel('Temperatura CPU [°C]');
    ylim([0,90])
    subplot(2,1,2)
    plot(t, u*t./t, '.-', 'LineWidth', 1); grid on; box on; hold on; 
    xlabel('Tempo [s]');
    ylabel('Coeff. di scambio term. [W/K]');
    ylim([0,4])

end

%% Simulazione della dinamica della temperatura di una CPU con raffreddamento ad aria
%  Un problema inverso: dato un desiderio dulla temperatura a regime
%  stazionario, determinare l'ingresso costante che lo assicura

% Parametri del sistema
M = 0.05;       % Massa equivalente della CPU + dissipatore (kg)
cp = 500;       % Calore specifico medio (J/kg·K)
Theta_a = 20;   % Temperatura ambiente (°C)
Phi_gen = 60;   % Potenza generata dalla CPU (W)

% Condizioni iniziali
Theta0 = Theta_a; % Temperatura iniziale della CPU (°C)
t_final = 300;  % Tempo di simulazione (s)

% Riferimento di temperatura e feedback
Theta_r = 70; % riferimento di temperatura della CPU desiderato (°C)
u  = Phi_gen/(Theta_r-Theta_a); 

% Discretizzazione temporale
dt = 1; % Passo tempo (s) di discretizzazione
t = 0:dt:t_final; % Vettore del tempo (discreto)
Theta = zeros(size(t)); % Inizializzazione vettore della temperatura
Theta(1) = Theta0; % Condizione iniziale 

% Simulazione con metodo di Eulero
for i = 1:length(t)-1
    Qconv = u*(Theta(i) - Theta_a);  % Flusso di calore per convezione
    dThetadt = (Phi_gen - Qconv) / (M * cp); % Equazione di bilancio termico
    Theta(i+1) = Theta(i) + dThetadt * dt; % Aggiornamento della temperatura
end

% Grafico dei risultati
figure(1);
subplot(2,1,1); grid on; box on; hold on; title('Dinamica della temperatura della CPU');
plot(t, Theta, '.-', 'LineWidth', 1);
xlabel('Tempo [s]');
ylabel('Temperatura CPU [°C]');
ylim([0,90])
subplot(2,1,2); grid on; box on; hold on; title('Ingresso u');
plot(t, u*t./t, '.-', 'LineWidth', 1); 
ylabel('Coeff. di scambio term. [W/K]');
ylim([0,4])