img = imread('../Images/classic/mandril_gray.tif');
I = im2double(img);

N = 5; 
wname = 'sym8';
opt = 'gbl';
THR = 20;
SORH = 'h';
KEEPAPP = 1;

[XC,CXC,LXC,PERF0,PERFL2] = wdencmp(opt,I,wname,N,THR,SORH,KEEPAPP);