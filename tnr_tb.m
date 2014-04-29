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

function tnr_tb(testfile)
if nargin == 0
%     testfile = 'M:\Beehive\TestData\test_tnr.tif';
    testfile = 'M:\Beehive\TestData\Test0801\tnrtest_640x512.tif';
end

%TNR parameters
deltaNF = single(64/8);

for frame = 1:200
    imgOrig = single(imread(testfile, frame));
    imgOrig = imgOrig(1:256, 1:324);
    [imgOut] = tnr_mex(imgOrig, deltaNF);
    figure(10);
    subplot(1,2,1); imshow(imgOrig, []);
    title('Original Image');
    subplot(1,2,2); imshow(imgOut, []);
    title('Output image');
    drawnow;
end
end
