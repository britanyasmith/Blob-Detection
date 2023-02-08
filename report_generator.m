%%Finished project
% Author: Joshua Larsen
% Finalized Project that saves finished images
clear
%{
%First image will be the butterfly
butterflyRGB = imread("Test Images\butterfly.jpg");
blobbyfly = detectBlobs(butterflyRGB,30,10);
imwrite(blobbyfly,"Test Images\butterfy_blob.jpg");
disp("The Butterfly");

%Then we will test Einstein
einsteinRGB = imread("Test Images\einstein.jpg");
blob_einstein = detectBlobs(einsteinRGB,30,10);
imwrite(blob_einstein,"Test Images\blob_einstein.jpg");
disp("Einstein");

%then we will test the fishes
fishesRGB = imread("Test Images\fishes.jpg");
blob_fish = detectBlobs(fishesRGB,30,10);
imwrite(blob_fish,"Test Images\blob_fishy.jpg");
disp("Fish");

%finally, we test the sunflowers, and be done with image processing until
%next semester
flowersRGB = imread("Test Images\sunflowers.jpg");
blob_flowers = detectBlobs(flowersRGB,30,10);
imwrite(blob_flowers,"Test Images\blob_flowers.jpg");
disp("Flowers");
%}
%Now for our own test images
lenna = imread("Test Images\LennaTheTester.png");
blob_lenna = detectBlobs(lenna,50,10);
%imwrite(blob_lenna,"Test Images\blob_lenna.jpg");
disp("Lenna");

mona = imread("Test Images\MonaLisa.jpg");
blob_mona = detectBlobs(mona,50,10);
%imwrite(blob_mona,"Test Images\blob_mona.jpg")
disp("Mona");

michel = imread("Test Images\Michelangelo.jpg");
blob_michel = detectBlobs(michel,50,10);
%imwrite(blob_michel,"Test Images\blob_michel.jpg");
disp("Michel");

pieta = imread("Test Images\pieta.jpg");
blob_pieta = detectBlobs(pieta,50,10);
%imwrite(blob_pieta,"Test Images\blob_pieta.jpg");
disp("Pieta");


