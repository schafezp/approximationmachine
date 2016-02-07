function [ Coe ] = TLS_Test( A,B )
%Inputs: 
%A = Row Vector of Independant Variables
%B = Row Vector of Dependant Variables
% Outputs:
%Coe = Row Vector [a b] Where a+b*x is the TLS Linear Approximation

%Matricies need to be column vectors
A=A';   
B=B';
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
[U,S,Vt]=SVD_Test([MM,QM(2:m,3)]);
s=Vt(n+1,n+1);
if s==0;
    error('TLS Solution DNE')
end
a=-Vt(1:n,n+1)/s;
b=-(QM(1,2)*a-QM(1,3))/QM(1,1);
hold on
plot(A,B,'x')
plot(xx,a*xx+b)
hold off
Coe=[a,b];
end

