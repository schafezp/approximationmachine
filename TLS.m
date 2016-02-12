function [TLSf, TLScof ] = TLS( A,B )
%Inputs: 
%A = Vector of Independant Variables
%B = Vector of Dependant Variables
% Outputs:
%TLScof = Row Vector [a b] Where a+b*x is the TLS Apprx
%TLSf = A function handle to the TLS approximation.

%Matricies need to be column vectors
%A=A';                                   
%B=B';
A = reshape(A,[],1);
B = reshape(B,[],1);
% xx will be used later to plot result
xx=min(A)-2:max(A)+2;   
M=[ones(size(A)) A B];
[m n]=size(A);
m=max(size(M));
sqm=sqrt(m);
u=ones(size(A));
u(1)=u(1)+sqm;
u=u/sqrt(sqm*(1+sqm));
QM=M-u*u'*M;
MM=QM(2:m,2);
[U,S,Vt]=SVD([MM,QM(2:m,3)]);
s=Vt(n+1,n+1);
if s==0;
    error('TLS Solution DNE')
end
b=-Vt(1:n,n+1)/s;
a=-(QM(1,2)*b-QM(1,3))/QM(1,1);
% $$$ hold on
% $$$ plot(A,B,'x')
% $$$ plot(xx,a*xx+b)
% $$$ hold off
TLScof=[b,a];
TLSf = @(x) a + b*x;
end

