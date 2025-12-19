function obj_all = compute_obj_W12(X,F,S,C,lambda,beta,gamma,alpha,mu2,lambda2,lambda3,n,d,x)
W = reshape(x,d,n);
mu1 = lambda;
clear x;
D = diag(sum(S));
L = D-(S+S')/2;
% compute obj , no squard
term1 = X - (X.*W)*S;
obj_term1=mu1*sum(sum(term1.^2));


%obj_term2 
obj_term2=sum(sum(C));


obj_term3 = beta*trace(F'*L*F);


obj_term4 = gamma*trace(F'*(W'*ones(d,d)*W)*F);

% mu2/2 * ||S^T*1 - 1||_2
obj_term5 = 0.5*mu2*trace(ones(1,n)*S*S'*ones(n,1)-2*ones(1,n)*S*ones(n,1));

%mu2 / 2 * ||S-C+diag(C)||_2
term6 = S - C + diag(diag(C));
obj_term6 = mu2*0.5*sum(sum(term6.^2));

% lambda3*(S'*1-1)
obj_term7 = lambda3*(S'*ones(n,1) - ones(n,1));

% tr(lambda2 * (S-C+diag(C)))
obj_term8 = trace(lambda2' *term6 );
% compute obj , ||W|_{1,2}
obj_term9 = alpha*sum(sum(W,1).^2);
obj = obj_term1  + obj_term2 + obj_term3 + obj_term4 +  obj_term5+obj_term6 +obj_term7 + obj_term8 +obj_term9 ;%
obj_all = [obj,obj_term1,obj_term2,obj_term3,obj_term4,obj_term5+obj_term6 ,obj_term7 , obj_term8 ,obj_term9];%
end