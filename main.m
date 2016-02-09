%This will be the center of execution for the matlab scripts that we write.
%
%Authors: Zachary Fuckface, James DiTucci, Maxim Zaman, Stephanie Lee
%Class: MA373-01 winter quarter 2015-2016
%Professor: Dr. Graves

function [results] = main(x,y, configuration)
[TLScof] = TLS(x,y)
TLSa = TLScof(1);
TLSb = TLScof(2);
TLSfunc = @(x) TLSa + TLSb*x
[polyf,polycof] = polyreg(x,y,1)
polyy = arrayfun(polyf,x)
TLSy = arrayfun(TLSfunc,x)

[polyf2,polycof2] = polyreg(x,y,2)
polyy2 = arrayfun(polyf2,x)
[polyfn,polycof3] = polyreg(x,y,15)
polyyn = arrayfun(polyfn,x)
%plot(x,y,'x',x,polyy,'b',x,TLSy,'r')
plot(x,y,'x',x,polyy,'b',x,TLSy,'r',x,polyy2,'k',x,polyyn,'m')
legend('data','linear poly','tls linear','second degree polynomial','degree 10 polynmial')


end
