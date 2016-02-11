function [] = plotCubicSpline(x,y,jump,color)
subx = x(1:jump:length(x));
suby = y(1:jump:length(y));
intx = linspace(min(subx),max(subx),2*(max(subx)-min(subx)));
cubicy3 = cubicSpline(subx,suby,intx);
plot(intx,cubicy3,color)
% $$$ legendStr = sprintf('jump distance: %d',jump)
% $$$ legappend(legendStr)
