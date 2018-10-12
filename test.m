% Image Acquisition code for the 3D finger scanner
% First written: November 2017  
% Last modified: June 2018
%--------------------------------------------------------------------------
% Written by:
% Aymeric Peirs
% Quentin Renault
% Federico Sanna
% Mitchell Teal
% Diana Toderita
% Aaron Wright


tic    % Starts the timer of the program
clc; close all; clear all;
%--------------------------------------------------------------------------
% Acquiring images with MatLab through the hub

webcamlist        % Displays the webcams connected to the computer
cam1 = webcam(1); % Assigns the cameras
cam2 = webcam(2);

rect = [240 150 400 200];
% [xmin ymin width height] 
% Size and position of the crop rectangle in spatial coordinates 

img1 = snapshot(cam1);  % Take a picture with camera1
BW1 = rgb2gray(img1); 
BW1 = imcrop(img1,rect);
BW1 = imrotate(BW1,-90);
imwrite(BW1, 'img1.jpg');  % Saves the picture as 'img1' in the folder

img2 = snapshot(cam2);  % Take a picture with camera2
BW2 = rgb2gray(img2); 
BW2 = imcrop(img2,rect);
BW2 = imrotate(BW2,-90);
imwrite(BW2, 'img2.jpg');  % Saves the picture as 'img2' in the folder

clear all; 
cam3 = webcam(3);
cam4 = webcam(4);
rect = [320 100 460 280];

img3 = snapshot(cam3);  % Take a picture with camera3
BW3 = rgb2gray(img3); 
BW3 = imcrop(img3,rect);
BW3 = imrotate(BW3,-90);
imwrite(BW3, 'img3.jpg');  % Saves the picture as 'img3' in the folder

rect = [240 100 400 280];
img4 = snapshot(cam4);  % Take a picture with camera4
BW4 = rgb2gray(img4); 
BW4 = imcrop(img4,rect);
BW4 = imrotate(BW4,-90);
imwrite(BW4, 'img4.jpg');  % Saves the picture as 'img4' in the folder

clear all; 
cam5 = webcam(5);
cam6 = webcam(6);
rect = [240 100 400 280];

img5 = snapshot(cam5);  % Take a picture with camera5
BW5 = rgb2gray(img5); 
BW5 = imcrop(img5,rect);
BW5 = imrotate(BW5,-90);
imwrite(BW5, 'img5.jpg');  % Saves the picture as 'img5' in the folder

img6 = snapshot(cam6);  % Take a picture with camera6
BW6 = rgb2gray(img6); 
BW6 = imcrop(img6,rect);
BW6 = imrotate(BW6,-90);
imwrite(BW6, 'img6.jpg');  % Saves the picture as 'img6' in the folder

clear all; 
cam7 = webcam(7);
cam8 = webcam(8);
rect = [240 100 400 280];

img7 = snapshot(cam7);  % Take a picture with camera7
BW7 = rgb2gray(img7); 
BW7 = imcrop(img7,rect);
BW7 = imrotate(BW7,-90);
imwrite(BW7, 'img7.jpg');  % Saves the picture as 'img7' in the folder

img8 = snapshot(cam8);  % Take a picture with camera8
BW8 = rgb2gray(img8); 
BW8 = imcrop(img8,rect);
BW8 = imrotate(BW8,-90);
imwrite(BW8, 'img8.jpg');  % Saves the picture as 'img8' in the folder

toc    % Stops the timer and displays how long the program has run for

