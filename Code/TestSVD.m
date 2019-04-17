img = imread('../Images/classic/mandril_gray.tif');
img = im2double(img);
[S,U,V] = dm_svd(img);
img_reconstructed = U*S*V';
S_sum = sum(diag(S));

threshold = 0.5;
curr_sum = 0;
counter = 1;

while curr_sum < (S_sum*threshold)
   curr_sum = curr_sum + S(counter,counter);
   counter = counter + 1;
end

U_truncated = U(:,1:counter);
V_truncated = V(:,1:counter);
S_truncated = S(1:counter,1:counter);
img_compressed = U_truncated*S_truncated*V_truncated';

img_diff = abs(img-img_compressed);
err = mean(mean(img_diff));

%% Plot Figures
% figure;
% title('Original Image');
% imshow(img);
% 
% figure;
% title('Compressed Image');
% imshow(img_compressed);
%
% figure;
% title('Difference Image');
% imshow(img_diff);