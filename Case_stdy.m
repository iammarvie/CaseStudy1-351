%% Introduction
% * Author:                   Mordecai Ethapemi, Joshua Hernandez
% * Class:                    ESE 351
% * Date:                     Created 02/26/2023, Last Edited 03/03/2023
% * With contributions from:  Dr. Jason Trobaugh
% *                        :  https://www.mathworks.com/help/
% *                        :  

%% clear all; close all; echo off;
R = 1000;
C = 5*10^(-6);
tau = R*C;
t_end = 15*tau;
fs = 44100;
delta_t = 1/fs;
t_naught = 2*tau;
t = [0:delta_t:t_end];

%Bands
band1 = [20 200]; %20hz to 200hz
band2 = [200 2000]; %200hz to 2khz
band3 = [2000 10000]; %2khz to 10khz
band4 = [10000 20000]; %10khz to 20khz
band5 = [20000 20000]; %20khz

%Center frequencies sqrt(f1*f2)
center1 = sqrt(20*200);
center2 = sqrt(200*2000);
center3 = sqrt(2000*10000);
center4 = sqrt(10000*20000);
center5 = sqrt (20000*20000);

%filter coefficients
ahigh = [1 ((1/fs)/tau)-1];
bhigh = [1 -1];
blow = [0 ((1/fs)/tau)];
alow = [1 ((1/fs)/tau)-1];


%HIGH PASS
input = zeros(1,length(t)); %
input(1) = 1;
yhigh_fil = filter(bhigh,ahigh,input); %filter

%LOW PASS
ylow_fil = filter(blow,alow,input);

%% TREBLE BOOST (HIGH PASS FILTER)
%% BASS BOOST (LOW PASS FILTER)
%% 