% %This example shows an example of an instance when TLS seems to be
% %preferable to OLS, It is completely random I just was testing out the
% %function.

%This is a workaround to the pathing problem. This will temporarily
%change the directory one level up, then restore it at the end.
currentpath = cd('..');
parentpath = pwd()


close all
figure('Name','Data with an outlier')
Screen=get(0,'Screensize');
A=[1 2 3 6 5 9 4];
B=[6 9 7 0 5 6 9];
subplot(3,1,1)
datfit(A,B,'linear')
title('Ordinary Least Squares')
subplot(3,1,2)
datfit(A,B,'spline')
title('Spline fit')


%restore previous path
cd(currentpath);
