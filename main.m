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

% Examples:
% to plot linear, quadratic, and spline of data x and y do:
% main(x,y,'linear,poly_2,spline')

% to plot exponential enter configuration string 'exp'
% main(x,y,'exp')


if(nargin <2)
    error('We require at least and x and y')
end
if(length(x) ~= length(y))
    error('x and y must have the same length')
end

%If plot was open before, close it.
clf('reset')

%make data expected form
x = reshape(x,[],1);
y = reshape(y,[],1);
xy = sortrows([x y],1);
x = xy(:,1);
y = xy(:,2);
%must have over 3 arguments and the configuration string must not
%be empty
if(nargin >= 3 && ~strcmp(configuration,''))
    %Possible configuration options
    configcell  = strsplit(configuration,',');
    colors = {'m','b','r','c'};
    %colors = {'m','b'}
    strings = {};    
    for i=1:length(configcell)
        configs = char(configcell(i));
        %These values will be 1 if the parameter is matched, and 0
        %if it isn't.
        doesMatchPoly = isequal(findstr(configs,'poly') , 1);
        doesMatchLinear = isequal(findstr(configs,'linear') , 1);
        doesMatchTLS = isequal(findstr(configs,'tls') , 1);
        doesMatchSpline = isequal(findstr(configs,'spline') , 1);
        doesMatchExp = isequal(findstr(configs,'exp') , 1);
        %If concatenated is 0, that means that we couldn't match
        %the string.
        concatenated = (doesMatchPoly  || doesMatchLinear || doesMatchTLS ||  doesMatchSpline||doesMatchExp);
        
        %if word parsed is 0 then we did not find a match
        wordParsed  = isequal(1,concatenated);
        %if word parsed is 0 then we did not find a match
        if(~wordParsed)
            error(['Could not parse configuration string. Arguments ' ...
                   'are case sensitive!'])
        end
        
        
        if( doesMatchPoly || doesMatchLinear)
            
            if(doesMatchPoly)
                n = str2num(configs(5:end));
            elseif(doesMatchLinear)
                n = 1;
            else
                error('How did I get here?')
            end    

            [polynf,polycof] = polyreg(x,y,n);
            polyyn = arrayfun(polynf,x);
            [polyynr, polyynrmse] = functionerror(y,polyyn);
            polystring = sprintf('Polynomial degree : %d ',n);
            strings{end+1} = polystring;
            printerror(polyynr,polyynrmse,polystring)
            plot(x,polyyn,colors{mod(i,length(colors)-1)+1});
            hold on   
        elseif(doesMatchTLS)
            [TLSf, TLScof] = TLS(x,y);
            TLSy = arrayfun(TLSf,x);
            [TLSr2, TLSrmse] = functionerror(y,TLSy);
            tlsstring = sprintf('TLS');
            strings{end+1} = tlsstring;
            printerror(TLSr2,TLSrmse,tlsstring)
            plot(x,TLSy,colors{mod(i,length(colors)-1)+1});
            hold on            
        elseif(doesMatchSpline)
            cubicy = cubicSpline(x,y,x);            
            splinestring = sprintf('Spline');
            strings{end+1} = splinestring;

            plot(x,cubicy,colors{mod(i,length(colors)-1)+1});
            hold on   
        elseif(doesMatchExp)
            [expFunc, coeff] = expfit(x,y);
            expy = arrayfun(expFunc,x);
            expstring  = sprintf('Exponential ');
            [expr, exprmse] = functionerror(y,expy);
            printerror(expr,exprmse,expstring)
            strings{end+1} = expstring;
            plot(x,expy,colors{mod(i,length(colors)-1)+1});
            hold on
        else
           error('Match not found. Unexpected error')
        end
        
    end   
    strings{end+1} = 'data';
    plot(x,y,'rx')
    hold on
    legend(char(strings))
%Fit TLS
elseif(nargin == 2 || strcmp(configuration,''))    
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
    jumplengths = [floor(length(x)/10),floor(2*length(x)/10),floor(3*length(x)/10)];
    colors = {'m','k','b'};
    for i=1:length(jumplengths)
        plotCubicSpline(x,y,jumplengths(i),colors{i});
        legendStr = sprintf('jump: %d',i);
        hold on
    end
    %Label data points by title.
    jumps1 = 'jump :10%';
    jumps2 = 'jump :20%';
    jumps3 = 'jump :30%';

    legend('data','polynomial n=1','polynomial n=45','TLS',jumps1,jumps2,jumps3)
end
end
