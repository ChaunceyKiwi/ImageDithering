function newMat = nextMatrix(oriMat)
% This function calculates the larger dither matrix D(2n) from smaller
% one D(n). The size of matrix is the double of the original one.
newMat = [4*oriMat,4*oriMat+2;4*oriMat+3,4*oriMat+1];