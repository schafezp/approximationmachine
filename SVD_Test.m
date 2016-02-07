function [ U,S,V] = SVD_Test( A )
%Preform SVD on Matrix AV
%Find U - A*At -> Eigenvalues and eigen Vectors -> Place in a matrix and
%orthonormalize using Grahm-Schmitt
syms lam    % Will be used for finding eigenvectors
format short
AAt=A*transpose(A)
[Evec_U,Eval_U]=eig(AAt) %Get eigenvectors and values
n=length(Evec_U);
U=Evec_U(:,n:-1:1) %Reorder column do be in decending order, based on eigenvalue
Eval_U=Eval_U([n:-1:1],[n:-1:1])    %Keep consistant with above swap


%Find Vt - At*A -> Eigenvalues and eigen Vectors -> Place in a matrix and
%orthonormalize using Grahm-Schmitt
%Take the transpose
AtA=transpose(A)*A
[Evec_V,Eval_V]=eig(AtA)    %Get eigenvectors and values
n=length(Evec_V)
V=Evec_V(:,n:-1:1) %Reorder column do be in decending order, based on eigenvalue
Eval_V=Eval_V([n:-1:1],[n:-1:1]) %Keep consistant with above swap
%Vt=transpose(V)

Eval_V = nonzeros(diag(Eval_V))
m=length(Eval_V)
S=zeros(m,n)
N=0
for N= [1:m]
    S(N,N)=sqrt(Eval_V(N,1))
end
%S
V
% s=V(n+1,n+1)
% -V(n:1, n+1)/s
end

