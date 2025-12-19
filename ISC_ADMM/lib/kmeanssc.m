clear;
addpath ./interpret/
addpath ./datasets/
addpath ./ClusteringEvaluation/
addpath ./L-BFGS-B-C-master/
addpath ./L-BFGS-B-C-master/src/
addpath L-BFGS-B-C-master\Matlab\
dataName = 'moon_data';
load('datasets/enclosure.mat')   
T = readmatrix('/GeneratedData/ThreeD_500/Data_chainlink_500.csv');
X = [T(:,1),T(:,2),T(:,3)];
Y = T(:,4);
% Jaffe best para lambda = 1e-4 beta = 0


% X = fea;
% Y = gnd;
% X = moon_data.X;
% Y = moon_data.Y;
% X = X';
numClust = length(unique(Y));
X = X';
[d,n]=size(X);
knn_size = 5;
t = 1;
options = [];
options.NeighborMode = 'KNN';
options.k = knn_size;
options.WeightMode = 'HeatKernel';
options.t = t;
% do kmeans and SC
S = constructW(X',options);
dd= sqrt(1./max(sum(S,2),eps));
L= eye(n) -diag(dd)*S*diag(dd);
[H, ~] = eigs(L, numClust,'SA');
H_normalized = H ./ repmat(sqrt(sum(H.^2, 2)), 1,numClust);
result_kmeans = zeros(1,4);
result_SC = zeros(1,4);
iter = 10;
for i=1:iter
    [label_pred, ~] = litekmeans(X',numClust, 'MaxIter',100, 'Replicates',10);
    [acc_k,nmi_k,purity_k,ari_k] = ClusteringMeasure(label_pred,Y);
    resultk = [acc_k,nmi_k,purity_k,ari_k];
    result_kmeans = result_kmeans + resultk;
    label0 = kmeans(H_normalized, numClust, 'MaxIter', 50, 'Replicates', 10);
    
    [acc_SC,nmi_SC,purity_SC,ari_SC] = ClusteringMeasure(label0,Y);
    resultSC =  [acc_SC,nmi_SC,purity_SC,ari_SC];
    result_SC = result_SC + resultSC;
end
avg_kmeans = result_kmeans ./ iter;
avg_SC = result_SC ./ iter;
avg_result = [avg_kmeans;avg_SC];
filename = sprintf('./baseline/baseline/%s.mat',dataName);
save(filename,'avg_result');



