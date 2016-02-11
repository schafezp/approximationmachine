data = csvread('teams_post1999.csv',1,3);
wins = data(:,1);
runs = data(:,2);
Bat_Ave = data(:,5);
HR = data(:,8);
ERA = data(:,17);
wins(1,1)
runs(1,1)
Bat_Ave(1,1)
HR(1,1)
ERA(1,1)
main(runs,wins,'')
%main(x,y,'')