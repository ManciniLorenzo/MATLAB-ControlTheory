%% Problema diretto

% Parametri del sistema
a = 0.9;  % Coefficiente di "persistenza" dei processi (0 < a < 1)
b = 2;    % Impatto di ogni nuovo processo sull'utilizzo della CPU

% Condizioni iniziali e numero di passi temporali
y0 = 0;   % Utilizzo iniziale della CPU (%)
N = 200;   % Numero di passi temporali da simulare
yref = 70;  % Riferimento desiderato per l'utilizzo della CPU (%)

% Inizializzazione degli array
y = zeros(1, N);  % Utilizzo della CPU
u = zeros(1, N);  % Processi in arrivo
q = zeros(1, N);  % Coda di attesa
y(1) = y0;
q(1) = 0;

% Impostazione del seed per la ripetibilità
seed = 42;  % Puoi cambiare questo valore per ottenere sequenze diverse ma ripetibili
rng(seed);

% Simulazione del sistema
for k = 1:N-1
    % Generazione di processi in arrivo 
    u(k) = round(randn() * 30);
    u(k) = max(0, u(k));
    % u(k) = 10;
    
    % Calcolo dei processi elaborati
    % p_elaborati = min(round((100 - y(k)) / b), q(k) + u(k));
    p_elaborati = min((100 - y(k) / b), q(k) + u(k));
    
    % Aggiornamento della coda di attesa
    q(k+1) = q(k) + u(k) - p_elaborati;
    
    % Aggiornamento dell'utilizzo della CPU
    y(k+1) = min(100, a*y(k) + b*p_elaborati);
end

% Visualizzazione dei risultati
figure;
subplot(3,1,1);
plot(1:N, y, 'b-', 'LineWidth', 2);
hold on;
title('Utilizzo della CPU nel tempo');
xlabel('Passo temporale');
ylabel('Utilizzo CPU (%)');
ylim([0 100]);
legend('Utilizzo CPU','Location', 'southeast');
grid on;

subplot(3,1,2);
stem(1:N, u, 'g-', 'LineWidth', 2);
title('Processi in arrivo');
xlabel('Passo temporale');
ylabel('Numero di processi');
grid on;

subplot(3,1,3);
plot(1:N, q, 'm-', 'LineWidth', 2);
title('Coda di attesa');
xlabel('Passo temporale');
ylabel('Processi in coda');
grid on;

% Calcolo statistiche
media_utilizzo = mean(y(50:end));
media_coda = mean(q(50:end));

fprintf('Parametri del sistema:\n');
fprintf('a (persistenza dei processi): %.2f\n', a);
fprintf('b (impatto di ogni nuovo processo): %.2f\n', b);
fprintf('\nRisultati della simulazione:\n');
fprintf('Utilizzo medio della CPU (dopo il transitorio): %.2f%%\n', media_utilizzo);
fprintf('Lunghezza media della coda di attesa (dopo il transitorio): %.2f processi\n', media_coda);

%% problema inverso

% Parametri del sistema
a = 0.9;  % Coefficiente di "persistenza" dei processi (0 < a < 1)
b = 2;    % Impatto di ogni nuovo processo sull'utilizzo della CPU

% Condizioni iniziali e numero di passi temporali
y0 = 0;   % Utilizzo iniziale della CPU (%)
N = 200;   % Numero di passi temporali da simulare
yref = 70;  % Riferimento desiderato per l'utilizzo della CPU (%)

% Inizializzazione degli array
y = zeros(1, N);  % Utilizzo della CPU
u = zeros(1, N);  % Processi in arrivo
q = zeros(1, N);  % Coda di attesa
y(1) = y0;
q(1) = 0;

% Calcolo del numero di processi elaborabili per mantenere l'utilizzo desideratoy
u_steady = (yref * (1 - a)) / b;


% Impostazione del seed per la ripetibilità
seed = 42;  % Puoi cambiare questo valore per ottenere sequenze diverse ma ripetibili
rng(seed);

% Simulazione del sistema
for k = 1:N-1
    % Generazione di processi in arrivo (con variabilità)
    % u(k) = round(p_steady + randn() * 2);
    % u(k) = max(0, u(k));
    u(k) = u_steady ;
    
    % Calcolo dei processi elaborati
    % p_elaborati = min(round((100 - y(k)) / b), q(k) + u(k));
    p_elaborati = min((100 - y(k) / b), q(k) + u(k));
    
    % Aggiornamento della coda di attesa
    q(k+1) = q(k) + u(k) - p_elaborati;
    
    % Aggiornamento dell'utilizzo della CPU
    y(k+1) = min(100, a*y(k) + b*p_elaborati);
end

% Visualizzazione dei risultati
figure;
subplot(3,1,1);
plot(1:N, y, 'b-', 'LineWidth', 2);
hold on;
plot([1 N], [yref yref], 'r--', 'LineWidth', 1.5);
title('Utilizzo della CPU nel tempo');
xlabel('Passo temporale');
ylabel('Utilizzo CPU (%)');
ylim([0 100]);
legend('Utilizzo CPU', 'Riferimento 85%', 'Location', 'southeast');
grid on;

subplot(3,1,2);
stem(1:N, u, 'g-', 'LineWidth', 2);
title('Processi in arrivo');
xlabel('Passo temporale');
ylabel('Numero di processi');
grid on;

subplot(3,1,3);
plot(1:N, q, 'm-', 'LineWidth', 2);
title('Coda di attesa');
xlabel('Passo temporale');
ylabel('Processi in coda');
grid on;

% Calcolo statistiche
media_utilizzo = mean(y(50:end));
media_coda = mean(q(50:end));
percentuale_intorno_85 = sum(abs(y(50:end) - yref) <= 2) / (N-49) * 100;

fprintf('Parametri del sistema:\n');
fprintf('a (persistenza dei processi): %.2f\n', a);
fprintf('b (impatto di ogni nuovo processo): %.2f\n', b);
fprintf('Riferimento desiderato: %.2f%%\n', yref);
fprintf('\nRisultati della simulazione:\n');
fprintf('Utilizzo medio della CPU (dopo il transitorio): %.2f%%\n', media_utilizzo);
fprintf('Lunghezza media della coda di attesa (dopo il transitorio): %.2f processi\n', media_coda);
fprintf('Percentuale del tempo entro ±2%% dal riferimento (dopo il transitorio): %.2f%%\n', percentuale_intorno_85);
