%{
Non-Max Suppression Function 
Author: Britanya Wright

Input: Output from previous function: struct blob[X, Y, K] of size 1xi with 3 fields. 
       Where X and Y are coordinates and K is the size of the blob to be drawn 

Purpose: This function's main purpose is to remove all instances of K values less
         than the maximum value of K at location X and Y. In addition, this
         function removes all neighboring blobs that overal by k/2. 

Output: The function outputs struct blobF[X, Y, K] to be used to draw the circle 
        on the final image 

Testing: blobF = nonMaxSup(blobList);
%}

function blobF = nonMaxSup(blob)
    
    %-------------------Getting rid of duplicates--------------------------
    
    %Turning struct to an array to make it easier for manipulation
    blob_Arr = [[blob(:).x]; [blob(:).y]; [blob(:).k]; blob(:).magnitude];
    blob_final = blob_Arr; 

    % Loop to iterate through each column of the blob array
    for i = 1:length(blob_final)
        %Find the Xi and Yi values that are the same 
        %To do this we: Find the index column locations of all duplicate columns
        col = blob_Arr(1:2,i); 
        
        idx = find(~any(bsxfun(@minus, blob_final(1:2,:),col)));

        %Take the index locations of Xi and Yi being the same and use it to
        %retreive the k values 
        %Create array with all k values at location Xi and Yi
        k_val = zeros(1,length(idx)); 

        %Take the indicies and check for the highest value of K
        for t = 1:length(idx)
            k_val(t) = blob_final(3, idx(t)); 
        end
        
        %Find the maximum K value and index of all K values at the same
        %X and Y location
        %maxK is not used after this point 
        [maxK, indexMaxK] = max(k_val);

        % Remove max index from the list of indexes so as to not remove it from the blob_arr 
        % What should be left are the indexes to remove from the overall blob_arr
        idx(indexMaxK) = []; 

        % Remove indexes with lesser k values from blob_final  
        for r = length(idx):-1:1
            blob_final(:, idx(r)) = []; 
        end     
    end
    
    %-------------------Removing neighboring blobs------------------------
    %All neighboring blobs with k value less than or equal to original k/2
    %is removed from the blob list
    
    %Obtain size of blob array, row is never used beyond this point
    [row, i] = size(blob_final); 
    
    %Iterate through each blob to check for neighbors 
    % i starts at the last column in the blob array
    while i >= 1
        %Extract all xi,yi,ki from array
        xi = blob_final(1,i); 
        yi = blob_final(2,i); 
        ki = blob_final(3,i);
        %In order to prevent dark and light blobs from being merged, we
        %keep track of whether the extrema was from a minimum or maximum
        magi = blob_final(4,i);
        
        %Get the upper and lower range of the blobs we are searching for 
        m = round(ki/2); 
        Xlower = xi - m; 
        Ylower = yi - m;
        Xupper = xi + m; 
        Yupper = yi + m; 
        
        %Iterate through the neighboring x and y values to see which ones
        %overlap
        %Bug occurs here. When tested with a blob list, certain blobs
        %would delete themeselves. -Josh
        for x = Xlower:Xupper
            for y = Ylower:Yupper
                %Grab index locations of possible overlapping blobs
                col = [x; y];
                idx = find(~any(bsxfun(@minus, blob_final(1:2,:),col)));
                
                %If idx is not empty then proceed, else ignore 
                if ~isempty(idx)
                    %Take the indicies and check for an overlap in blob 
                    for t = 1:length(idx)
                        k_val = blob_final(3, idx(t)); %Get kvalue to compare
                        m_val = blob_final(4, idx(t)); %Get mag to compare
                        p1 = m; %original k value at center location 
                        p2 = round(k_val/2); %new k value to be compared
                        
                        %If the value is equal to or less than the original
                        %k value, get rid of it
                        %Adjust this location so that blobs aren't self
                        %deleting
                        if p1 >= p2 && (xi ~= x && yi ~= y && ki ~= k_val) &&  m_val == magi
                            blob_final(:, idx) = []; 
                            i = i - 1; %After removing an index, we need to decrease the counter
                        end
                    end
                end 
            end 
        end
        
        i = i - 1;
        
    end 
       
    %-------------------Turning array back to Struct for other functions------------------------
    %Preallocate the size of the struct
    blobF = struct('x', cell(1,length(blob_final)),'y', cell(1,length(blob_final)),'k', cell(1,length(blob_final)));
    for i = 1:length(blob_final)
        %Convert blob_final from an array to a struct 
        blobF(i) = struct('x', blob_final(1, i), 'y', blob_final(2, i), 'k', blob_final(3, i)); 
    end
    
end

