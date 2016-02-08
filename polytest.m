%data = csvread('infantMortality1907-2008.csv',1,0)
%x = data(:,1);
%y = data(:,2);
x = linspace(1,1e5,1e5)
y = x.^3
[polyf,polycof] = fasterpolyreg(x,y,2);
polycof
py = arrayfun(polyf,x);
p = polyfit(x,y,1)
plot(x,y,'x', x,py,'r')
