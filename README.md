# Blob Detection
<p align="center">
  <img width="800" height="400" src="/ButterflyExample.png" />
</p>

## Introduction
Blob detection is a common method used in computer vision to detect regions of a digital
image that contain different properties, such as brightness or color, compared to the region’s
surroundings. In its simplest form, a blob is a region of an image in which properties are
consistent. The most common method for blob detection is convolution and thus our algorithm
begins with a convolution which will be described at a later point.
There are two different common classes of blob detectors, differential methods and
methods based on local extrema. This project focuses on the second method based on local
extrema and is based on finding the local maxima and minima of the function.
Blob detectors provide information about image regions not already provided by edge
detection. When looking at the magnitude of the Laplacian signal response, an edge is shown
by a ripple while a blob is represented by the superposition of two ripples, further expanding
from edge detection. These regions of interest or blobs are also used to detect key points in an
image and can be used with the application of object recognition.
Convolving an image with a “blob filter” at multiple scales provides a resulting scale
space where you are able to look at the different scales and extrema of the filter response.
When computing blob detection, it is important to find the characteristic scale of the blob by
convolving it with Laplacians at several different scales and capturing the maximum response
then normalizing the scale.

## Overall Algorithm Approach
The main algorithm functions rather simply.
First, we convert the image to grayscale, making it a simple 2D matrix. Then, we
create a loop with the minimum set to a minimum scale that was predefined and a
maximum scale that was also predefined. At each scale, we convolve the 2D image with a
Laplacian of Gaussian kernel that has been tailored to fit the scale we have chosen. From
here, we identify local minimums and maximums of the array. These local extrema are then
recorded in an array containing their locations and the scales at which they were found.
This array then gets passed into a non-maximum suppression function that will remove
duplicates and ensure that each blob only gets counted once across all scales. Finally, the
image is passed into a final function that converts back to a color image where red circles
are drawn with radius based on the scale that each blob was detected at.


## How to Run 
In order to test the code, run the function report_generator.m. This acts as the main function. 

detectBlob.m -> Detects the Blob and Outputs the final image with Blob 
localExtrema -> Finds the extrema 
non_max_suppression.m -> Removes all repeating locations and overlapping blobs 
listBlobs.m -> Generates list of all blobs 
LaplacianofGaussian -> Generates Laplacian 
drawBlobs.m -> Draws the blobs 
ConvolvLOG.m and Convolusion2.m -> Performs convolution

Test Images -> Sample Test images 
Output Images -> Outputs to sample images 
