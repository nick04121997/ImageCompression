function [nzr_vector, psnr_vector, err_vector] = DCT_compression(img)
% I = im2double(img);
% T = dctmtx(8);
% dct = @(block_struct) T * block_struct.data * T';
dct = @(block_struct) dct2(block_struct.data);
B = blockproc(img,[8 8],dct);

% mask = [1   1   1   1   0   0   0   0
%         1   1   1   0   0   0   0   0
%         1   1   0   0   0   0   0   0
%         1   0   0   0   0   0   0   0
%         0   0   0   0   0   0   0   0
%         0   0   0   0   0   0   0   0
%         0   0   0   0   0   0   0   0
%         0   0   0   0   0   0   0   0];
Q_standard = ...
 [16, 11, 10, 16, 24, 40, 51, 61;
  12, 12, 14, 19, 26, 58, 60, 55;
  14, 13, 16, 24, 40, 57, 69, 56;
  14, 17, 22, 29, 51, 87, 80, 62;
  18, 22, 37, 56, 68, 109, 103, 77;
  24, 35, 55, 64, 81, 104, 113, 92;
  49, 64, 78, 87, 103, 121, 120, 101;
  72, 92, 95, 98, 112, 100, 103, 99];

quality_level_vector = 100-logspace(2,0,20);
N = numel(quality_level_vector);
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);
nzr_vector = zeros(N,1);

for i = 1:N
    quality_level = quality_level_vector(i);
    if quality_level >= 50
        Q = round(Q_standard*(100-quality_level)/50);
    else
        Q = round(Q_standard*50/quality_level);
    end
    Q(Q>255) = 255;
    Q(Q<1) = 1;
    C = blockproc(B,[8 8],@(block_struct) round(block_struct.data./Q));
    B2 = blockproc(C,[8 8],@(block_struct) Q.*block_struct.data);

    % B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
    % invdct = @(block_struct) T' * block_struct.data * T;
    invdct = @(block_struct) idct2(block_struct.data);
    img_compressed = blockproc(B2,[8 8],invdct);
    img_compressed = uint8(img_compressed);

    img_diff = abs(img-img_compressed);
    err = mean(mean(img_diff));
    err_vector(i) = err;
    psnr_vector(i) = psnr(img_compressed,img);
    nzr = nnz(C)/numel(img);
    nzr_vector(i) = nzr;
end
% figure;
% imshow(img);
% figure;
% imshow(img_compressed);
end