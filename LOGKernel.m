%Author: Zack Peppmeier

function LOGKernel = NLOG(size,sigma)
%This function returns the normalized Laplacian of Gaussian kernel
x = (-1*floor(size/2)):floor(size/2);
y = x';
LOGKernel = -(1/(pi*sigma^4)) .* (1 - (x.^2 +y.^2)/(2*sigma^2)) .* exp(-(x.^2+y.^2)/(2*sigma^2)) *sigma^2;
end

