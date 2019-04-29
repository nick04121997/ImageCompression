function [nzr_vector, psnr_vector, err_vector] = SVD_compression(img)
img_double = im2double(img);
[S,U,V] = dm_svd(img_double);

N = min(size(S));
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);
nzr_vector = zeros(N,1);
step = 10;

for i = 1:min(size(S))
    counter = step*i;
    U_truncated = U(:,1:counter);
    V_truncated = V(:,1:counter);
    S_truncated = S(1:counter,1:counter);
    img_compressed = U_truncated*S_truncated*V_truncated';
    img_compressed = im2uint8(img_compressed);
    img_diff = abs(img-img_compressed);
    err = mean(mean(img_diff));
    nzr = (nnz(U_truncated) + nnz(V_truncated) + nnz(S_truncated))/numel(img);
    if (nzr >= 1)
        break
    end
    nzr_vector(i) = nzr;
    err_vector(i) = err;
    psnr_vector(i) = psnr(img_compressed,img);
end
err_vector = err_vector(1:i-1);
psnr_vector = psnr_vector(1:i-1);
nzr_vector = nzr_vector(1:i-1);
end