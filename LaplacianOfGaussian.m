%Author: Joshua Larsen
% the goal of this function is to quickly create a laplacian of gaussian 
% kernel that matches some given size
% The use gives an edge length and a sigma value, and the function returns
% the proper array

%First, we determine the size of our gaussian filter, which will be x by y
function LOGKernel = NLOG(size,sigma)
%This function returns the normalized Laplacian of Gaussian kernel
x = (-1*floor(size/2)):floor(size/2);
y = x';
LOGKernel = -(1/(pi*sigma^4)) .* (1 - (x.^2 +y.^2)/(2*sigma^2)) .* exp(-(x.^2+y.^2)/(2*sigma^2)) *sigma^2;
%surf(x,y,LOGKernel)
end

