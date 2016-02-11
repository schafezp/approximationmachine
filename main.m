%This will be the center of execution for the matlab scripts that we write.
%
%Authors: Zachary Fuckface, James DiTucci, Maxim Zaman, Stephanie Lee
%Class: MA373-01 winter quarter 2015-2016
%Professor: Dr. Graves

function [results] = main(x,y, configuration)
%Fit TLS
[TLSf, TLScof] = TLS(x,y);
TLSy = arrayfun(TLSf,x);
[TLSr2, TLSrmse] = functionerror(y,TLSy);
% Fit linear polynomial
[polyf,polycof] = polyreg(x,y,1);
polyy = arrayfun(polyf,x);
[polyyr2, polyyrmse] = functionerror(y,polyy);
% Fit degree 2 polynomial
[polyf2,polycof2] = polyreg(x,y,2);
polyy2 = arrayfun(polyf2,x);
[polyy2r2, polyy2rmse] = functionerror(y,polyy2);
% Fit degree 45 polynomial
[polyfn,polycof3] = polyreg(x,y,45);
polyyn = arrayfun(polyfn,x);
[polyynr2, polyynrmse] = functionerror(y,polyyn);

jump = 5;
subx = x(1:jump:length(x))
suby = y(1:jump:length(y))

cubicy = cubicSpline(subx,suby,subx)
length(subx)
length(cubicy)
fprintf('R squared Coefficient: \n')
fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSr2, polyyr2, polyy2r2,polyynr2)
fprintf('Root mean square: \n')
fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSrmse, polyyrmse, polyy2rmse,polyynrmse)
plot(x,y,'ro',subx,cubicy,'b')


%plot(x,y,'x',x,TLSy,'r',x,polyy,'b',x,polyy2,'k',x,polyyn,'m')
%legend('data','TLS linear','Polynomial Linear','Polynomial Degree 2 ','Polynomial Degree 45')
%plot(x,y,'x',x,polyyn,'m')
%legend('data','degree 45 polynomial')


end
