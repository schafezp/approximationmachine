function [] =  printerror(r2,rmse,dispstring)
        fprintf('----------------------\n')
        fprintf([dispstring '\n'] )
        fprintf('R squared Coefficient: %.9f \n',r2);
        fprintf('Root mean square: %f \n',rmse);
end
