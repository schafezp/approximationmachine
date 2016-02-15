function [] = plotCubicSpline(x,y,jump,color)
subx = x(1:jump:length(x));
suby = y(1:jump:length(y));
inner_points = 10;
intx = linspace(min(subx),max(subx),inner_points*(max(subx)-min(subx)));
cubicy3 = cubicSpline(subx,suby,intx);
plot(intx,cubicy3,color);
% $$$ legendStr = sprintf('jump distance: %d',jump)
% $$$ legappend(legendStr)
