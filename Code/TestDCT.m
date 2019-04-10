img = imread('../Images/classic/lena_gray_512.tif');
img = im2double(img);
T = dm_dct(img);