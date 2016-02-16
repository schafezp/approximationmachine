%Demo is a sub folder of main so we must navigate up to use it's functions
%We want to save 
currentpath = cd('..');
parentpath = pwd()

% $$$ x = linspace(-1,3,100);
% $$$ y = 1./(1+5*x.^2) + tanh(x/2);
% $$$ subplot(2,1,1)
% $$$ datfit(x,y,'spline,poly7,poly10')
% $$$ title('Difficult Function: y = 1/(1+5*x^2) + tanh(x/2)')
% $$$ subplot(2,1,2)
% $$$ datfit(x,y,'spline,poly2,poly4,poly6')
% $$$ title('Difficult Function: y = 1/(1+5*x^2) + tanh(x/2)')


x = linspace(-2,2,100);
y = 1./(1+5*x.^2) ;

subplot(2,1,1)
datfit(x,y,'spline,poly2,poly4,poly6')
title('Difficult Function: y = 1/(1+5*x^2)')
subplot(2,1,2)
datfit(x,y,'spline,poly7,poly10')
title('Difficult Function: y = 1/(1+5*x^2)')

% $$$ x = linspace(-2,2,100);
% $$$ y = sin(x)./x ;
% $$$ subplot(2,1,1)
% $$$ datfit(x,y,'spline,poly7,poly10')
% $$$ title('Difficult Function: y = 1/(1+5*x^2)')
% $$$ subplot(2,1,2)
% $$$ datfit(x,y,'spline,poly2,poly4,poly6')
% $$$ title('Difficult Function: y = 1/(1+5*x^2)')


%possible

%restore previous path
cd(currentpath);
