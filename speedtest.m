lower = 1;
upper = 1e4;
steps = 1e4;
%TODO: mine breaks when upper and steps = 1e5. idk why
x = linspace(lower,upper,steps);

%tcof are the coefficients of the polynomial
tcof = [1,2,3,4];
%n is the degree of thepolynomial we are approximating
n = 3;

%point = polyval(tcof,upper-lower);
%offsetF = @(x) polyval(tcof,x) +  point*rand(1)-(point/2);
offsetF = @(x) polyval(tcof,x);
y = arrayfun(offsetF,x);
tic
[np,ncof] = normalpolyreg(x,y,n);
normalPolyTime = toc;

tic
[fp,fcof] = fasterpolyreg(x,y,n);
fasterPolyTime = toc;
fprintf('The faster time is %.8f while the slower time is %.8f \n',normalPolyTime,fasterPolyTime)
tcof
ncof = ncof'

plot(x,y,'r',x,arrayfun(np,x),'b')
legend('Test function' , 'Our approximation')