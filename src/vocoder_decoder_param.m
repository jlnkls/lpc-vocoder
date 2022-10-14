function [ voice_param ] = vocoder_decoder_param( E, coeff, sonora, pitch, residue, frame, frames )
%VOCODER_DECODER_PARAM Decodificación LPC por medio de parámetros
% 
%   Input:
%       E                  nergy vector for each frame
%       coeff              matrix of linear prediction coefficients
%       sonority           sonority vector for each frame
%       pitch              vector of pitch periods for each frame
%       residue            matrix of the linear prediction residual
%       frame              analysis frame length
%       frames             array of signal frames
%
%    Output:
%       voice_param          signal synthesized from parameters
%
%
% 
% 
%   Author: jlnkls
%
%   11/11/2015


%% Input argument check

if (nargin~=7)                                                                                                               
   disp(['WARNING: Please enter 7 arguments (see "help vocoder_decoder_param" for more information)']);
end


%% Parametric synthesis

[rows] = size(frames);

for i=1:rows
    
    if (sonority(i)==1)

        voice_generated_param(i,:) = zeros(1,frame);
        
        for k=1:pitch(i):frame
            voice_generated_param(i,k) = 1;
        end
            
        local_energy = sum(abs(voice_generated_param(i,:))).^2;
        
        voice_generated_param(i,:) = sqrt(E(i)/local_energy)* voice_generated_param(i,:);


    else
        
        voice_generated_param(i,:) = randn(1,frame);
        
        local_energy = sum(abs(voice_generated_param(i,:))).^2;
        
        voice_generated_param(i,:) = sqrt(E(i)/local_energy)* voice_generated_param(i,:);


    end

    voice_param(i,:) = filter(1,coeff(i,:),voice_generated_param(i,:));


end

voice_param = voice_param'; 
voice_param = voice_param(:);


end