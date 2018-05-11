function [Sinal_fil] = func_filt_PF_butter(Sinal_in, Fs, Wn, Ordem)

% filtro
wn = [Wn(1)/(Fs/2) Wn(2)/(Fs/2)];
if wn(2) >= 1 % se verdadeiro implementar um passa alta
    
    wn = wn(1); % faixa mais baixa para implementar o filtro passa alta
    [b,a] = butter(Ordem,wn,'high');
    
else % implementa um passa faixa
    
    [b,a] = butter(Ordem,wn);
    
end

Sinal_fil = filtfilt(b, a, Sinal_in);
% fim filtro

% fft sinais
[ Yshift_in, nw ] = func_FFT_sinal( Sinal_in, Fs );
[ Yshift_out, nw ] = func_FFT_sinal( Sinal_fil,Fs );
% fim fft sinais

n = 1:length(Sinal_in);

% plot
figure();
subplot(211);
plot(n, Sinal_in, n,Sinal_fil);
legend('Sinal-in','Sinal-filt','Location','Best');
ylabel('Amp');
xlabel('N');

subplot(212);
plot(nw,Yshift_in,nw,Yshift_out);
legend('FFT-Sinal-in','FFT-Sinal-filt','Location','Best');
ylabel('Amp');
xlabel('Freq');
% fim plot

end

function [ Yshift, nw ] = func_FFT_sinal( sinal,Fs )
% function [ Yshift, nw ] = func_FFT_sinal( sinal,Fs )
% Calculo da FFT do sinal
% entrada:
% sinal = sinal a ser transformado
% Fs = frequência de Amostragem
% Saída:
% Yshift = FFT do sinal
% nw = eixo x (frequencia)

fs = Fs;               % frequência de amostragem
Ts = 1/fs;              % periodo de amostragem
t = 0:Ts:1-Ts;          % intervalo de amostragem
n = length(t);          % tamanho do vetor
                 % amplitude 2


y =sinal;
% plotando o sinal


%% TRANSFORMADA DE FOURIER
Y = fft(y);        % módulo da transformada de fourier
%plota a transformada em troncos
% figure
% plot(abs(Y));               
% grid;
% xlabel('Frequência?');
% ylabel('Amplitude?');
% title('Primeira iteração da FFT');

%% NORMALIZANDO E CENTRALIZANDO O ESPECTRO DE FREQUÊNCIA
N = length(Y);% numero de pontos da fft

w = (-fs)/2:fs/N:(fs/2)-fs/N;% intervalo de frequência centralizado
ptos = find(w>=0);
nw = w(ptos);
% a amplitude após fft é uma função do número de pontos,
%technical note 1702

Yshift = fftshift(Y);  
Yshift = Yshift(ptos);
% plota a transformada normalizada em troncos
% figure;
% plot(w,2*abs(Yshift)/N);
% grid;
% xlabel('Frequência (Hz)');
% ylabel('Amplitude');
% title('FFT centralizada');

Yshift = abs(Yshift);

end