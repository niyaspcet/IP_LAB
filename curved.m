clc;
clear all;
close all;

%Reading the image
I=imread('C:\Users\Visakh\Desktop\DIP_Case_Study\Database\107_2.tif');
[m n]=size(I);
I=imresize(I,[1001,1001]);
k=1
for x=1
    for y=1:n
        x1=x-1;
        y1=y-501;
        y2=-(1/sqrt(5))*sqrt(y1);
        y3=uint8(y2+501);
        b(k)=I(x,y3);
        k=k+1;
    end
end