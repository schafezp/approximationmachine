function [] = printcoefficients(polycof)
fprintf('Polynomial coefficients: a + bx + cx^2 + ... \n');
fprintf([mat2str(polycof,5) '\n'])
% $$$ fprintf('Polynomial coefficients: a + bx + cx^2 + ... \n[');
% $$$ for cof=length(polycof):-1:1
% $$$     if(cof == 1)
% $$$         fprintf('%f',polycof(cof))   
% $$$     else
% $$$         fprintf('%f,',polycof(cof))
% $$$     end
% $$$     
% $$$     if(mod(cof,5) == 0)
% $$$         fprintf('\n')
% $$$     end
% $$$ end
% $$$ fprintf(']\n')
