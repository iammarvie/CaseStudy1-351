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
band2 = [200 500]; % 200hz to 500hz
band3 = [900 1000]; % 900hz to 1khz
band4 = [2000 5000]; % 2khz to 5khz
band5 = [10000 20000]; % 10Khz to 20khz
%{
% Center frequencies sqrt(f1*f2)
center1 = sqrt(20*200); %%low
%mid
center2 = sqrt(200*2000); 
center3 = sqrt(2000*10000);
center4 = sqrt(10000*20000);
%
center5 = sqrt (20000*20000); %% High
%}
%% PRESETS
gain = [1,-1,0,7,0]; %Preset gain

%TREBLE BOOST (HIGH PASS FILTER)
%{
[Band1,filt1] = highpass(input,10000,fsound);
%UNITY (BAND PASS FILTER)
[Band2,filt2] = bandpass(input,band2,fsound);
[Band3,filt3] = bandpass(input,band3,fsound);
[Band4,filt4] = bandpass(input,band4,fsound);
%BASS BOOST (LOW PASS FILTER)
[Band5,filt5] = lowpass(input,200,fsound);
%combined filters
Mixer_giant = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
%}
%% GIANT STEPS
input_g = giant;
%sound(input_g);
%TREBLE BOOST (HIGH PASS FILTER)
[Band1,filt1] = highpass(input_g,10000,fsound);
%UNITY (BAND PASS FILTER)
[Band2,filt2] = bandpass(input_g,band2,fsound);
[Band3,filt3] = bandpass(input_g,band3,fsound);
[Band4,filt4] = bandpass(input_g,band4,fsound);
%BASS BOOST (LOW PASS FILTER)
[Band5,filt5] = lowpass(input_g,200,fsound);
%combined filters
Mixer_giant = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
filename = 'GiantSteps_filtered.wav';
audiowrite(filename,Mixer_giant,fsound);
%FREQUENCY RESPONSE OF MIXED SYSTEM
g_res = fft(Mixer_giant);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure(1);
subplot(2,1,1);
plot(f,abs(g_res)); %Magnitude
title('frequency response of filtered Giant Steps');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res));%phase
title('frequency response of filtered Giant Steps');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);


%MAGNITUDE

%PHASE
%% SPACE STATION
input_s = SpaceStation;
%TREBLE BOOST (HIGH PASS FILTER)
[Band1,filt1] = highpass(input_s,10000,fsound);
%UNITY (BAND PASS FILTER)
[Band2,filt2] = bandpass(input_s,band2,fsound);
[Band3,filt3] = bandpass(input_s,band3,fsound);
[Band4,filt4] = bandpass(input_s,band4,fsound);
%BASS BOOST (LOW PASS FILTER)
[Band5,filt5] = lowpass(input_s,200,fsound);
%combined filters
Mixer_space = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
filename = 'SpaceStation_filtered.wav';
audiowrite(filename,Mixer_space,fsound);

%% BLUE IN GREEN
input_green = BlueinGreen;
%sound(input_green);
clear sound
gain_new = [0,0,0,15,-1];
[Band1,filt1] = highpass(input_green,10000,fsound);
[Band2,filt2] = bandpass(input_green,band2,fsound);
[Band3,filt3] = bandpass(input_green,band3,fsound);
[Band4,filt4] = bandpass(input_green,band4,fsound);
[Band5,filt5] = lowpass(input_green,200,fsound);
Mixer_blue = gain_new(1)*Band1+gain_new(2)*Band2+gain_new(3)*Band3+gain_new(4)*Band4+gain_new(5)*Band5;
filename = 'BlueinGreen_filtered.wav';
audiowrite(filename,Mixer_blue,fsound);

%% SOUND CHOICE FILTER: CHELSEA FOOTBALL CLUB ANTHEM
fg = 44100;
samples = [1,20*fg];
[chelsea,fg] = audioread('Chelsea.mp3',samples);
clear sound
gain_c = [0,0,0,1,10];
[Band1,filt1] = highpass(chelsea,10000,fsound);
[Band2,filt2] = bandpass(chelsea,band2,fsound);
[Band3,filt3] = bandpass(chelsea,band3,fsound);
[Band4,filt4] = bandpass(chelsea,band4,fsound);
[Band5,filt5] = lowpass(chelsea,200,fsound);
Mixer_chelsea = gain_c(1)*Band1+gain_c(2)*Band2+gain_c(3)*Band3+gain_c(4)*Band4+gain_c(5)*Band5;
%sound(Mixer_chelsea,fg);
filename = 'Chelsea_filtered.wav';
audiowrite(filename,Mixer_chelsea,fg);
% This takes out the cymbals and hi hat drums and just leaves the bassy
% drums in the give a much more parade and retro tv feel to the anthem.

%% IMPULSE
impulse = zeros(1,fsound);
impulse(4) = fsound;
[Band1_impulse,filt1_impulse] = highpass(impulse,10000,fsound);
imp_B1 = fft(Band1_impulse);
imp_B1 = imp_B1(1:length(imp_B1/2));
%UNITY (BAND PASS FILTER)
[Band2_impulse,filt2_impulse] = bandpass(impulse,band2,fsound);
imp_B2 = fft(Band2_impulse);
imp_B2 = imp_B2(1:length(imp_B2/2));
[Band3_impulse,filt3_impulse] = bandpass(impulse,band3,fsound);
imp_B3 = fft(Band3_impulse);
imp_B3 = imp_B3(1:length(imp_B3/2));
[Band4_impulse,filt4_impulse] = bandpass(impulse,band4,fsound);
imp_B4 = fft(Band4_impulse);
imp_B4 = imp_B4(1:length(imp_B4/2));
%BASS BOOST (LOW PASS FILTER)
[Band5_impulse,filt5_impulse] = lowpass(impulse,200,fsound);
imp_B5 = fft(Band5_impulse);
imp_B5 = imp_B5(1:length(imp_B5/2));
f_band_imp = [0:length(imp_B5)-1].*fsound./length(imp_B5);
%COMBINE BANDS
Mixer_impulse = Band1_impulse+Band2_impulse+Band3_impulse+Band4_impulse+Band5_impulse;
imp_res = fft(Mixer_impulse);
imp_res = imp_res(1:length(imp_res)/2);
f = [0:length(imp_res)-1].*fg./length(imp_res);
%Impulse response for combined Bands
figure(1);
subplot(2,1,1);
plot(f,abs(imp_res));
title('frequency response of filtered Impulse');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(imp_res));
title('frequency response of filtered Impulse');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);
% Impulse response on each band
figure;
plot(f_band_imp , abs(imp_B1));
hold on
plot(f_band_imp , abs(imp_B2));
plot(f_band_imp , abs(imp_B3));
plot(f_band_imp , abs(imp_B4));
plot(f_band_imp , abs(imp_B5));
title('frequency response of filtered Impulse on each band');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);
legend('High pass(Band 1)','Band 2','Band 3','Band 4','Low pass (Band 5)');