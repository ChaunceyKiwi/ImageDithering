% The original image with 1 byte for each pixel
img = rgb2gray(imread('lenna.tif'));
figure,imshow(img);

% During the paper printing, sometimes we only have 1 bit for each pixel
% If we simply divide all values to 0 or 1, lots of details will be lost
imgBi = img > 127;
figure,imshow(imgBi);

% pattern matrix used to perform dithering
pattDoubleMat = [0,2;3,1]; 
pattTripleMat = [7,9,5;2,1,4;6,3,8]; 
pattQuadMat   = nextMatrix(pattDoubleMat); 
pattEigMat = nextMatrix(pattQuadMat);

% Space can be traded to intensity depth with a large resolution
% In this way, we can retain the details
depth = 8;
pattMat = pattEigMat;
imgDivided = floor(img / (256/(depth*depth+1)));
imgSimu = zeros(depth * size(imgDivided));
[row, col] = size(img);
for i = 1 : row
    for j = 1 : col
        rowBegin = (i - 1) * depth + 1;
        rowEnd = i * depth;
        colBegin = (j - 1) * depth + 1;
        colEnd = j * depth;
        valueOfCurrSubMat = imgDivided(i,j) > pattMat;
        imgSimu((rowBegin:rowEnd),(colBegin:colEnd)) = valueOfCurrSubMat;
    end
end
% figure,imshow(imgSimu,'InitialMagnification','fit');
imwrite(imgSimu, 'imgSimuDepth8.tif','tif');