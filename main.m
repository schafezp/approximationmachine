%This will be the center of execution for the matlab scripts that we write.
%
%Authors: Zachary Schafer, James DiTucci, Maxim Zaman, Stephanie Lee
%Class: MA373-01 winter quarter 2015-2016
%Professor: Dr. Graves

function [results] = main(x,y, configuration,v)
if(nargin <2)
    error('We require at least and x and y')
end
if(length(x) ~= length(y))
    error('x and y must have the same length')
end
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


fprintf('R squared Coefficient: \n')
fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSr2, polyyr2, polyy2r2,polyynr2)
fprintf('Root mean square: \n')
fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSrmse, polyyrmse, polyy2rmse,polyynrmse)


% $$$ plot(x,y,'ro','DisplayName',['data','jump distance: 3','jump distance: 5','jump distance: 10'])
plot(x,y,'ro')
hold on
plotCubicSpline(x,y,3,'b')
hold on
plotCubicSpline(x,y,5,'k')
hold on
plotCubicSpline(x,y,10,'m')
hold on
plot(x,polyy)
hold on
plot(x,polyyn,'r')
hold on
plot(x,TLSy,'mx')
hold on
legend('data','jump : 3','jump : 5','jump : 10','polynomial n=1','polynomial n=45','TLS')

% $$$ plot(x,y,'ro',intx3,cubicy3,'b',intx5,cubicy5,'k', intx10,cubicy10, ...
% $$$      'm')
% $$$ legend('data','jump = 3','jump = 5','jump = 10')


%plot(x,y,'x',x,TLSy,'r',x,polyy,'b',x,polyy2,'k',x,polyyn,'m')
%legend('data','TLS linear','Polynomial Linear','Polynomial Degree 2 ','Polynomial Degree 45')
%plot(x,y,'x',x,polyyn,'m')
%legend('data','degree 45 polynomial')


end
