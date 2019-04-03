% A = [1 2 3; 4 5 6];
% [S,U,V] = dm_svd(A);

img = imread('../Images/lena_gray_512.tif');
img = im2double(img);
[S,U,V] = dm_svd(img);
img_reconstructed = U*S*V';