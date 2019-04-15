img = imread('../Images/classic/mandril_gray.tif');
img = im2double(img);
T = dm_dct(img);