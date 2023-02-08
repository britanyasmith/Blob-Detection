%%Author: Joshua Larsen
% Blob List Generation
% Takes 2D Array which has non extrema locations as 0 and extrema locations
% as 1. This will search through for all elements within the array and
% record their location.
% This location will be stored on the array that is given to the function,
% and it is appended
%k is the scale at which we searched for this index



function appendedList = listBlobs(truthArray, list, k)
%We can record the [M,N] coordinates of each element in the array by using
%the find command. This outputs the [M,N] location of all elements that are
%not 0, which is fed into the function in the form of the Truth Array
%variable.
[extremaM, extremaN] = find(truthArray);
%Now these new values must be appended to the first array.
%We will do this via for loop. We will determine the number of array
%elements to be added, and add each one through a loop.
newBlobs = numel(extremaM);
for i = 1:newBlobs
    %I need to stop using x and y when referring to images - I believe N is
    %equivalent to X, and M is equivalent to Y effectively. This shouldn't
    %change anything in the code.
    %BUGFIX - instead of using end + 1, use lastLoc + 1, as end will end up
    %creating diagonally arrays that are 3 times the expected number
    lastLoc = numel(list);
    list(lastLoc+1).x = extremaN(i);
    list(lastLoc+1).y = extremaM(i);
    list(lastLoc+1).k = k;
    list(lastLoc+1).magnitude = truthArray(extremaM(i),extremaN(i));
end
appendedList = list;


end
