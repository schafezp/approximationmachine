% %This example shows an example of an instance when TLS seems to be
% %preferable to OLS, It is completely random I just was testing out the
% %function.

close all
% 
% main([1 3 5 6 10],[20 12 8 6 5],'tls,linear')
% figure
% main([1 3 5 6 8],[20 12 8 6 5],'tls,linear')
figure('Name','Data with an outlier')
Screen=get(0,'Screensize');
A=[1 2 3 6 3 2 5 9 4 5];
B=[6 9 7 0 2 4 5 6 9 1];
subplot(2,1,1)
main(A,B,'linear')
title('Ordinary Least Squares')
subplot(2,1,2)
main(A,B,'tls')
title('Total Least Squares')