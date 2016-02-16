%This is a workaround to the pathing problem. This will temporarily
%change the directory one level up, then restore it at the end.
currentpath = cd('..');
parentpath = pwd()

%Load data from our csv
data=csvread('infantMortality1907-2008.csv',2,0)
year=data(:,1)
dead=data(:,2)

%Label graph with information pertaining to our dataset.

title('Infanty mortality vs year')
xlabel('Years')
ylabel('Infant deaths')

%Call with no parameters to get default plot

datfit(year,dead,'')

%Call with parameters to get a specific plot.

%datfit(year,dead,'poly1,poly2,exp')

%Call with optional vector to be evaluated

yearsToEvalutesModels =  [1940,1950,1960];
%datfit(year,dead,'poly1,poly2,exp',yearsToEvalutesModels)

%restore previous path
cd(currentpath);
