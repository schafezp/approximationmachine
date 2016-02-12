function [expf, coeff] = expfit(x,y)
%Find best fit c*exp(k*x) for x,y plot.
%Input: Two vectors of the same length x and y
%Output: expf is a function handle to our approximation
%Output: coeff is the coefficients [c,k] for this fit.

%take ln(c*exp(k*x)) = ln(c) + k
if(nargin<2)
    error('We require two inputs')
end
x = reshape(x,[],1);
y = reshape(y,[],1);

a11 = length(x);
a12 = sum(x);
a21 = a12;
a22 = sum(x.*x);

lys = log(y);

y1 = sum(lys);
yx = sum(x .* lys);

M = [a11 a12 ; a21 a22];
rhs = [y1 ;yx];
coeff =  M \ rhs;

coeff(1) = exp(coeff(1));

c = coeff(1);
k = coeff(2);

expf = @(x) c*exp(k*x);

end
