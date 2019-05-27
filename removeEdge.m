function [X, Y]= removeEdge(input)
    
    X = []; %to enter the numbers as patterns
    Y = [];
    um = graythresh(input);
    im = im2bw(input,um); %to convert the color image in a binary image.
    
    %Using the regionprops. Find regions in a image.
    figure,imshow(im);
    [L Ne] = bwlabel(im);
    reg = regionprops(L);
    for n =1:size(reg,1)
       rectangle('Position',reg(n).BoundingBox, 'EdgeColor','g','LineWidth',2);
    end
    
    %find the regions that smaller than the total size of the image (the
    %bigest region) and those that are bigger than the half size.
    s = find([reg.Area]<(size(im,2)/12)*(size(im,1)/22) & [reg.Area]>(size(im,2)/12)*(size(im,1)/22)/2);
    %figure,
    cont = 0;
    for i =1:size(s,2)
    bound = round(reg(s(i)).BoundingBox);
    imNum = im(bound(2)-2:bound(2)+bound(4)-2,bound(1)-2:bound(1)+bound(3)-2);
    %subplot(1,2,1),imshow(imNum);
    [L2 Ne2] = bwlabel(imNum);
    reg2 = regionprops(L2);
    s2 = find([reg2.Area]>max([reg2.Area])*0.2);
    %imshow(imNum);
    format shortG
    c = strel('square',2);
    
    for i2 =1:size(s2,1)
        bound2 = round(reg2(s2(i2)).BoundingBox);
        imNum2 = imNum(bound2(2)+2:bound2(4)-2,bound2(1)+2:bound2(3)-2);
        imNum2 = imresize(imNum2, [99 128]);
        imNum2 = imerode(imNum2,c); 
        imNum2 = imerode(imNum2,c);
        imNum2 = imresize(imNum2, 0.6);
        X = [X imNum2(:)]; %Characteristics vector
        Y = [Y floor(cont/22)+1]; %clases vector
         
        
    end
    cont = cont+1;
    end    
    
end