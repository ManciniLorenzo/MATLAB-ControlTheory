%% Definizione dei parametri del sistema
alpha12 = 1; % Coefficiente di distribuzione del compartimento 1

%% Condizioni iniziali
x1_0 = 10; % Condizione iniziale del compartimento 1
x2_0 = 0;  % Condizione iniziale del compartimento 2

%% Matrici del sistema
A = [-alpha12, 0;
     alpha12, 0];
B = [1, 0;
     0, -1]; 

%% Simulazione con metodo di Eulero
tspan = 0:0.01:5; % Intervallo di tempo di simulazione esteso
x1 = zeros(size(tspan)); % Preallocazione dei vettori delle soluzioni
x2 = zeros(size(tspan));
x1(1) = x1_0; % Condizioni iniziali
x2(1) = x2_0;
u1 = 0; % Flusso entrante costante nel compartimento 1
u2 = 0; % Flusso entrante costante nel compartimento 2

for i = 2:length(tspan)
    x1(i) = x1(i-1) + 0.01*(A(1,1)*x1(i-1) + A(1,2)*x2(i-1) + B(1,1)*u1 + B(1,2)*u2);
    x2(i) = x2(i-1) + 0.01*(A(2,1)*x1(i-1) + A(2,2)*x2(i-1) + B(2,1)*u1 + B(2,2)*u2);
end

%% Plotting degli andamenti temporali
figure;
subplot(2,1,1)
plot(tspan, x1, 'b-', 'LineWidth', 2)
hold on
plot(tspan, x2, 'r--', 'LineWidth', 2)
xlabel('Tempo')
ylabel('Variabili di stato')
title('Andamenti temporali delle variabili di stato')
legend('x_1(t)', 'x_2(t)', 'Location', 'Best')
grid on
%% Plotting della traiettoria nello spazio di stato
subplot(2,1,2)
plot(x1, x2, 'k-', 'LineWidth', 2)
grid on
xlabel('x_1(t)')
ylabel('x_2(t)')
title('Traiettoria nello spazio di stato')
grid on