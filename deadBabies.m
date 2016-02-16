data=csvread('infantMortality1907-2008.csv',2,0)
year=data(:,1)
dead=data(:,2)

datfit(year,dead,'')
title('Infanty mortality vs year')
xlabel('Years')
ylabel('Infant deaths')
% $$$ datfit(year,dead,'linear,spline')J
