xi=[1 2 4 5 6 7 9]'
eta=[4 1 5 6 5 7 9]'
xx=-1:11;
A=[ones(size(xi)) xi eta]
[m n]=size(xi)
m=max(siqze(A))
sqm=sqrt(m)
u=ones(size(xi))
u(1)=u(1)+sqm
u=u/sqrt(sqm*(1+sqm))
QA=A-u*u'*A
AA=QA(2:m,2)
[U,S,Vt]=SVD_Test([AA,QA(2:m,3)])
s=Vt(n+1,n+1)
if s==0
    error('TLS Solution DNE')
end
a=-Vt(1:n,n+1)/s
b=-(QA(1,2)*a-QA(1,3))/QA(1,1)
hold on
plot(xi,eta,'x')
plot(xx,a*xx+b)
hold off