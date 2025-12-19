function gradW = grad_W12(X,W,XXS,SS,YY,lambda,alpha,gamma)
    [d,~] = size(W);
    
    w_tmp=sum(W);
    temp = repmat(w_tmp,d,1);
    grad1 = lambda.*2.*X.*((X.*W)*SS) - XXS;    
    grad2 = 2.*alpha*temp;
    w_tmp2=w_tmp*YY;
    grad3 = 2.*gamma*repmat(w_tmp2,d,1);

   
    gradW = grad1  + grad2 + grad3;%



end