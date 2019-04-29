function [nzr_vector, psnr_vector, err_vector] = DWT_compression(img)
% Compression parameters.
%------------------------
% meth = 'bal_sn';
sorh = 'h';    % Specified soft or hard thresholding
% thrSettings = 90;
roundFLAG = true;
wname = 'sym8';
level = 4;


threshold_vector = logspace(0,2,20);
N = numel(threshold_vector);
err_vector = zeros(N,1);
psnr_vector = zeros(N,1);
nzr_vector = zeros(N,1);

for i = 1:N
    thrSettings = threshold_vector(i);
    % Compression using WDENCMP.
    %--------------------------
    [coefs,sizes] = wavedec2(img,level,wname);
    [img_compressed,cfsCMP,dimCFS,PERF0] = wdencmp('gbl',coefs,sizes, ...
        wname,level,thrSettings,sorh,1);
    if roundFLAG , img_compressed = round(img_compressed); end
    if isequal(class(img),'uint8') , img_compressed = uint8(img_compressed); 
    end
    
    img_diff = abs(img_compressed-img);
    err = mean(mean(img_diff));
    err_vector(i) = err;
    psnr_vector(i) = psnr(img_compressed,img);
    nzr = (100-PERF0)/100;
    nzr_vector(i) = nzr;
end

end

