

function [C2,F,W] = ISC(Y,F,W,options)
tic; 
maxIter = options.maxIter;
beta = options.beta;
gamma = options.gamma;
lambda = options.lambda;
alpha = options.alpha;
[d,N]= size(Y);
% setting penalty parameters for the ADMM
mu1 = options.lambda * 1/computeLambda_mat(Y);
mu2 = options.lambda * 1;
 
C1 = zeros(N,N);
Lambda2 = zeros(N,N);
lambda3 = zeros(1,N);
i = 1;
F_norm = F*diag(sqrt(1./diag(F'*F))); 
Q=L2_distance_1(F_norm',F_norm');

j = 1;
while ( i < maxIter )
    YW = Y.*W;
    % updating Z
    if d<N
        epslion = 2*mu1/mu2;
        J = eye(N) - epslion*(YW)'/ ((eye(d) + epslion*YW*(YW)')) *YW; 
        temp_A = sum(J,2);
        A = J - (temp_A*temp_A')/(1 + sum(temp_A));
        Z = A * ((2*mu1*((YW)'*Y)/mu2+(C1-Lambda2/mu2)+ones(N,1)*(ones(1,N)-lambda3/mu2)) - beta*Q/mu2);
    else
        Z = (2*mu1*((YW)'*(YW))+mu2*eye(N)+mu2*ones(N,N)) \ (2*mu1*((YW)'*Y)+mu2*(C1-Lambda2/mu2)+mu2*ones(N,1)*(ones(1,N)-lambda3/mu2)) - beta*Q;
    end
    Z = Z - diag(diag(Z));

    C2 = max(0,(abs(Z+Lambda2/mu2) - 1/mu2*ones(N))) .* sign(Z+Lambda2/mu2);
    C2 = C2 - diag(diag(C2));

    if options.grad
        [W] = LBFGSB_W(Y,F,Z,W,lambda,gamma,alpha);
    end    

    if options.updateY
        D = diag(sum(Z));
        L = D-(Z+Z')/2;
        S2 = W'*ones(d,d)*W;
        L = beta*L ; 
        A =  gamma*S2;
        F = solve_Y(L,A,F);
        F_norm = F*diag(sqrt(1./diag(F'*F))); 
        Q=L2_distance_1(F_norm',F_norm');
    else
        L=Z;
        
    end

    Lambda2 = Lambda2 + mu2 * (Z - C2);
    lambda3 = lambda3 + mu2 * (ones(1,N)*Z - ones(1,N));  
    C1 = C2;
    i = i + 1;    
    
end