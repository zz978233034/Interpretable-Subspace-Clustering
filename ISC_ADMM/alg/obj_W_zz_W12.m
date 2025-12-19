
% obj : L = lambda*||X-(X.*W)S||_F^2 +  alpha* ||W||_{1,2} + gamma*||WF||_F^2


function [ obj,grad ] = obj_W_zz_W12(X,F,S,XXS,SS,YY,lambda,alpha,gamma,n,d,x)
W = reshape(x,d,n);
clear x;

% compute obj , ||X - (X.*W)*S||_F^2
term1 = X - (X.*W)*S;
obj_term1=lambda*sum(sum(term1.^2));
% compute obj , ||W|_{1,2}
term2 = sum(W,1);
obj_term2 = alpha*sum(term2.^2);
% compute obj , ||WF|_{1,2}
term3 = sum(W*F,1);
obj_term3=gamma*sum(term3.^2);


obj = obj_term1  + obj_term2 + obj_term3  ;



% compute W's grad

grad = grad_W12(X,W,XXS,SS,YY,lambda,alpha,gamma);
grad=reshape(grad,d*n,1);

end
