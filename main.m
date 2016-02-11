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
%make data expected form
x = reshape(x,[],1);
y = reshape(y,[],1);
xy = sortrows([x y],1);
x = xy(:,1);
y = xy(:,2);
length(x)
length(y)

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

plot(x,y,'ro')
hold on
plot(x,polyy,'b')
hold on
plot(x,polyyn,'m')
hold on
plot(x,TLSy,'m')
hold on
legend('data','polynomial n=1','polynomial n=45','TLS')

jumplengths = [floor(length(x)/10),floor(2*length(x)/10),floor(3*length(x)/10)]
colors = ['m','k','b']
for i=1:length(jumplengths)
    plotCubicSpline(x,y,jumplengths(i),colors(i))
    legendStr = sprintf('jump: %d',i)    
    hold on
    end

jumps1 = sprintf('jump : %d',jumplengths(1))
jumps2 = sprintf('jump : %d',jumplengths(2))
jumps3 = sprintf('jump : %d',jumplengths(3))


legend('data','polynomial n=1','polynomial n=45','TLS',jumps1,jumps2,jumps3)

end
