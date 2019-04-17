clear all;
close all;
img = imread('../Images/classic/mandril_gray.tif');
img = im2double(img);
[S,U,V] = dm_svd(img);
img_reconstructed = U*S*V';
N = min(size(S));
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);

for counter = 1:min(size(S))
    U_truncated = U(:,1:counter);
    V_truncated = V(:,1:counter);
    S_truncated = S(1:counter,1:counter);
    img_compressed = U_truncated*S_truncated*V_truncated';
    img_diff = abs(img-img_compressed);
    err = mean(mean(img_diff));
    err_vector(counter) = err;
    psnr_vector(counter) = psnr(img_compressed,img);
end

figure;
title("Error plot");
plot(1:min(size(S)), err_vector);
xlabel('Number of singular values');
ylabel('Average pixel error');

figure;
title("PSNR plot");
plot(1:min(size(S)), psnr_vector);
xlabel('Number of singular values');
ylabel('PSNR');

figure;
plot(1:512,diag(S));
% figure;
% title("Log Error plot");
% plot(1:400, log(err_vector(1:400)));
% xlabel('Number of singular values');
% ylabel('Log average pixel error');