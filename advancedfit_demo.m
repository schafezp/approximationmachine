
x = linspace(-2,2,100);
y = 1./(1+5*x.^2) ;
subplot(2,1,1)
datfit(x,y,'spline,poly7,poly10')
title('Difficult Function: y = 1/(1+5*x^2)')
subplot(2,1,2)
datfit(x,y,'spline,poly2,poly4,poly6')
title('Difficult Function: y = 1/(1+5*x^2)')

