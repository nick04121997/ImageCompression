img = imread('../Images/classic/mandril_gray.tif');
I = im2double(img);

T = dftmtx(8);
%dft = @(block_struct) T * block_struct.data * T';
dft = @(block_struct) fft2(block_struct.data);
B = blockproc(I,[8 8],dft);

mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];

B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
% invdft = @(block_struct) inv(T) * block_struct.data * inv(T');
invdft = @(block_struct) ifft2(block_struct.data);
I2 = blockproc(B2,[8 8],invdft);
I2 = real(I2);
I_diff = abs(I2-I);

imshow(I)
figure;
imshow(I2)
figure;
imshow(I_diff,[])