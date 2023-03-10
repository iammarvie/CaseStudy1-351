%% Introduction
% * Author:                   Mordecai Ethapemi, Joshua Hernandez
% * Class:                    ESE 351
% * Date:                     Created 02/26/2023, Last Edited 03/03/2023
% * With contributions from:  Dr. Jason Trobaugh
% *                        :  https://www.mathworks.com/help/
% *                        :  Reference links: 
%                          :  https://www.engineersgarage.com/audio-filters-designing-an-audio-equalizer-7-8/
%                          :  https://en.wikipedia.org/wiki/Center_frequency
%                          :  http://learningaboutelectronics.com/Articles/Center-frequency-calculator.php#answer
%                          :  https://www.mathworks.com/help/signal/ref/lowpass.html#d124e104385
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

band1 = [20 200]; % 20hz to 200hz
band2 = [200 500]; % 200hz to 500hz
band3 = [900 1000]; % 900hz to 1khz
band4 = [2000 5000]; % 2khz to 5khz
band5 = [10000 20000]; % 10Khz to 20khz

% Center frequencies sqrt(f1*f2)
%{
center_low = sqrt(20*200); %low
%mid
center2 = sqrt(200*500); 
center3 = sqrt(900*1000);
center4 = sqrt(2000*5000);
center_high = sqrt (10000*20000); %High
%new r and c
% new tau
%}
%% PRESETS
gain = [1,-1,0,7,0]; %Preset gain
x = [1 zeros(1,fsound)];
b_low = [0 delta_t/tau]; a_low = [1 delta_t/tau-1];
b_high = [1 -1]; a_high = [1 delta_t/tau-1];
%LOW PASS
Band1 = filter([0 delta_t/tau],[1 delta_t/tau-1],x); %lowpass
Band5 = filter([1 -1],[1 delta_t/tau-1],x); %highpass
t1 = 0:delta_t:length(fsound);
figure;
subplot(2,1,1);
plot(t1,Band1);
title('low pass filter');
xlabel('time');
ylabel('output response');
subplot(2,1,2);
plot(t1,Band5);
title('highpass filter');
xlabel('time');
ylabel('output response');
xlim([0 0.08]);
ylim([-0.005 0]);
sgtitle('Lowpass and Highpass Presets');
%UNITY
unity = x; %flat frequency response is the same as the original
%BANDPASS 
[Band2,filt2] = bandpass(x,band2,fsound);
[Band3,filt3] = bandpass(x,band3,fsound);
[Band4,filt4] = bandpass(x,band4,fsound);
figure;
plot(t1,Band2);
xlim([0 0.01]);
hold on
plot(t1,Band3);
xlim([0 0.01]);
plot(t1,Band4);
xlim([0 0.01]);
title('Bandpass presets');
xlabel('time');
ylabel('output response');
legend('Band 2','band 3','band 4');
%combined filters
Mixer = gain(1)*Band5+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band1;

%FREQUENCY RESPONSE OF PRESETS
t = (0:1:length(Band1)-1)';
h_low = tf(b_low,a_low);
h_high = tf(b_high,a_high);
% freq1 = lsim(h_low,input_g,t);
% freq5 = lsim(h_high,input_g,t);
[u1,frequ] = freqz(x,512);
[h1,freq1] = freqz(Band1,512);
[h2,freq2] = freqz(filt2,512);
[h3,freq3] = freqz(filt3,512);
[h4,freq4] = freqz(filt4,512);
[h5,freq5] = freqz(Band5,512);
%unity
figure;
subplot(2,1,1);
plot(frequ, mag2db(abs(u1)));
title('Unity Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(frequ, angle(u1)/pi);
title('Unity Angle');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 1 converting magnitude to decibels
figure;
subplot(2,1,1);
plot(freq1, mag2db(abs(h1)));
title('Band 1 Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq1, angle(h1)/pi);
title('Band 1 Angle');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 2
figure;
subplot(2,1,1);
plot(freq2, mag2db(abs(h2)));
title('Band 2 Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq2, angle(h2)/pi);
title('Band 2 Angle');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 3
figure;
subplot(2,1,1);
plot(freq3, mag2db(abs(h3)));
title('Band 3 Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq3, angle(h3)/pi);
title('Band 3Angle');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 4
figure;
subplot(2,1,1);
plot(freq4, mag2db(abs(h4)));
title('Band 4 Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq4, angle(h4)/pi);
title('Band 4 Angle');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 5
figure;
subplot(2,1,1);
plot(freq5, mag2db(abs(h5)));
title('Band 5 Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq5, angle(h5)/pi);
title('Band 5 Angle');
xlabel('Frequency');
ylabel('angle');
%% APPLYING PRESETS FILTERS TO GIANT ON STEPS
input_g = giant;
input_g = input_g(:,1);
gain = [1,5,10,0,11]; %Preset gain
Band1 = filter([0 delta_t/tau],[1 delta_t/tau-1],input_g); %lowpass
Band5 = filter([1 -1],[1 delta_t/tau-1],input_g); %highpass
[Band2,filt2_g] = bandpass(input_g,band2,fsound);
[Band3,filt3_g] = bandpass(input_g,band3,fsound);
[Band4,filt4_g] = bandpass(input_g,band4,fsound);
%combined filters
Mixer_giant = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
filename = 'GiantSteps_filtered.wav';
audiowrite(filename,Mixer_giant,fsound);
% current observations: band1 is a bass booster
% band2 is a like a soft bass, band3 is meh,band4 is  treble boost,band5 is
% a volume boost...upon further observation, it seems as though band3 is
% what filters out the piano sound

%% APLYING PRESETS TO SPACE STATION
input_s = SpaceStation;
input_s= input_s(:,1);
gain = [1,5,10,0,11]; %Preset gain
Band1 = filter([0 delta_t/tau],[1 delta_t/tau-1],input_s); %lowpass
Band5 = filter([1 -1],[1 delta_t/tau-1],input_s); %highpass
[Band2,filt2_s] = bandpass(input_s,band2,fsound);
[Band3,filt3_s] = bandpass(input_s,band3,fsound);
[Band4,filt4_s] = bandpass(input_s,band4,fsound);
%combined filters
Mixer_space = gain(1)*Band1+gain(2)*Band2+gain(3)*Band3+gain(4)*Band4+gain(5)*Band5;
filename = 'SpaceStation_filtered.wav';
audiowrite(filename,Mixer_space,fsound);
% After filter sounds exteremely horrible
%%
%FREQUENCY RESPONSE OF ORIGINAL SYSTEM
g_res = fft(input_s);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure;
subplot(2,1,1);
plot(f,abs(g_res)); %Magnitude
title('frequency response of original Space Station');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res));%phase
title('frequency response of original Space Station');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%FREQUENCY RESPONSE OF MIXED SYSTEM
g_res2 = fft(Mixer_space);
g_res2 = g_res2(1:length(g_res2)/2);
f = [0:length(g_res2)-1].*fg./length(g_res2);
figure;
subplot(2,1,1);
plot(f,abs(g_res2)); %Magnitude
title('frequency response of filtered Space Station');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res2));%phase
title('frequency response of filtered Space Station');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);



%% APPLYING NEW GAIN TO EQUALIZER AND NEW SOUND
input_green = BlueinGreen;
input_green = input_green(:,1);
gain_new = [0,8,0,0,0];
Band1 = filter([0 delta_t/tau],[1 delta_t/tau-1],input_green); %lowpass
Band5 = filter([1 -1],[1 delta_t/tau-1],input_green); %highpass
[Band2,filt2_g] = bandpass(input_green,band2,fsound);
[Band3,filt3_g] = bandpass(input_green,band3,fsound);
[Band4,filt4_g] = bandpass(input_green,band4,fsound);
Mixer_blue = gain_new(1)*Band1+gain_new(2)*Band2+gain_new(3)*Band3+gain_new(4)*Band4+gain_new(5)*Band5;
filename = 'BlueinGreen_filtered.wav';
audiowrite(filename,Mixer_blue,fsound);
%gain [0,8,0,0,0]; 
%siren was removed at that gain take out the treble and the bass and leave
%some lower bandpass filter in. this region of filter is low enough to
%support the piano playing and low enough to filter out the high pitch siren.

%%
%FREQUENCY RESPONSE OF ORIGINAL SYSTEM
g_res = fft(input_s);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure;
subplot(2,1,1);
plot(f,abs(g_res)); %Magnitude
title('frequency response of original BlueinGreen');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res));%phase
title('frequency response of original BlueinGreen');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%FREQUENCY RESPONSE OF MIXED SYSTEM
g_res2 = fft(Mixer_space);
g_res2 = g_res2(1:length(g_res2)/2);
f = [0:length(g_res2)-1].*fg./length(g_res2);
figure;
subplot(2,1,1);
plot(f,abs(g_res2)); %Magnitude
title('frequency response of filtered BlueinGreen');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res2));%phase
title('frequency response of filtered BlueinGreen');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%% SPECTROGRAM ON SOUNDS
figure;
spectrogram(input_g,1024,200,1024,fsound);
title('GIANT STEPS SPECTROGRAM');
figure;
spectrogram(input_s,1024,200,1024,fsound);
title('SPACE STATION SPECTROGRAM');
figure;
spectrogram(input_green,1024,200,1024,fsound);
title('BLUE IN GREEN SPECTROGRAM');
%% FREQUENCY RESPONSE OF EACH BAND FROM GIANT MIXER
t = (0:1:length(Band1)-1)';
h_low = tf(b_low,a_low);
h_high = tf(b_high,a_high);

[u1,frequ] = freqz(input_g,512,fsound);
[h1,freq1] = freqz(Band1,512,fsound);
[h2,freq2] = freqz(filt2_g,512,fsound);
[h3,freq3] = freqz(filt3_g,512,fsound);
[h4,freq4] = freqz(filt4_g,512,fsound);
[h5,freq5] = freqz(Band5,512);

% Mag and Phase Band 1 converting magnitude to decibels
%unity frequency response
figure;
subplot(2,1,1);
plot(frequ, mag2db(abs(u1)));
title('Unity Magnitude');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(frequ, angle(u1)/pi);
title('Unity Angle');
xlabel('Frequency');

figure;
subplot(2,1,1);
plot(freq1, mag2db(abs(h1)));
title('Band 1 Magnitude on Giant steps');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq1, angle(h1)/pi);
title('Band 1 Angle on Giant steps');
xlabel('Frequency');
ylabel('angle');
% Mag and Phase Band 2
hold on
figure;
subplot(2,1,1);
plot(freq2, mag2db(abs(h2)));
title('Band 2 Magnitude on Giant steps');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq2, angle(h2)/pi);
title('Band 2 Angle on Giant steps');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 3
figure;
subplot(2,1,1);
plot(freq3, mag2db(abs(h3)));
title('Band 3 Magnitude on Giant steps');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq3, angle(h3)/pi);
title('Band 3 Angle on Giant steps');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 4
figure;
subplot(2,1,1);
plot(freq4, mag2db(abs(h4)));
title('Band 4 Magnitude on Giant steps');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq4, angle(h4)/pi);
title('Band 4 Angle on Giant steps');
xlabel('Frequency');
ylabel('angle');
%Mag and Phase Band 5
figure;
subplot(2,1,1);
plot(freq5, mag2db(abs(h5)));
title('Band 5 Magnitude on Giant steps');
xlabel('Frequency');
ylabel('db');
subplot(2,1,2);
plot(freq5, angle(h5)/pi);
title('Band 5 Angle on Giant steps');
xlabel('Frequency');
ylabel('angle');
%%
%FREQUENCY RESPONSE OF ORIGINAL SYSTEM
g_res = fft(input_g);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure;
subplot(2,1,1);
plot(f,abs(g_res)); %Magnitude
title('frequency response of original Giant Steps');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res));%phase
title('frequency response of original Giant Steps');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%FREQUENCY RESPONSE OF MIXED SYSTEM
g_res = fft(Mixer_giant);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure;
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

%% SOUND CHOICE FILTER: CHELSEA FOOTBALL CLUB ANTHEM
fg = 44100;
samples = [1,20*fg];
[chelsea,fg] = audioread('Chelsea.mp3',samples);
gain_c = [0.5,0.1,1,0.1,0.5];
Band1 = filter([0 delta_t/tau],[1 delta_t/tau-1],chelsea); %lowpass
Band5 = filter([1 -1],[1 delta_t/tau-1],chelsea); %highpass
[Band2,filt2_c] = bandpass(chelsea,band2,fsound);
[Band3,filt3_c] = bandpass(chelsea,band3,fsound);
[Band4,filt4_c] = bandpass(chelsea,band4,fsound);
Mixer_chelsea = gain_c(1)*Band1+gain_c(2)*Band2+gain_c(3)*Band3+gain_c(4)*Band4+gain_c(5)*Band5;
filename = 'Chelsea_filtered.wav';
audiowrite(filename,Mixer_chelsea,fsound);

%%
%FREQUENCY RESPONSE OF ORIGINAL SYSTEM
g_res = fft(chelsea);
g_res = g_res(1:length(g_res)/2);
f = [0:length(g_res)-1].*fg./length(g_res);
figure;
subplot(2,1,1);
plot(f,abs(g_res)); %Magnitude
title('frequency response of original Chelsea');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res));%phase
title('frequency response of original Chelsea');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%FREQUENCY RESPONSE OF MIXED SYSTEM
g_res2 = fft(chelsea);
g_res2 = g_res2(1:length(g_res2)/2);
f = [0:length(g_res2)-1].*fg./length(g_res2);
figure;
subplot(2,1,1);
plot(f,abs(g_res2)); %Magnitude
title('frequency response of filtered Chelsea');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([1,10000]);
subplot(2,1,2);
plot(f,angle(g_res2));%phase
title('frequency response of filtered Chelsea');
xlabel('Frequency (Hz)');
ylabel('Phase');
xlim([1,10000]);

%% IMPULSE
impulse = [1 zeros(1,fsound)];
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
figure;
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
legend('High pass(Band 5)','Band 2','Band 3','Band 4','Low pass (Band 1)');

