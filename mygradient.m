function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

xH = [1, -1];
yH = [1; -1];
dx = imfilter(I, xH, 'replicate' );
dy = imfilter(I, yH, 'replicate' );

mag = sqrt(dx.^2 + dy.^2);
ori = atand(dy./dx);
