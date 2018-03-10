clc;
clear all;
close all;

%Read the original RGB input image
          image=imread('ww.png');
      %convert it to gray scale
      image_gray=image;
         image_gray=rgb2gray(image);
      %resize the image to 160x160 pixels
          image_resize=imresize(image_gray, [160 160]);
      %apply im2double
          image_resize=im2double(image_resize);
      %show the image
          figure(1);
          imshow(image_resize);
          title('Input Image');
          %Gabor filter size 7x7 and orientation 90 degree
      %declare the variables
         % gamma=1; %aspect ratio
          psi=0; %phase
          theta=90; %orientation
          bw=1; %bandwidth or effective width
          lambda=3.5; % wavelength
          pi=180;
          for x=1:160
              for y=1:160
          x_theta=image_resize(x,y)*cos(theta)+image_resize(x,y)*sin(theta);
          y_theta=-image_resize(x,y)*sin(theta)+image_resize(x,y)*cos(theta);
          gb(x,y)= exp(-.5*(x_theta.^2/bw^2+ y_theta.^2/bw^2))*cos(2*pi/lambda*x_theta+psi);
              end
          end
          gb=conv2(image_resize,gb);
          figure(2);
          imshow(gb);
          title('filtered image');