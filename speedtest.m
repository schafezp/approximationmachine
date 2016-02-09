lower = 1;
upper = 1e5;
steps = 1e5;
x = linspace(lower,upper,steps);

%tcof are the coefficients of the polynomial
tcof = [1,2,3,4,3,2,1];
%n is the degree of thepolynomial we are approximating
n = 4;

%point = polyval(tcof,upper-lower);
%offsetF = @(x) polyval(tcof,x) +  point*rand(1)-(point/2);
testpolyfunc = @(x) polyval(tcof,x);
y = arrayfun(testpolyfunc,x);
tic
[fp,fcof] = polyreg(x,y,n);
polyTime = toc;
fprintf('The runtime is %.8f\n',polyTime)
fcof = fcof'

plot(x,y,'r',x,arrayfun(fp,x),'b')
legend('Test function' , 'Our approximation')
