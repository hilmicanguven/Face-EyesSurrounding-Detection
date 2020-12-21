clear; clc; close all;
%bir Image klasörü altında- farklı adlarda duygu dosyalarını, yeni bir
%image klasörü açarak onun altına kaydediyr
%-Images
%   --sad
%   --angry...
%edittedImages
%   --sad
%   --angry..


nameOfImageFolder1 = "images/";      %-----head directory of our image set
nameOfImageFolder= uigetdir('C:\Users\hilmi\MATLAB\Projects\tez');
nameOfImageFolder = nameOfImageFolder + "/" ;
%nameOfImageFolder = uigetfile('*','Select the Load path');

pathToSaved = "edittedImages/";           %-----new head directory which converted images to saved

faceDetector = vision.CascadeObjectDetector;    %create detector object

folds = dir(nameOfImageFolder + "*.");      %list of all emotion files (sad,angry,...) for its extension 

if (exist(pathToSaved) == 0)
   mkdir (pathToSaved);
end

%mkdir(pathToSaved);                 %create new directory if it doesn't exist

for j=3:length(folds)               %images klasörü altındaki her bir dosyayı gezen for loop
    fold = folds(j).name;           %each iteration, different fold will be held
    list = dir(nameOfImageFolder + "/"+ fold + "/" +"*.jpeg");      %make list all images in that emotion folder
    if (exist(pathToSaved + fold) == 0)
        mkdir (pathToSaved + fold);
    end
    %mkdir(pathToSaved + fold);     %create new emotion file under edittedImages.for example (./edittedImages/sad ) 
          
    for i=1 : length(list)          %until each image is converted gray
       	 
        name = nameOfImageFolder + fold + "/"+list(i).name;     %every iteration, one image will be used and it is controlled by for looop variable i
        %----differen operations will be done here. two of them is given---%
        img = imread(name);
        %img = rgb2gray(img);           %convert grayscale 
        %img2 = imresize(img,[277 277]);        %resize the image
        bboxes = faceDetector(img);         %using detector object, find bounding boxes of detected faces
        %imwrite(img, (pathToSaved+fold+ "/"+list(i).name));     %save image to the file
        %figure, imshow(img);           %optional, iy you want to images, use imshow
        [m, n] = size(bboxes);          %size of objecct   
        for h=1:m
            facePosition = bboxes(h,:);     %find face position
            croppedFace = imcrop(img, facePosition);   %crop face from original image

            % save the processed images into subfolder of croppedImages folder
            imwrite(croppedFace ,(pathToSaved+fold+ "/"+list(i).name));         %save cropped=face to the new location

            % uncomment here for showing all cropped faces.
            %         figure(i)
            %         imshow(croppedFace)
        end

    end
end