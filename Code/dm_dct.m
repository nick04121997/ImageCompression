function [T] = dm_dct(img)

[k,l] = size(img);
if k ~= l
    error('Not a square image')
end

T = [];
% Size of subimage
n = 8;
nrow = k/n;
ncol = l/n;

counter = 0;
C = mat2cell(img, n*ones(1,nrow), n*ones(1,ncol));

for subimgrow = 1:nrow
    for subimgcol = 1:ncol
        subimg = C{subimgrow,subimgcol};
        subT = zeros(n,n);
        for u = 1:n
            for v = 1:n
                for x = 1:n
                    for y = 1:n
                        subT(u,v) = subT(u,v) + subimg(x,y)*r(x-1,y-1,u-1,v-1,n);
                        counter = counter + 1;
                    end
                end 
            end
        end
        C{subimgrow,subimgcol} = subT;
    end
end

T = cell2mat(C);

function output = r(x,y,u,v,n)
    output = alpha(u,n)*alpha(v,n)...
    *cos(((2*x+1)*u*pi)/(2*n))*cos(((2*y+1)*v*pi)/(2*n));
end
    
function output = alpha(u,n)
   if u == 0
       output = sqrt(1/n);
   else
       output = sqrt(2/n);
   end
end

end