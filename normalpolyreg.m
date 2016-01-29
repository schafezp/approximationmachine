function p = normalpolyreg(x,y,n)
% this method should return a polynomial function p which is the best least squares fit to the data [x,y] 
%using the basis functions of 1,x,...,x^n
% Reshape our data so that our function works whether we get column or row vectors
p=1;
x = reshape(x,[],1)
y = reshape(y,[],1)
N = length(x)
inner = @(a,b) dot(a,b);
% loop over rows to i
for i=1:n+1
    %this inner loop doesn't need to go all the way to n since we have
    %symmetry in this matrix. Fix later.
    for j=1:n+1
      Ax(i,j) = inner(x.^(i-1),x.^(j-1))
    end
end
for i=1:n+1
   Ay(i,1) = inner(x.^(i-1),y) 
end
A = [Ax Ay]
A = rref(A)

coeff = A(:,n+2)
%now that we have all the coefficients we must reorder them.
coeff = coeff(n+1:-1:1)
p = @(x) polyval(coeff,x)
plot(x,y,'ro',x,arrayfun(p,x),'b')
