clc;
clear all;
close all;

%Reading the image
I=imread('107_2.tif');
[m n]=size(I);
s=zeros(m,n);
w=zeros(m,n);

contrast2=I;
contrast2(contrast2<=150)=contrast2(contrast2<=150)*.1;
contrast2(contrast2>=151)=3.5*(contrast2(contrast2>=151)-151)+10;

%Applying Gabor Filter at different angles from 0 to 179.5 degrees by the
%increment of 0.5
for i=0:0.5:179.5
       [m p] = imgaborfilt(contrast2,2,i);
       s=s+m;
       w=w+p;
end
s=s/361;
%Taking Averege
%Converting range of values to 0-255 range
mi=min(min(s));
ma=max(max(s));
s=s-mi;
k=255/ma;
s=s*k;
s=uint8(255-s);

contrast2=s;
contrast2(contrast2<=180)=contrast2(contrast2<=180)*.1;
contrast2(contrast2>=181)=4*(contrast2(contrast2>=181)-181)+10;

%Plot
figure
subplot(122);
imshow(uint8(contrast2));
title('Enhanced Image');

subplot(121);
imshow(uint8(I));
title('Original Image');