clear all
close all
img = imread('../Images/classic/mandril_gray.tif');
[nzr_vector, psnr_vector, err_vector] = SVD_compression(img);

figure;
title("Error plot");
plot(nzr_vector, err_vector);
xlabel('Compression ratio');
ylabel('Average pixel error');

figure;
title("PSNR plot");
plot(nzr_vector, psnr_vector);
xlabel('Compression ratio');
ylabel('PSNR');