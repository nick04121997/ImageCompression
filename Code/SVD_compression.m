function [nzr_vector, psnr_vector, err_vector] = SVD_compression(img)
img = im2double(img);
[S,U,V] = dm_svd(img);

N = min(size(S));
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);
nzr_vector = zeros(N,1);

for counter = 1:min(size(S))
    U_truncated = U(:,1:counter);
    V_truncated = V(:,1:counter);
    S_truncated = S(1:counter,1:counter);
    img_compressed = U_truncated*S_truncated*V_truncated';
    img_diff = abs(img-img_compressed);
    err = mean(mean(img_diff));
    err_vector(counter) = err;
    psnr_vector(counter) = psnr(img_compressed,img);
    nzr = (nnz(U_truncated) + nnz(V_truncated) + nnz(S_truncated))/numel(img);
    nzr_vector(counter) = nzr;
end

end