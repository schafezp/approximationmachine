xi=[1 2 4 5 6 7 9]'
eta=[4 1 5 6 5 7 9]'
A=[ones(size(xi)) xi eta]
m=max(size(A))
sqm=sqrt(m)
u=ones(size(xi))
u(1)=u(1)+sqm
u/sqrt(sqm*(1+sqm))
QA=A-u*u'*A
AA=QA(2:m,2)
[U,S,Vt]=SVD_Test([AA,QA(2:m,3)])
s=Vt(n+1,n+1)
if s==0
    error('TLS Solution DNE')
end
X=-Vt(1:n,n+1)/s