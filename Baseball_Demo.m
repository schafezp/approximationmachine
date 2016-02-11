data = csvread('teams_post1999.csv',1,3);
%Grab columns of data to use on our function
wins = data(:,1);
runs = data(:,2);
hits = data(:,4);
Bat_Ave = data(:,5);
HR = data(:,8);
ERA = data(:,17);
%Call the main
main(HR,wins,'')
%main(x,y,'')