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
% if only one fit is specified, the function returns an array of
% coefficents, if more than one fit is specified it returns an empty set
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

if(nargin == 4)
    results = [];
    v = reshape(v,[],1);
end
%Set up default display values
displayPolyCof = [1,2,10];

%colors strats with the second indexed color... too lazy to fix :D
colors = {'g','b','k','m','r','c'};
%make data expected form
x = reshape(x,[],1);
y = reshape(y,[],1);
xy = sortrows([x y],1);
x = xy(:,1);
y = xy(:,2);
%create an empty array
results=[];
%must have over 3 arguments and the configuration string must not
%be empty
if(nargin >= 3 && ~strcmp(configuration,''))
    %Possible configuration options
    configcell  = strsplit(configuration,',');
    
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
            printcoefficients(polycof);
            if(length(configcell)==1 && nargin==3)
                results = polycof;
            end
            if(nargin == 4)
                results = [results  arrayfun(polynf,v)];
            end
            plot(x,polyyn,colors{mod(i,length(colors)-1)+1});
            hold on   
        elseif(doesMatchTLS)
            [TLSf, TLScof] = TLS(x,y);
            TLSy = arrayfun(TLSf,x);
            [TLSr2, TLSrmse] = functionerror(y,TLSy);
            tlsstring = sprintf('TLS');
            strings{end+1} = tlsstring;
            printerror(TLSr2,TLSrmse,tlsstring)
            printcoefficients(TLScof)
            if(length(configcell)==1 && nargin==3)
                results = TLScof;
            end
            if(nargin == 4)
                results = [results  arrayfun(TLSf,v)];
            end
            
            plot(x,TLSy,colors{mod(i,length(colors)-1)+1});
            hold on            
        elseif(doesMatchSpline)
            cubicy = cubicSpline(x,y,x);            
            splinestring = sprintf('Spline');
            strings{end+1} = splinestring; 
            if(nargin == 4)                
                cubicv = cubicSpline(x,y,v);
                results = [results  cubicv];
            end
            %plot(x,cubicy,colors{mod(i,length(colors)-1)+1});
            plotCubicSpline(x,cubicy,1,colors{mod(i,length(colors)-1)+1});
            hold on   
        elseif(doesMatchExp)
            [expFunc, coeff] = expfit(x,y);
            expy = arrayfun(expFunc,x);
            expstring  = sprintf('Exponential ');
            [expr, exprmse] = functionerror(y,expy);
            printerror(expr,exprmse,expstring)
            fprintf('y =  c * exp(k*x) -> [c k] \n')
            fprintf(mat2str(coeff))
            strings{end+1} = expstring;
            if(length(configcell)==1&& nargin==3)
                results = coeff;
            end
            if(nargin == 4)                
                results = [results  arrayfun(expFunc,v)];
            end
            plot(x,expy,colors{mod(i,length(colors)-1)+1});
            hold on
        else
           error('Match not found. Unexpected error')
        end
        
    end   
    strings{end+1} = 'data';
    plot(x,y,'rx')
    hold on
    legend(char(strings),'location','northeastoutside')
%Fit TLS
elseif(nargin == 2 || strcmp(configuration,''))    
    
    plot(x,y,'ro')
    hold on
    legendStrings = {'data'};
    itr = 1;
    for i=1:length(displayPolyCof)
        
        [polyf,polycof] = polyreg(x,y,displayPolyCof(i));
        polyy = arrayfun(polyf,x);
        [polyyr2, polyyrmse] = functionerror(y,polyy);
        
        
        
        
        polystring = sprintf(' Polynomial : %d ',displayPolyCof(i));
        legendStrings{end+1} = polystring;
        %print error
        printerror(polyyr2,polyyrmse,polystring)
        % run function to print coefficients
        printcoefficients(polycof)
        plot(x,polyy,colors{mod(i,length(colors)-1)+1})
        hold on
        
        itr = i+1;
    end
    [TLSf, TLScof] = TLS(x,y);
    TLSy = arrayfun(TLSf,x);
    [TLSr2, TLSrmse] = functionerror(y,TLSy);
    plot(x,TLSy,colors{mod(itr,length(colors)-1)+1})
    legendStrings{end+1} = 'TLS';
    tlsstring = legendStrings{end};
    printerror(TLSr2,TLSrmse,tlsstring)
    printcoefficients(TLScof)
    
    itr = itr +1;
    legendStrings{end+1} = 'Spline';
    plotCubicSpline(x,y,1,colors{mod(itr,length(colors)-1)+1});
    
    legend(char(legendStrings),'location','northeastoutside');
    
end
end
