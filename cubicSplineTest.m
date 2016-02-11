data = csvread('infantMortality1907-2008.csv',1,0);
x = data(:,1);
y = data(:,2);


x = [1:10]';
y = x.^2;
v = x;
z = cubicSpline(x,y,v);
if(z==y)
    fprintf('First test is success\n')
else
    fprintf('Test failed\n')
end

x = [1:10]';
y = x.^2;
v = x;

jump = 2;
subx = x(1:jump:length(x))
suby = y(1:jump:length(y))

z = cubicSpline(subx,suby,subx)
z = reshape(z,[],1);
if(z==suby)
    fprintf('Second test is success\n')
else
    fprintf('Second test failed\n')
end
x = [1:10]';
y = x.^2;
v = x;

jump = 2;
subx = x(1:jump:length(x))
suby = y(1:jump:length(y))

z = cubicSpline(subx,suby,x)
z = reshape(z,[],1);
suby = reshape(suby,[],1);
plot(x,y,'r',x,z,'b')
if(z==suby)
    fprintf('Second test is success\n')
else
    fprintf('Second test failed\n')
end
% $$$ x = reshape(x,[],1);
% $$$ y = reshape(y,[],1);
% $$$ v = reshape(v,[],1);
% $$$ 
% $$$ 
% $$$ n = length(x);
% $$$ 
% $$$ dx = x(2:n) - x(1:n-1);
% $$$ dy_x = (y(2:n) - y(1:n-1))./dx;
% $$$ 
% $$$ left = dx(1:end-1);
% $$$ center  = 2*(dx(1:end-1) + dx(2:end));
% $$$ right = dx(2:end);
% $$$ 
% $$$ %construct the matrix A which is the trigonal system on the left to solve
% $$$ A = spdiags([left center right], [-1 0 1], n-2, n-2);
% $$$ %as per the system.
% $$$ rhs = 6*(dy_x(2:end)-dy_x(1:end-1));
% $$$ 
% $$$ %solve for these second derivates, s
% $$$ s = A\rhs;
% $$$ 
% $$$ % Use natural boundary conditions where second derivative
% $$$ % is zero at the endpoints
% $$$ 
% $$$ s = [ 0; s; 0];
% $$$ 
% $$$ 
% $$$ %plug in equations to find s
% $$$ s0 = y;
% $$$ s1 = dy_x - dx.*(2*s(1:end-1) + s(2:end))/6;
% $$$ s2 = s/2;
% $$$ s3 = (s(2:end)-s(1:end-1))./(6*dx);
% $$$ 
% $$$ 
% $$$ 
% $$$ num_points_on_interval = 10;
% $$$ 
% $$$ for itr=1:(n-1)
% $$$         fprintf('v indexes for itr: %d \n', itr)
% $$$         xxvIndexes = find(v >= x(itr) & v < x(itr+1))
% $$$         if(length(xxvIndexes) ~= 0)
% $$$             fprintf('v values for itr: %d \n', itr)
% $$$             xxv = v(xxvIndexes)'
% $$$             fprintf('xi values for itr: %d \n', itr)
% $$$             xvi = repmat(x(itr),1,length(xxv))
% $$$             fprintf('length xxv: %d length xvi %d \n', length(xxv), length(xvi))
% $$$             fprintf('y values for i: %d \n', itr)
% $$$             yv = s0(itr) + s1(itr)*(xxv-xvi) + ... 
% $$$                  s2(itr)*(xxv-xvi).^2 + s3(itr)*(xxv - xvi).^3
% $$$             z(xxvIndexes) = yv;
% $$$         end
% $$$ end
% $$$ 
% $$$ itr = itr + 1
% $$$     fprintf('Edge case run')
% $$$     xxvIndexes = find(v == x(itr))
% $$$     z(xxvIndexes) = y(itr)
% $$$     z = reshape(z,[],1);
