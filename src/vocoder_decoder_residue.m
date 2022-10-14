function [ voice_residue ] = vocoder_decoder_residue( residue, coeff, frames )
%VOCODER_DECODER_RESIDUE Decodificación LPC por medio de residue
% 
%   Input:
%       residue            matrix of the linear prediction residual
%       coeff              matrix of linear prediction coefficients
%       frames             matrix of signal frames
%
%    Output:
%       voice_residue      signal synthesized from the residue
%
%
% 
% 
%   Author: jlnkls
%
%   11/11/2015


%% Input argument check

if (nargin~=3)
   disp(['WARNING: Please enter 3 arguments (see "help vocoder_decoder_residue" for more information)']);
end


%% Synthesis from residue

[rows] = size(frames);

for i=1:rows

       N = 10;

       voice_residue(i,:) = filter(1,coeff(i,:),residue(i,:));

end

voice_residue = voice_residue';

voice_residue = voice_residue(:);




end