function [p,coeff] = fasterpolyreg(x,y,n)
% this method should return a polynomial function p which is the best least squares fit to the data [x,y] 
%using the basis functions of 1,x,...,x^n
% Reshape our data so that our function works whether we get column or row vectors
x = reshape(x,[],1);
y = reshape(y,[],1);
inner = @(a,b) dot(a,b);
% loop over rows to i
for i=1:n+1
    for j=i:n+1
      Ax(i,j) = inner(x.^(i-1),x.^(j-1));
      Ax(j,i) = Ax(i,j);
    end
end
for i=1:n+1
   Ay(i,1) = inner(x.^(i-1),y);
end
%TODO: might be slightly faster if we just solve Ax/Ay? Test laster.
A = [Ax Ay];
A = rref(A);

coeff = A(:,n+2);
%now that we have all the coefficients we must reorder them.
coeff = coeff(n+1:-1:1);
p = @(x) polyval(coeff,x);
%plot(x,y,'ro',x,arrayfun(p,x),'b')
