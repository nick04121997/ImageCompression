function [nzr_vector, psnr_vector, err_vector] = DFT_compression(img)

% img = imread('../Images/classic/mandril_gray.tif');
% img = im2double(img);

% T = dftmtx(8);
% dft = @(block_struct) T * block_struct.data * T';
dft = @(block_struct) fft2(block_struct.data);
B = blockproc(img,[8 8],dft);

offset_vector = -7:7;
N = numel(offset_vector);
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);
nzr_vector = zeros(N,1);

for i = 1:N
    offset = offset_vector(i);
    mask = rot90(triu(ones(8),offset));

    B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
    % invdft = @(block_struct) inv(T) * block_struct.data * inv(T');
    invdft = @(block_struct) ifft2(block_struct.data);
    img_compressed = blockproc(B2,[8 8],invdft);
        
    img_compressed = real(img_compressed);
    img_compressed = uint8(img_compressed);
    
    img_diff = abs(img_compressed-img);
    err = mean(mean(img_diff));
    err_vector(i) = err;
    psnr_vector(i) = psnr(img_compressed,img);
    nzr = nnz(B2)/numel(img);
    nzr_vector(i) = nzr;
    
    figure;
    imshow(img);
    figure;
    imshow(img_compressed);
%     imshow(I_diff,[])
end
end