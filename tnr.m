%**************************************************************************
%NAME               tnr_tb.m
%VERSION            1.0
%DATE               01/04/2013
%Created by         Stephanie Lin
%Last edited by     Stephanie Lin
%**************************************************************************

%**************************************************************************
%Description: 
%User Controls for TNR
%**************************************************************************
%**************************************************************************
% Revision 1.0 - File Created (copied from other folder)
%
% Additional Comments:
%
%**************************************************************************

function [imgOut] = tnr(thisFrame, deltaNF)

persistent prevFrame
if isempty(prevFrame)
    prevFrame = thisFrame;%zeros(size(thisFrame), 'single');
end
imgOut = zeros(size(thisFrame), 'single');

DELTA_MAX = single(32);
SIGMA = single(16); %No need to change this data is scaled to fit table using delta_nf_in
dfLUT = single([round(16*exp(-(0:DELTA_MAX-2).^2/SIGMA^2)) 0]);

[rows, cols] = size(thisFrame);
delta = thisFrame - prevFrame;

for r = 1:rows
   for c = 1:cols 
        % Grab center pixel from present/previous kernel
       prevCP = prevFrame(r,c);
       presCP = thisFrame(r,c);
       % Define kernel for the delta
       startR  = max(1, r-1);
       endR    = min(rows, r+1);
       startC  = max(1, c-1);
       endC    = min(cols, c+1);
       kernel  = delta(startR:endR, startC:endC);
              
       kernelSum       = sum(kernel(:));
       kernelSumAbs    = abs(kernelSum);
       nhoodDelta      = round(kernelSumAbs * deltaNF/64);
       nhoodDeltaClamp = min(DELTA_MAX, nhoodDelta);
       
       df       = dfLUT(max(1,nhoodDeltaClamp));
       df_inv   = 16-df;
       
       pixFilt = (df*prevCP + df_inv*presCP)/16;
       imgOut(r,c) = single(pixFilt);
   end
end
prevFrame = imgOut;
end
