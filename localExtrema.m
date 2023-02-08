%Author: Joshua Larsen
% This function will return a logical array where any local extrema are
% identified. It requires the function to be called with a grayscale image
% and a kernel size for locating extrema. The kernel size is the minimum
% distance between extrema points.

% The returned value will be a binary image that contains value "1" where a
% local extrema has been identified.

function newImage = localExtrema(array,kernelSize)
%First, we want to create a new logical array that will be populated by
%binary values representing a local maximum or minimum;
[m, n] = size(array);
newImage = zeros([m,n]);

%Then, we want to determine the "starting" location 
startM = floor(kernelSize/2);
startN = startM;
confidenceLevel = 1e-3;

%This function operates on a pixel by pixel basis, rapidly determining if
%any given pixel is the largest as determined by the kernel size.
for i = 1:m
    for j = 1:n
        %We will create a subarray around the given pixel, and determine if
        %this pixel is the largest or smallest out of its subarray
        %The first step of this process it to determine the sub arrays
        %coordinates
        %Our sub array has minimum coordinates of 1,1 and a maximum of m,n
        i_min = max(i-startM,1);    %this prevents a negative coordinate
        i_max = min(i+startM,m);    %this prevents our subarray from exceeding the original bounds of the image
        j_min = max(j-startN,1);
        j_max = min(j+startM,n);
        %First, we find the maximum values within our given kernel size.
        %The removed parts of the if statement removed extrema that were
        %too close together; this is actually part of the
        %non-max-suppression, and shouldn't have been done here. Sorry!
        if array(i,j) >= max(max(array(i_min:i_max,j_min:j_max)))
            newImage(i,j) = 1;
        end
        %Then, pixel by pixel, we look for local minima
        
        if array(i,j) <= min(min(array(i_min:i_max,j_min:j_max)))
            newImage(i,j) = -1;
        end
        
    end
end




end