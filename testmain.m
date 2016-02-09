data = csvread('infantMortality1907-2008.csv',1,0)
x = data(:,1);
y = data(:,2);
main(x,y,'')
