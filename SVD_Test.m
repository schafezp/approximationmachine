function [ output_args ] = SVD_Test( A )
%Preform SVD on Matrix A
%Find U - A*At -> Eigenvalues and eigen Vectors -> Place in a matrix and
%orthonormalize using Grahm-Schmitt
format rat
AAt=A*transpose(A)
[Evec_U,Eval_U]=eig(AAt) %Get eigenvectors and values
n=length(Evec_U)
Evec_U=Evec_U(:,n:-1:1) %Reorder column do be in decending order, based on eigenvalue
Eval_U=Eval_U([n:-1:1],[n:-1:1])    %Keep consistant with above swap
w=sqrt(dot(Evec_U(:,1),Evec_U(:,1)))
U1=Evec_U(:,1)/w %Normaize the first eigenvector
U2=Evec_U(:,2)-(dot(Evec_U(:,2),U1)/dot(U1,U1)*U1) %Grahm Schmitt Orthonalization
U2=U2/dot(U2,U2)%Normalize
U=[U1 U2]

%Find Vt - At*A -> Eigenvalues and eigen Vectors -> Place in a matrix and
%orthonormalize using Grahm-Schmitt
%Take the transpose
AtA=transpose(A)*A
[Evec_V,Eval_V]=eig(AtA)    %Get eigenvectors and values
n=length(Evec_V)
Evec_V=Evec_V(:,n:-1:1) %Reorder column do be in decending order, based on eigenvalue
Eval_V=Eval_V([n:-1:1],[n:-1:1]) %Keep consistant with above swap
w=sqrt(dot(Evec_V(:,1),Evec_V(:,1)))
V1=Evec_V(:,1)/w %Normaize the first eigenvector
V2=Evec_V(:,2)-(dot(Evec_V(:,2),V1)/dot(V1,V1)*V1) %Grahm Schmitt Orthonalization
V2=V2/sqrt(dot(V2,V2)) %Normalize
V3=Evec_V(:,3)-(dot(Evec_V(:,3),V1)/dot(V1,V1)*V1)-(dot(Evec_V(:,3),V2)/dot(V2,V2)*V2) % Grahm Schmitt
V3=V3/sqrt(dot(V3,V3)) %Normaize 
V=[V1 V2 V3]
Vt=transpose(V)
end

