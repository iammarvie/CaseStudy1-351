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
fsound = 44100;         % sample frequency = 44.1 kHz
delta_time = 1/fsound;     % sampling period = 1/sample frequency

% Bands
band1 = [20 200]; % 20hz to 200hz
band2 = [200 500]; % 200hz to 2khz
band3 = [900 1000]; % 2khz to 10khz
band4 = [2000 5000]; % 10khz to 20khz
band5 = [10000 20000]; % 20khz

% Center frequencies sqrt(f1*f2)
center1 = sqrt(20*200); %%low
%mid
center2 = sqrt(200*2000); 
center3 = sqrt(2000*10000);
center4 = sqrt(10000*20000);
%
center5 = sqrt (20000*20000); %% High
gain = [-15,-7,0,7,15];
%% GIANT STEPS
input = giant;
%% TREBLE BOOST (HIGH PASS FILTER)
[Band1,filt1] = highpass(input,10000,fsound);
%% UNITY (BAND PASS FILTER)
[Band2,filt2] = bandpass(input,band2,fsound);
[Band3,filt3] = bandpass(input,band3,fsound);
[Band4,filt4] = bandpass(input,band4,fsound);
%% BASS BOOST (LOW PASS FILTER)
%LowpassFilter = lsim([1/tau], [1 1/tau], input, t1);
[Band5,filt5] = lowpass(input,200,fsound);
%% combined filters
Mixer_giant = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
sound(Mixer_giant);
