function convolved = ConvolveLOG(image,kernel_size,sigma)
%Author: Joshua Larsen,
%This function generates a Laplacian of Guassian kernel, and convolves it
%with an image given a specific sigma value.
image = rgb2gray(image);
imageDoub = double(image);
LOGKer = LOGKernel(kernel_size,sigma);
convolved = Convolution2(imageDoub,LOGKer,2);

end