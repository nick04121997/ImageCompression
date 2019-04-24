img = imread('../Images/classic/mandril_gray.tif');
I = im2double(img);

T = dctmtx(8);
%dct = @(block_struct) T * block_struct.data * T';
dct = @(block_struct) dct2(block_struct.data);
B = blockproc(I,[8 8],dct);

mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];
        
B2 = blockproc(B,[8 8],@(block_struct) mask .* block_struct.data);
%invdct = @(block_struct) T' * block_struct.data * T;
invdct = @(block_struct) idct2(block_struct.data);
I2 = blockproc(B2,[8 8],invdct);
I_diff = abs(I2-I);

imshow(I)
figure;
imshow(I2)
figure;
imshow(I_diff,[])
