function [z] = cubicSpline(x,y,v)

%return a vector z which is the resulting function evaluated at all
%points v
    
%If no argument v is provided, the cublic spline is to be plot
%against x and y.
    
%We will be employing the smart solution which involves solving for
%s, the list of second derivatives, then use that to find our
%solutions.
if(nargin<2)
    error('We expect to at least get an x and y input')
end
x = reshape(x,[],1);
y = reshape(y,[],1);
if(nargin==3)
    v = reshape(v,[],1);
end
z = [];

n = length(x);

dx = x(2:n) - x(1:n-1);
dy_x = (y(2:n) - y(1:n-1))./dx;

left = dx(1:end-1);
center  = 2*(dx(1:end-1) + dx(2:end));
right = dx(2:end);

%construct the matrix A which is the trigonal system on the left to solve
A = spdiags([left center right], [-1 0 1], n-2, n-2);
%as per the system.
rhs = 6*(dy_x(2:end)-dy_x(1:end-1));

%solve for these second derivates, s
s = A\rhs;

% Use natural boundary conditions where second derivative
% is zero at the endpoints

s = [ 0; s; 0];


%plug in equations to find s
s0 = y;
s1 = dy_x - dx.*(2*s(1:end-1) + s(2:end))/6;
s2 = s/2;
s3 = (s(2:end)-s(1:end-1))./(6*dx);



num_points_on_interval = 10;

%if we only get x and y
if(nargin<3)
    plot(x,y,'ro')
    hold on
    for i=1:(n-1)
        xx = linspace(x(i),x(i+1),num_points_on_interval);
        xi = repmat(x(i),1,num_points_on_interval);
        yy = s0(i) + s1(i)*(xx-xi) + ... 
             s2(i)*(xx-xi).^2 + s3(i)*(xx - xi).^3;
        
        plot(xx,yy,'b')
    end
    hold off
% if we get x,y,v
elseif(nargin==3)    
    for itr=1:(n-1)
        fprintf('v indexes for itr: %d \n', itr)
        xxvIndexes = find(v >= x(itr) & v < x(itr+1))
        if(length(xxvIndexes) ~= 0)
            fprintf('v values for itr: %d \n', itr)
            xxv = v(xxvIndexes)'
            fprintf('xi values for itr: %d \n', itr)
            xvi = repmat(x(itr),1,length(xxv))
            fprintf('length xxv: %d length xvi %d \n', length(xxv), length(xvi))
            fprintf('y values for i: %d \n', itr)
            yv = s0(itr) + s1(itr)*(xxv-xvi) + ... 
                 s2(itr)*(xxv-xvi).^2 + s3(itr)*(xxv - xvi).^3
            z(xxvIndexes) = yv;
        end
    end
    %covers edge case where one of our v might be the last value of
    %x.
    itr = itr + 1
    fprintf('Edge case run')
    xxvIndexes = find(v == x(itr))
    z(xxvIndexes) = y(itr)
    z = reshape(z,[],1);
end


end
