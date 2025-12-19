%--------------------------------------------------------------------------
% X D*N is dataset
% F N*C is Pseudo label
% W D*N weight matrix


function [est_labels,CMat,F,W] = SSC2(X,F,W,numClust,options)


rho = options.rho;
SC_type = options.SC_type;

[CMat,F,W] = ISC(X,F,W,options);
C = CMat;


CKSym = BuildAdjacency(thrC(C,rho));

if SC_type == 0
    est_labels = SpectralClustering(CKSym,numClust);
else
    est_labels = SpectralClustering_OMP(CKSym, numClust, 'Eig_Solver', 'eigs');
end

