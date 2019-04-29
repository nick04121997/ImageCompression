clear all
close all
img = imread('../Images/classic/mandril_gray.tif');

for i = 1:4
    if i==1
        method = 'SVD';
        [nzr_vector, psnr_vector, err_vector] = SVD_compression(img);
    elseif i==2
        method = 'DFT';
        [nzr_vector, psnr_vector, err_vector] = DFT_compression(img);
    elseif i==3
        method = 'DCT';
        [nzr_vector, psnr_vector, err_vector] = DCT_compression(img);
    else
        method = 'DWT';
        [nzr_vector, psnr_vector, err_vector] = DWT_compression(img);        
    end

    figure(1);
    plot(nzr_vector, err_vector,'-o');
    hold on;

    figure(2);
    plot(nzr_vector, psnr_vector,'-o');
    hold on;
    
    figure;
    plot(nzr_vector, err_vector,'-o');
    xlabel('Non-zero rate');
    ylabel('Average pixel error');
    title([method," Average Pixel Error Plot"]);
    
    figure;
    plot(nzr_vector, psnr_vector,'-o');
    xlabel('Non-zero rate');
    ylabel('PSNR');
    title([method, "PSNR Plot"]);

end

figure(1);
xlabel('Non-zero rate');
ylabel('Average pixel error');
title([" Average Pixel Error Plot"]);
legend({'SVD','DFT','DCT','DWT'});

figure(2);
xlabel('Non-zero rate');
ylabel('PSNR');
title(["PSNR Plot"]);
legend({'SVD','DFT','DCT','DWT'});