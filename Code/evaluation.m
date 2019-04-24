clear all
close all
img = imread('../Images/classic/mandril_gray.tif');
[nzr_vector, psnr_vector, err_vector] = SVD_compression(img);


figure;
title("Error plot");
plot(1:size(err_vector), err_vector);
xlabel('Number of singular values');
ylabel('Average pixel error');

figure;
title("PSNR plot");
plot(1:size(psnr_vector), psnr_vector);
xlabel('Number of singular values');
ylabel('PSNR');