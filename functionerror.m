function [r2, rmse] = functionerror(y,f)
%Here y is the actual data and f is the model fit.
y = reshape(y,[],1);
f = reshape(f,[],1);


[r2, rmse] = rsquare(y,f)
end
