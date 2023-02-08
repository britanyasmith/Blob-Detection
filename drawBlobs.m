%Author: Joshua Larsen
% The purpose of this function is to draw red circles of specified distance
% from a point given by the blob structure.
% For this function to run, it needs the list of blobs and the grayscale
% image

%blobs must be a list in form [x,y,k] where k is the scale that was chosen
%for the finding of the blob
%Testing code as proof of concept
%{
image = uint8(40*randn(200) + 100);
blob(1).x = 20;
blob(1).y = 30;
blob(1).k = 20;

blob(2).x = 50;
blob(2).y = 60;
blob(2).k = 40;

results = drawBlobsPractice(image,blob);
imshow(results)
%}

function highlights = drawBlobs(image,blobs)
%This function will take each individual blob, and attempt to draw a red
%circle of radius = sqrt(2k). This will be done by creating the "red" layer
%and changing the values of pixels a specified distance from the center of
%the blob to their maximum value. The final image can then be used as the
%red layer in an RGB image.
[y_max, x_max] = size(image);
paddedArray = zeros(y_max+200,x_max+200);
paddedArray(101:(y_max+100),101:(x_max+100)) = image;
image = paddedArray;
bwImage = image;
redImage = image;
greenImage = image;
blueImage = image;

%Always a good practice to save the image for later.

numOfBlobs = numel(blobs);
for i = 1:numOfBlobs
    radius = round(sqrt(2 * blobs(i).k));
    %the center of each blob is initialized as x_i and y_i.
    x_i = blobs(i).x + 100;
    y_i = blobs(i).y + 100;
    %To map out our circle, we can vary a theta to a high accuracy and
    %and calculate all the pixels that come up in that given theta
    theta = linspace(0, 2*pi, round(4 * pi * radius));
    x = radius * cos(theta) + x_i;
    y = radius * sin(theta) + y_i;
    %Now that we have all the border pixels determined, we loop through all
    %of them setting them equal to one.
    for j = 1:numel(x)
        row = round(y(j));
        col = round(x(j));
        redImage(row, col) = 255;
        blueImage(row,col) = 0;
        greenImage(row,col) = 0;
    end
    
    
end
%Then, we remove the padding
redImage = redImage(101:(100+y_max),101:(100+x_max));
blueImage = blueImage(101:(100+y_max),101:(100+x_max));
greenImage = greenImage(101:(100+y_max),101:(100+x_max));

%finally, we combined the new circled image with the original bw image to
%give the red circles.
highlights = cat(3,redImage,blueImage,greenImage);
highlights = uint8(highlights);

end