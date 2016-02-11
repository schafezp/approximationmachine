%This will be the center of execution for the matlab scripts that we write.
%
%Authors: Zachary Schafer, James DiTucci, Maxim Zaman, Stephanie Lee
%Class: MA373-01 winter quarter 2015-2016
%Professor: Dr. Graves

function [results] = main(x,y, configuration,v)
% x and y are two vectors of the same length
% configuration is a string of parameters deliminated by commans.
% for example to plot degree 2,4 poly and tls call the following:
% main(x,y,'poly_2,poly_4,TLS')
% v is an optional parameter of values to be evaluated and returned
% by the some method.
if(nargin <2)
    error('We require at least and x and y')
end
if(length(x) ~= length(y))
    error('x and y must have the same length')
end
%make data expected form
x = reshape(x,[],1);
y = reshape(y,[],1);
xy = sortrows([x y],1);
x = xy(:,1);
y = xy(:,2);

if(nargin >= 3)
    %Possible configuration options
    configcell  = strsplit(configuration,',');
    colors = {'m','b','r','c'};
    %colors = {'m','b'}
    strings = {'data'};
    hold off
    plot(x,y,'rx')
    hold on
    for i=1:length(configcell)
        configs = char(configcell(i));
        if(findstr(configs,'poly_') == 1)
            n = str2num(configs(6:end));
            [polynf,polycof] = polyreg(x,y,n);
            polyyn = arrayfun(polynf,x);
            [polyynr, polyynrmse] = functionerror(y,polyyn);
            polystring = sprintf('Polynomial degree : %d ',n);
            strings{end+1} = polystring;
            fprintf('R squared Coefficient: \n');
            fprintf('%s, %f, \n', polystring, polyynr);
            fprintf('Root mean square: \n');
            fprintf('%s , %f \n', polystring, polyynrmse);        
            plot(x,polyyn,colors{mod(i,length(colors)-1)+1});
            hold on   
        elseif(findstr(configs,'TLS') == 1)
            [TLSf, TLScof] = TLS(x,y);
            TLSy = arrayfun(TLSf,x);
            [TLSr2, TLSrmse] = functionerror(y,TLSy);
            tlsstring = sprintf('TLS ');
            strings{end+1} = tlsstring;
            fprintf('R squared Coefficient: \n');
            fprintf('%s, %f, \n', tlsstring, TLSr2);
            fprintf('Root mean square: \n');
            fprintf('%s , %f \n', tlsstring, TLSrmse);
            plot(x,TLSy,colors{mod(i,length(colors)-1)+1});
            hold on            
        elseif(findstr(configs,'spline') == 1)
            cubicy = cubicSpline(x,y,x);            
            splinestring = sprintf('Spline');
            strings{end+1} = splinestring;

            plot(x,cubicy,colors{mod(i,length(colors)-1)+1});
            hold on            
        end
    end
    legend(char(strings))
%Fit TLS
elseif(nargin == 2 || configuration=='')
    [TLSf, TLScof] = TLS(x,y);
    TLSy = arrayfun(TLSf,x);
    [TLSr2, TLSrmse] = functionerror(y,TLSy);
    % Fit linear polynomial
    [polyf,polycof] = polyreg(x,y,1);
    polyy = arrayfun(polyf,x);
    [polyyr2, polyyrmse] = functionerror(y,polyy);
    % Fit degree 2 polynomial
    [polyf2,polycof2] = polyreg(x,y,2);
    polyy2 = arrayfun(polyf2,x);
    [polyy2r2, polyy2rmse] = functionerror(y,polyy2);
    % Fit degree 45 polynomial
    [polyfn,polycof3] = polyreg(x,y,45);
    polyyn = arrayfun(polyfn,x);
    [polyynr2, polyynrmse] = functionerror(y,polyyn);


    fprintf('R squared Coefficient: \n')
    fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSr2, polyyr2, polyy2r2,polyynr2)
    fprintf('Root mean square: \n')
    fprintf('TLS: %f , Polyn1: %f , Polyn2: %f, polyn45: %f, \n', TLSrmse, polyyrmse, polyy2rmse,polyynrmse)

    plot(x,y,'ro')
    hold on
    plot(x,polyy,'b')
    hold on
    plot(x,polyyn,'k')
    hold on
    plot(x,TLSy,'y')
    hold on
    legend('data','polynomial n=1','polynomial n=45','TLS')
    jumplengths = [floor(length(x)/10),floor(2*length(x)/10),floor(3*length(x)/10)]
    colors = ['m','k','b']
    for i=1:length(jumplengths)
        plotCubicSpline(x,y,jumplengths(i),colors(i))
        legendStr = sprintf('jump: %d',i)    
        hold on
    end
    %Label data points by title.
    jumps1 = 'jump :10%'
    jumps2 = 'jump :20%'
    jumps3 = 'jump :30%'

    legend('data','polynomial n=1','polynomial n=45','TLS',jumps1,jumps2,jumps3)


end
