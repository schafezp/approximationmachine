currentpath = cd('..');
parentpath = pwd()
figure('Name','datfit : Exponential Model')
%Set coefficients for the equations.
A = 2;
B = 3;

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

%Here we use our function to 
cof = datfit(x,y,'exp')
%we return the coefficients so we can use them here if we want to.

title('Exponential fit to 2exp(3*x)')
%restore previous path
cd(currentpath);
