function [ W_result ] = LBFGSB_W(X,F,S,W_init,lambda,gamma,alpha)
    
    [d,n] = size(W_init);
    XXS = 2.*X.*( X * S');
    SS = S*S';
    YY = F*F';
    funObj=@(x)obj_W_zz_W12(X,F,S,XXS,SS,YY,lambda,alpha,gamma,n,d,x);

    x_init=reshape(W_init,d*n,1);

%   下界
    LB=zeros(d*n,1);
%    LB=zeros(row,1);
%   上界
    UB=ones(d*n,1);
    options=[];
    options.x0=x_init;
%   options.verbose=0;
    options.pgtol=1e-3;
    options.maxIts=1;
    options.printEvery=1;
%   options.numDiff=1;
%   x = minConf_TMP(funObj,x_init,LB,UB,options);
    x = lbfgsb(funObj,LB,UB,options);
    W_result=reshape(x,d,n);




end
