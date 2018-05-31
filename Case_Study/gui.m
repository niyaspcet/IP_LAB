
function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 23-Mar-2018 10:11:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% Determine the selected data set. 
str = get(hObject, 'String'); 
val = get(hObject,'Value'); % Set current data to the selected data set. 
switch str{val}; 
case 'Gabor Filter' % User selects Gabor Filter.  
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

case 'Curved Gabor Filter' % User selects membrane.   
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
end % Save the handles 
%structure. guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
