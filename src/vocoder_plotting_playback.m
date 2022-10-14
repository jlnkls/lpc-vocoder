function [] = vocoder_plotting_playback( y, voice_residue, voice_param, fs )
%vocoder_plotting_playback Plotting and playback of the following signals:
% original signal, signal synthezized from the residue, and signal synthezized from parameters
% 
%    Input:
%       y                    original signal
%       voice_residue        signal synthesized from the residue
%       voice_param          signal synthesized from parameters
%
%
%
% 
% 
%   Author: jlnkls
%
%   11/11/2015


%% Input argument check

if (nargin~=4)
   disp(['WARNING: Please enter 4 arguments (see "help vocoder_plotting_playback" for more information)']);
end


%% Plotting

figure;
t=1:length(y);
t=t./fs;
plot(t,y);
hold on;
t=1:length(voice_residue);
t=t./fs;
plot(t,voice_residue,'r');
plot(t,voice_param,'g');
xlabel('Time [s]','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
legend('y','voz-residue','voz-param');
title('Signals: plotting','FontSize',20,'FontWeight','bold');


figure;
t=1:length(y);
t=t./fs;
plot(t,y);
xlabel('Time [s]','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
legend('y');
title('Original signal','FontSize',20,'FontWeight','bold');


figure;
t=1:length(voice_residue);
t=t./fs;
plot(t,voice_residue,'r');
xlabel('Time [s]','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
legend('voz-residue');
title('Signal synthesized from the residue','FontSize',20,'FontWeight','bold');


figure;
t=1:length(voice_param);
t=t./fs;
plot(t,voice_param,'g');
xlabel('Time [s]','FontSize',12,'FontWeight','bold');
ylabel('Amplitude','FontSize',12,'FontWeight','bold');
legend('voz-param');
title('Signal synthesized from parameters','FontSize',20,'FontWeight','bold');


%% Signal playback

playback_pause = ceil(length(y)/fs);

disp(['Original signal']);
soundsc(y,fs);
pause(playback_pause);

disp(['Signal synthesized from the residue']);
soundsc(voice_residue,fs);
pause(playback_pause);

disp(['Signal synthesized from parameters']);
soundsc(voice_param,fs);
pause(playback_pause);

end