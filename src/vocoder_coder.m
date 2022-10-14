function [ E, coeff, sonority, pitch, residue, frame, y, fs, frames ] = vocoder_coder( audio_file )
%VOCODER_CODER Reading the audio signal 'audio_file' and LPC encoding
% 
%   Input:
%       audio_file         name of the file to process
%
%    Output:
%       E                  nergy vector for each frame
%       coeff              matrix of linear prediction coefficients
%       sonority           sonority vector for each frame
%       pitch              vector of pitch periods for each frame
%       residue            matrix of the linear prediction residual
%       frame              analysis frame length
%       y                  original signal being read
%       fs                 signal sampling rate
%       frames             matrix of signal frames
%
%
% 
% 
%   Author: jlnkls
%
%   11/11/2015


%% Input argument check

if (nargin~=1)
   disp(['WARNING: Please enter the name of the audio file to process as an argument']);
end


%% Audio signal input

[y, fs] = audioread(audio_file);

[rows, ~] = size(y);

if (rows>1)
    y = y(:,1);
end


%% LPC encoding

frame = 30e-3*fs;

k = 0;

w = hamming(frame);

for i=1:frame:length(y)
    
    k=k+1;

     if ((i+frame-1)<=length(y))


        frames(k,:) = y(i:(i+frame-1));
        
        
     end


end


for i=2:k
    
       z=i-1;
    
       frames(z,:) = frames(z,:) - mean(frames(z,:));

       N = 25;
       Wn = 900/(fs/2);

       B = fir1(N,Wn);

       frames(z,:) = filter(B,1,frames(z,:));

       N = 10;

       coeff(z,:) = lpc(frames(z,:),N);

       residue(z,:) = filter(coeff(z,:),1,frames(z,:));
       
       E(z) = sum(abs(residue(z,:))).^2;

       autocorr = xcorr(residue(z,:));

       [max1, pos1] = max(autocorr);

       [max2, pos2] = max(autocorr(pos1+round(2.5e-3*fs):pos1+round(20e-3*fs)));
       
       pos2abs = pos2+pos1+round(2.5e-3*fs)-1;

       if (max2>(0.25*max1))

           sonority(z) = 1;
           pitch(z) = abs(pos2abs-pos1);
           fpitch(z) = 1/(pitch(z)/fs);


       else

           sonority(z) = 0;
           pitch(z) = 0;
           fpitch(z) = 0;


       end

end


end