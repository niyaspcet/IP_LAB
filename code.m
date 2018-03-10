clc;
clear all;
close all;

%define the five parameters
theta=0; %either 0 or pi/4 or pi/2 or 3pi/4
lambda=7;
gamma=1;
sigma=2;
psi=0;

sigma_x = sigma;
sigma_y = sigma/gamma;

nstds = 5;
xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
xmax = ceil(max(1,xmax));
ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
ymax = ceil(max(1,ymax));
xmin = -xmax; ymin = -ymax;
[x,y] = meshgrid(xmin:xmax,ymin:ymax);

x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gb= exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);
figure(2);
imshow(gb);
title('theta=...');
%imagesc(gb);
%colormap(gray);
%title('theta=...');


I=imread('ww.png');
image_resize=imresize(I, [160,160]);
image_gray=rgb2gray(image_resize);
image_double=im2double(image_gray);
figure(1);
imshow(image_double);

figure(3);
filtered = conv2(image_double,gb);
imagesc(filtered);
colormap(gray);
title('theta=....');
