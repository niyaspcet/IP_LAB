clc;
clear all;
close all;

%Reading the image
I=imread('C:\Users\Visakh\Desktop\DIP_Case_Study\Database\107_2.tif');
[m n]=size(I);

%Applying Gabor Filter at different angles from 0 to 179.5 degrees by the
%increment of 0.5
s=zeros(m,n);
for i=0:0.5:179.5
       [m p] = imgaborfilt(I,2,i);
       s=s+m;
end
s=s/361; %Taking Averege
%Converting range of values to 0-255 range
min=min(min(s));
max=max(max(s));
s=s-min;
k=255/max;
s=s*k;
s=uint8(255-s);
%avg=200;

%s(s<avg)=0;
%s(s>=avg)=255;

%Plot
figure
subplot(122);
imshow(uint8(s));
title('Enhanced Image');

subplot(121);
imshow(uint8(I));
title('Original Image');
