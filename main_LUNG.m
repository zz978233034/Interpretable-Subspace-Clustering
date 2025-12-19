<<<<<<< HEAD

clear;
load datasets/lung.mat
Z = X';
true_labels = Y;
dataName = "lung" ;
[d,n] = size(Z);
numClust = length(unique(true_labels));

Z = double(Z); Z = normc(Z);
S = constructW_PKN(Z,5,1);
[~,label_pred] = SpectralClustering_ncut(S,numClust);
F = full(ind2vec(label_pred'))';

options = [];
options.lambda = 100;
options.beta = 1e-3;
options.updateY=1;
options.gamma =0.1;
options.grad = 1;
options.alpha = 0.1;
options.affine = true;
options.outlier = false;
options.rho = 0.8;
options.SC_type = 0;
options.maxIter = 10;
options.thr1 = 1e-3;
options.repeat = 1;
repeat = options.repeat;

best_acc = 0;
result = [];
W = ones(d,n)/1; 

tic; [e_SC,CMat,label_pred,W] = SSC2(Z,F,W,numClust,options); time = toc;
acc = 1 - misRate(true_labels, e_SC)/n;% SSC cluster result
[~,label_pred] = max(label_pred,[],2);
[acc_W,nmi_W,purity_W,ari_W]=ClusteringMeasure(label_pred,true_labels);

fprintf('ADMM SSC: accuracy = %.4f, time = %f\n', acc_W, time);


      




=======

clear;
load datasets/lung.mat
Z = X';
true_labels = Y;
dataName = "lung" ;
[d,n] = size(Z);
numClust = length(unique(true_labels));

Z = double(Z); Z = normc(Z);
S = constructW_PKN(Z,5,1);
[~,label_pred] = SpectralClustering_ncut(S,numClust);
F = full(ind2vec(label_pred'))';

options = [];
options.lambda = 100;
options.beta = 1e-3;
options.updateY=1;
options.gamma =0.1;
options.grad = 1;
options.alpha = 0.1;
options.affine = true;
options.outlier = false;
options.rho = 0.8;
options.SC_type = 0;
options.maxIter = 10;
options.thr1 = 1e-3;
options.repeat = 1;
repeat = options.repeat;

best_acc = 0;
result = [];
W = ones(d,n)/1; 

tic; [e_SC,CMat,label_pred,W] = SSC2(Z,F,W,numClust,options); time = toc;
acc = 1 - misRate(true_labels, e_SC)/n;% SSC cluster result
[~,label_pred] = max(label_pred,[],2);
[acc_W,nmi_W,purity_W,ari_W]=ClusteringMeasure(label_pred,true_labels);

fprintf('ADMM SSC: accuracy = %.4f, time = %f\n', acc_W, time);


      




>>>>>>> 30e7674ede0b43b861e4a59f098167cf0d162054
