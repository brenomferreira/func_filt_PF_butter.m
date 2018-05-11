% script teste
close all; clear all; clc;

load('emg_data_example.mat')

Sinal_in = emgVoltage;
Fs = signal.fs; % Frequencia de amostragem do sinal (Nyquist)
Wn = [10 400];  % Neste exemplo 400 > fs/2
%Wn = [10 70];   % Neste exemplo 70  > fs/2
Ordem = 5;      % Ordem do filtro




[Sinal_fil] = func_filt_PF_butter(Sinal_in, Fs, Wn, Ordem)
