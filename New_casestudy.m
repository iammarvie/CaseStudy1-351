%% Introduction
% * Author:                   Mordecai Ethapemi, Joshua Hernandez
% * Class:                    ESE 351
% * Date:                     Created 02/26/2023, Last Edited 03/03/2023
% * With contributions from:  Dr. Jason Trobaugh
% *                        :  https://www.mathworks.com/help/
% *         
%% Inputs
%% Input sounds to use
[giant,fg] = audioread('Giant Steps Bass Cut.wav');
[BlueinGreen,fb] = audioread('Blue in Green with Siren.wav');
[SpaceStation,fsp] = audioread('Space Station - Treble Cut.wav');

% Use Inputs from Homework 1 for Lowpass and Highpass DT Circuits:
R = 1000;      % Ohms
C = 5 * 10^-6 ;  % Farads
tau = R * C;       % seconds
t_end = 50*tau;
fsound = 44100;         % sample frequency = 44.1 kHz
delta_t = 1/fsound;     % sampling period = 1/sample frequency
%t = [0:delta_t:fsound];
% Bandslsim frequency

band1 = [20 200]; % 20hz to 200hz
band2 = [200 500]; % 200hz to 500hz
band3 = [900 1000]; % 900hz to 1khz
band4 = [2000 5000]; % 2khz to 5khz
band5 = [10000 20000]; % 10Khz to 20khz

% Center frequencies sqrt(f1*f2)
center_low = sqrt(20*200); %low
%mid
center2 = sqrt(200*500); 
center3 = sqrt(900*1000);
center4 = sqrt(2000*5000);
center_high = sqrt (10000*20000); %High
%new r and c
% new tau

%% PRESETS
%{
%input = giant;
n = round(fsound*tau*15+2);
x = zeros(1,n);
x(1) = 1;
%LOW PASS
lowpass = filter([0 delta_t/tau],[1 delta_t/tau-1],x);
%HIGH PASS
highpass = filter([1 -1],[1 delta_t/tau-1],x);
%t = 0:1:length(highpass)-1;
t1 = 0:delta_t:(tau*15+delta_t);
%BANDPASS
f2 = 200; f1 = 500;
band_fi = fir1(n,[f2 f1]);
figure;
plot(band_fi);
figure;
subplot(3,1,1);
plot(t1,lowpass);
subplot(3,1,2);
plot(t1,highpass);
xlim([0 0.08]);
ylim([-0.005 0]);
subplot(3,1,3);
plot(t1,band2);
%}
fsound = 10000;
n = round(fsound*tau*15+2);
xtt = zeros(1,n);
xtt(1) = 1;
[b_low,a_low] = butter(1,200/fsound,'low');
x = filter(b_low,a_low,xtt);
figure;
plot(x);
[b1,a1] = butter(3,band2/fsound,'bandpass');
x_1 = filter(b1,a1,xtt);
[b2,a2] = butter(3,band3/fsound,'bandpass');
x_2 = filter(b2,a2,xtt);
[b3,a3] = butter(3,band4/fsound,'bandpass');
x_3 = filter(b3,a3,xtt);

[bb,aa] = butter(3,  0.6,'high');
freqz(bb,aa);
figure;
freqz(b1,a1);
figure;
plot(x_1);
hold on
plot(x_2);
plot(x_3);
legend('1','2','3');
