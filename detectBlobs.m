%%Finished Blob Detector
%Author: Zack Peppmeier

%Program description
% Program will detect blobs in a color image
% This is done via DoG detection

%Program Outline
% The function will require some image, and a minimum and maximum scale to
% operate at
% First we declare a list of blob locations - each blob will be radius and
% location within the image
% Within a for loop, we then perform the following tasks
%   Convolve the grayscale image with a DoG kernel
%   We then square all elements of the array
%   Next, we create an extrema finder which will find all minimums and
%   maximums of the function
%   We then pass this into the blob list that was created earlier
%   We then iterate the loop
% Once the loop has terminated, we pass the blob list and bw image into the
% drawBlobs function, which will draw all the blobs that were identified on
% the original bw image

function detectedBlobs = detectBlobs(rgbImage, max_scale, min_scale)
%It is important to predefine our runningBlobList as an array so that we
%may put our elements into it.
runningBlobList = [];
bwImage = rgb2gray(rgbImage);
for t = min_scale:max_scale
    %IMPORTANT - t is kernel size; I used this because that is the notation
    %the wikipedia article uses. Kernel will be of form t*t number of
    %pixels
    %First, as discussed previously, we convolve with a Laplacian of
    %Gaussian function
    %The ConvolveLOG will handle the kernel generation
    filteredImage = ConvolveLOG(rgbImage,2*t,sqrt(2*t));
    %We need to ensure that we are looking at magnitudes, and the easiest
    %way is to just square it.
    filteredImage = filteredImage .* filteredImage;
    %from here we have to detect all the extrema and add their locations to
    %the blob list
    locationTable = localExtrema(filteredImage,2*t);
    %t is also k in this case, as k was meant to be the radius of the blob
    runningBlobList = listBlobs(locationTable,runningBlobList,t);
end
%Now, we have a list of all blobs, we must perform non-max-suppression
runningBlobList = non_max_supression(runningBlobList);

detectedBlobs = drawBlobs(bwImage,runningBlobList);


end
