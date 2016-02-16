currentpath = cd('..');
parentpath = pwd()
figure('Name','datfit : Exponential Model')
%Set coefficients for the equations.
A = 2
B = 3

%set step lengths. steps
%long steps is the number of points that will be plotted of the
%data model.
steps = 10;
longsteps = 45;
lower = 1;
upper = 4;
%generate data
x = linspace(lower,upper,steps);
y = A*exp(x*B);

cof = datfit(x,y,'exp')
a = cof(1);
b = cof(2);
% $$$ linx = linspace(lower,upper,longsteps)
% $$$ plot(linx,a*exp(linx*b),'ro')
legend('Data model approximation')
title('Exponential fit to 1.4exp(1.7x) combined with 1.3exp(1.9x)')
%restore previous path
cd(currentpath);
