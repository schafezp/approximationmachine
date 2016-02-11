data=csvread('infantMortality1907-2008.csv',2,1)
dead=data(:,2)
year=data(:,1)
main(year,dead,'')