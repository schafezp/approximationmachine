currentpath = cd('..');
parentpath = pwd()

x = linspace(-2,2,100);
%y = tanh(x/2) + exp(x.^1.3/4) + sin(3*x);
y = 1./(1+5*x.^2) + tanh(x/2);
%plot(x,y,'r')
subplot(2,1,1)
main(x,y,'spline,poly9,poly12')
title('Difficult Function: y = 1/(1+5*x^2) + tanh(x/2)')
subplot(2,1,2)
main(x,y,'spline,linear,poly2,poly4,poly6,poly8')
title('Difficult Function: y = 1/(1+5*x^2) + tanh(x/2)')
%possible

%restore previous path
cd(currentpath);
