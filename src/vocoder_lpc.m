function [y, voice_residue, voice_param] = vocoder_lpc( audio_file )
%VOCODER_LPC
%
% LPC encoding of an audio signal 'audio_file', and decoding
% (synthesis) via the residue of the original signal and the
% parameters of the LPC encoding. Comparison between the 3 signals.
%
%   Input:
%       audio_file           name of the file to process
%
%    Output:
%       y                    original signal
%       voice_residue        signal synthesized from the residue
%       voice_param          signal synthesized from parameters
%
%
% 
% 
%   Author: jlnkls
%
%   11/11/2015


%% Input argument check

if (nargin~=1)
   disp(['WARNING: Please enter the name of the audio file (+ path) to process as an argument']);
end


%% Audio signal input and LPC encoding

[ E, coeff, sonority, pitch, residue, frame, y, fs, frames ] = vocoder_coder( audio_file );

%% Synthesis via residue

[ voice_residue ] = vocoder_decoder_residue( residue, coeff, frames );

%% Parametric synthesis

[ voice_param ] = vocoder_decoder_param( E, coeff, sonority, pitch, residue, frame, frames );


%% Graphic representation and reproduction of signals

vocoder_plotting_playback( y, voice_residue, voice_param, fs );      


end