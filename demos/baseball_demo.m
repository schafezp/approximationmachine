currentpath = cd('..');
parentpath = pwd()


close all
data = csvread('teams_post1999.csv',1,3);
%Grab columns of data to use on our function
wins = data(:,1);
runs = data(:,2);
hits = data(:,4);
Bat_Ave = data(:,5);
HR = data(:,8);
ERA = data(:,17);
%Call the main

%Call with no parameters to get default plot
datfit(hits,runs,'')

 
title('Baseball data')
xlabel('Hits made')
ylabel('Runs made')

cd(currentpath);
