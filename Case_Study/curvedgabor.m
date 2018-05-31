clc;
clear all;
close all;


%Reading the image
I=imread('103_3.jpg');
I=rgb2gray(I);
[m,n]=size(I);

%Contrast Stretching
contrast2=I;
contrast2(contrast2<=100)=contrast2(contrast2<=100)*.1;
contrast2(contrast2>=101)=2*(contrast2(contrast2>=101)-101)+10;

%Cunstructing Curved Regions
b=255*ones(m,n);

    for y=1:n
        y1=y-(n/2);
       x2=(500/(m*n))*(y1^2);
        x3=round(x2+1);
        for x=1:m
            if((x3+x-1)<=m)
                c(x)=x3+x-1;
                b(x,y)=I(x3+x-1,y);
            end
        end
    end
    
 %Applying gabor filter to original image at 90 degree
[m1,n1]=imgaborfilt(I,2,90);     
mi=min(min(m1));
ma=max(max(m1));
m1=m1-mi;
k=255/ma;
m1=m1*k;
m1=255-m1;

%Applying Gabor filter to curved image at 90 degree
[m2,n2]=imgaborfilt(b,2,90);  
m2=1000*m2;
mi=min(min(m2));
ma=max(max(m2));
m2=m2-mi;
k=255/ma;
m2=m2*k;
m2=255-m2;

%Making Curved image in to straight image
  d=242*ones(m,n);   
     for y=1:n
        y1=y-(n/2);
       x2=(500/(m*n))*(y1^2);
        x3=round(x2+1);
        for x=1:m
            if((x3+x-1)<=m)
                c(x)=x3+x-1;
                d(x3+x-1,y)=m2(x,y);
            end
        end
     end

%Contrast Stretching
contrast1=d;
contrast1(contrast1<=150)=contrast1(contrast1<=150)*.1;
contrast1(contrast1>=151)=2.7*(contrast1(contrast1>=151)-151)+10;

contrast2=m1;
contrast2(contrast2<=150)=contrast2(contrast2<=150)*.1;
contrast2(contrast2>=151)=2.7*(contrast2(contrast2>=151)-151)+10;
%Display Image
figure
subplot(122);
imshow(uint8(contrast1));
title('Curved Gabor Filter at 90 degree');

subplot(121);
imshow(uint8(contrast2));
title('Straight Gabor Filter at 90 degree');