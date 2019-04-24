img = imread('../Images/classic/mandril_gray.tif');
I = im2double(img);

T = dftmtx(8);
dft = @(block_struct) T * block_struct.data * T';
B = blockproc(I,[8 8],dft);
dft2 = @(block_struct) fft2(block_struct.data);
B2 = blockproc(I,[8 8],dft2);

mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
    
% mask = zeros(8);
% mask(1,1) = 1;
        
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
invdft = @(block_struct) inv(T) * block_struct.data * inv(T');
I2 = blockproc(B2,[8 8],invdft);
I2 = real(I2);
I_diff = abs(I2-I);

imshow(I)
figure;
imshow(I2)
figure;
imshow(I_diff,[])
