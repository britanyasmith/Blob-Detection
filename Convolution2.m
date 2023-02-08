function g = Convolution2(f,w,pad)

%   Function inputs:
    % f: image; rgb or grayscale
    % w: 2-D kernel
    % pad: 0 = Clip/zero-padding
    %      1 = Wrap around
    %      2 = Copy edge
    %      3 = Relect across edge

% f; Read in image
    %img = imread(f);
    img = f;
    dimensions_img = size(img);                               
    
% w; 2-D kernel
    kernel = w;
    dimensions_kernel = size(kernel);
     
% pad; Padding Options: 
% 0 = Clip/zero-padding
% 1 = Wrap around
% 2 = Copy edge
% 3 = Relect across edge

    % Initial Padding Step; Calculate Pad Dimensions
    
    % Round Pad dimensions; No effect when kernel dimension is odd, rounds
    % up to nearest positive interger when kernel dimension is even
    Pad_w = round((dimensions_kernel(2) - 1) / 2);
    Pad_h =round((dimensions_kernel(1) - 1) / 2);
    
    PaddedImg = zeros(dimensions_img(1) + 2*Pad_h, dimensions_img(2) + 2*Pad_w);
    PaddedImg = uint8(PaddedImg);
    dimensions_Paddedimg = size(PaddedImg);

% Clip/zero-padding; 0 Done
if pad == 0        
    for i = 1:dimensions_img(1)
        for j = 1:dimensions_img(2)
            PaddedImg(i+Pad_h, j+Pad_w) = img(i,j);
        end
    end
    %figure, imshow(PaddedImg), title("Padded Image: Zero/Clip Padding")

% Wrap around; 1 Done
elseif pad == 1          
    % For original image
    for i = 1:dimensions_img(1) 
        for j = 1:dimensions_img(2) 
            PaddedImg(i+Pad_h, j+Pad_w) = img(i,j);
        end
    end 
  
    % For bottom
    for i = 1:Pad_h
        for j = 1:dimensions_img(2)
            PaddedImg(i+dimensions_img(1)+Pad_h,j+Pad_w) = img(i,j);
        end
    end
    
    % For top
    for i = 1:Pad_h
        for j = 1:dimensions_img(2)
            PaddedImg(i,j+Pad_w) = img(i+dimensions_img(1)-Pad_h,j);
        end
    end
    
    % For right side
    for i = 1:dimensions_img(1)
        for j = 1:Pad_w
            PaddedImg(i+Pad_h,j+dimensions_img(2)+Pad_w) = img(i,j);
        end
    end
    
    % For left side
    for i = 1:dimensions_img(1)
        for j = 1:Pad_w
            PaddedImg(i+Pad_h,j) = img(i,j+dimensions_img(2)-Pad_w);
        end
    end
    
    % For top left corner
    for i = 1:Pad_h
        for j= 1:Pad_w
            PaddedImg(i,j) = img(i+dimensions_img(1)-Pad_h,j+dimensions_img(2)-Pad_w);
        end
    end
    
    % For bottom right corner
    for i = 1:Pad_h
        for j= 1:Pad_w
            PaddedImg(i+dimensions_img(1)+Pad_h,j+dimensions_img(2)+Pad_w) = img(i,j);
        end
    end
    
    % For top right corner
    for i = 1:Pad_h
        for j = 1:Pad_w
            PaddedImg(i,j+dimensions_img(2)+Pad_w) = img(i+dimensions_img(1)-Pad_h,j);
        end
    end
    
    % For bottom left corner
    for i = 1:Pad_h
        for j = 1:Pad_w
            PaddedImg(i+dimensions_img(1)+Pad_h,j) = img(i,j+dimensions_img(2)-Pad_w);
        end
    end
    %figure, imshow(PaddedImg), title("Padded Image: Wrap Around Padding")
        
% Copy edge; 2 
elseif pad == 2      
    % For original image
    for i = 1:dimensions_img(1) 
        for j = 1:dimensions_img(2) 
            PaddedImg(i+Pad_h, j+Pad_w) = img(i,j);
        end
    end 
        
    % For top
    for i = 1:Pad_h
        for j = 1:dimensions_img(2)
            PaddedImg(i,j+Pad_w) = img(1,j);
        end
    end
    
    % For bottom
    for i = 1:Pad_h
        for j = 1:dimensions_img(2)
            PaddedImg(i+dimensions_img(1)+Pad_h,j+Pad_w) = img(dimensions_img(1),j);
        end
    end
        
    % For left side 
    for i = 1:dimensions_Paddedimg(1)
        for j = 1:Pad_w
            PaddedImg(i,j) = PaddedImg(i,Pad_w+1);
        end
    end 
    
    % For right side
    for i = 1:dimensions_Paddedimg(1)
        for j = 1:Pad_w
            PaddedImg(i,j+dimensions_Paddedimg(2)-Pad_w) = PaddedImg(i,dimensions_Paddedimg(2)-Pad_w);
        end
    end
    %figure, imshow(PaddedImg), title("Padded Image: Copy Edge Padding")
       
% Relect across edge; 3 
elseif pad == 3 
    % For original image
    for i = 1:dimensions_img(1) 
        for j = 1:dimensions_img(2) 
            PaddedImg(i+Pad_h, j+Pad_w) = img(i,j);
        end
    end     
    %figure, imshow(PaddedImg) 
        
   % For top
    A = img(1:Pad_h,1:dimensions_img(2));
    B = flip(A);
    PaddedImg(1:Pad_h,Pad_w+1:Pad_w+dimensions_img(2)) = B;
    %figure, imshow(PaddedImg)
    
    % For bottom
    A = img(dimensions_img(1)+1-Pad_h:dimensions_img(1),1:dimensions_img(2));
    B = flip(A);
    PaddedImg(dimensions_img(1)+Pad_h+1:dimensions_Paddedimg(1),Pad_w+1:Pad_w+dimensions_img(2)) = B;
    %figure, imshow(PaddedImg)
    
    % For left side
    A = PaddedImg(1:dimensions_Paddedimg(1),Pad_w+1:2*Pad_w);
    B = flip(A,2);
    PaddedImg(1:dimensions_Paddedimg(1),1:Pad_w) = B;
    %figure, imshow(PaddedImg)
    
    % For right side
    A = PaddedImg(1:dimensions_Paddedimg(1), dimensions_Paddedimg(2)-2*Pad_w+1:dimensions_Paddedimg(2)-Pad_w);
    B = flip(A,2);
    PaddedImg(1:dimensions_Paddedimg(1),dimensions_Paddedimg(2)-Pad_w+1:dimensions_Paddedimg(2)) = B;
        %figure, imshow(PaddedImg), title("Padded Image: Reflect Across the Edge Padding")
end      


    % Convert uint8 to Double to do matrix multiplication with kernel
    DoubleImg = im2double(PaddedImg);
    M = size(kernel,1) - 1;
    
    % Convolution
    for i = 1:size(DoubleImg,1) - M
        for j = 1:size(DoubleImg,2) - M
            Temp = DoubleImg(i:i+M, j:j+M).*kernel;
            g(i,j) = sum(Temp(:));
        end
    end
    %figure, imshow(g), title("Output Image");

end

