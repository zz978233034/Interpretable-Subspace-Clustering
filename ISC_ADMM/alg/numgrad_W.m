function [ output_args ] = numgrad_W( X,F,S,lambda,alpha,gamma,x )
%NUMGRAD1 此处显示有关此函数的摘要
%   此处显示详细说明
% 此函数用来验证梯度，用[f(x+ delta)  + f(x  - delta )] / 2 的方式来计算梯度，若原始求梯度方法无误的话，该值的差异不会太大
epsilon = 1e-4;
[d,n]= size(x);
numgrad = zeros(d*n, 1);
tic
[~,grad2]=obj_W_zz_W12(X,F,S,lambda,alpha,gamma,n,d,x );
toc
for i = 1:n*d
    i
    tmp1 = x;
    tmp2 = x;
    tmp1(i) = tmp1(i) + epsilon;
    tmp2(i) = tmp2(i) - epsilon;
    obj1 = obj_W_zz_W12(X,F,S,lambda,alpha,gamma,n,d,tmp1);
    numgrad(i) = (obj_W_zz_W12(X,F,S,lambda,alpha,gamma,n,d,tmp1) - obj_W_zz_W12(X,F,S,lambda,alpha,gamma,n,d,tmp2))/2/epsilon;
end
% tic
% [~,grad3]=obj_f1(DWD,XF,GF,GF_all,X,G,F,Lambda1,mu,k,m,sqrt(n),x);
% toc
max(max(abs(grad2-numgrad)))
%max(max(abs(grad2-grad3)))
end

