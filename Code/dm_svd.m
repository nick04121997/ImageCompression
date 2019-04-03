function [S,U,V] = dm_svd(A)
    if (size(A,1) >= size(A,2))
        [U,S1] = eig(A*A');
        S1 = sqrt(abs(S1));
        [~,ind1] = sort(diag(S1),'descend');

        S1 = S1(ind1,ind1);
        U = U(:,ind1);
        S = S1;

        V = zeros(size(A,2));
        for i = 1:size(V,1)
           V(:,i) = (1/S(i,i))*A'*U(:,i); 
        end
    else
        [V,S2] = eig(A'*A);
        S2 = sqrt(abs(S2));
        [~,ind2] = sort(diag(S2),'descend');

        S2 = S2(ind2,ind2);
        V = V(:,ind2);
        S = S2;

        U = zeros(size(A,1));
        for i = 1:size(U,1)
           U(:,i) = (1/S(i,i))*A*V(:,i); 
        end
    end
    
    dimU = size(U,1);
    dimV = size(V,1);

    colDiff = size(S,2) - dimV;
    rowDiff = size(S,1) - dimU;
    
    if (colDiff == 0) && (rowDiff == 0)
       return
    elseif (colDiff == 0)
        S(end-rowDiff+1:end,:) = [];
    else
        S(:,end-colDiff+1:end) = []; 
    end
end