%% Introduction
% * Author:                   Mordecai Ethapemi, Joshua Hernandez
% * Class:                    ESE 351
% * Date:                     Created 02/26/2023, Last Edited 03/03/2023
% * With contributions from:  Dr. Jason Trobaugh
% *                        :  https://www.mathworks.com/help/
% *         
%% Inputs

% Use Inputs from Homework 1 for Lowpass and Highpass DT Circuits:
R = 1000;      % Ohms
C = 5 * 10^-6 ;  % Farads
tau = R * C;       % seconds
fsample = 44100;         % sample frequency = 44.1 kHz
delta_time = 1/fsample;     % sampling period = 1/sample frequency

% Bands
band1 = [20 200]; % 20hz to 200hz
band2 = [200 2000]; % 200hz to 2khz
band3 = [2000 10000]; % 2khz to 10khz
band4 = [10000 20000]; % 10khz to 20khz
band5 = [20000 20000]; % 20khz

% Center frequencies sqrt(f1*f2)
center1 = sqrt(20*200);
center2 = sqrt(200*2000);
center3 = sqrt(2000*10000);
center4 = sqrt(10000*20000);
center5 = sqrt (20000*20000);

omega_1 = 2*(pi)*(center1);
omega_2 = 2*(pi)*(center2);

% Set up Step Input:
t1 = 0:delta_time:25/center1;
t2 = 0:delta_time:25/center2;

% Input Complex Exponential:
ce_1 = exp(j*omega_1*t1);
ce_2 = exp(j*omega_2*t2);

% Filter @ 10 Hz:
LowpassFilter10Hz = lsim([1/tau], [1 1/tau], ce_1, t1);
HighpassFilter10Hz = lsim([1 0], [1 1/tau], ce_1, t1);

figure(1);                                        % Lowpass Filter at 10 HZ
subplot(3,1,1);
plot(t1, real(ce_1));
hold on;
plot(t1, real(LowpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('LowPass @ 10Hz: Real');
xlabel('T');
ylabel('A');

% Imaginary:
subplot(3,1,2);
plot(t1, imag(ce_1));
hold on;
plot(t1, imag(LowpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('LowPass @ 10Hz: Imaginary');
xlabel('T');
ylabel('A');

% Complex Magnitude:
subplot(3,1,3);
plot(t1, abs(ce_1));
hold on;
plot(t1, abs(LowpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('LowPass @ 10Hz: Complex Magnitude');
ylim([0 1.1]);
xlabel('T');
ylabel('A');

figure(2);                                       % Highpass Filter at 10 HZ
subplot(3,1,1);
plot(t1, real(ce_1));
hold on;
plot(t1, real(HighpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('HighPass @ 10Hz: Real');
xlabel('T');
ylabel('A');

% Imaginary:
subplot(3,1,2);
plot(t1, imag(ce_1));
hold on;
plot(t1, imag(HighpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('HighPass @ 10Hz: Imaginary');
xlabel('T');
ylabel('A');

% Complex Magnitude:
subplot(3,1,3);
plot(t1, abs(ce_1));
hold on;
plot(t1, abs(HighpassFilter10Hz));
hold off;
legend('Input', 'Output');
title('HighPass @ 10Hz: Complex Magnitude');
ylim([0 1.1]);
xlabel('T');
ylabel('A');
