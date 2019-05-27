close all;
clear all;
clc;

%Preparing data base
[X,Y] = preparingData();
Xo = X;
Yo = Y;
%To reduce the dimensionality (with PCA)

%PCA
W = pca(Xo,2);
X = W*X;



%to mix the patterns to remove the sort
[X,Y] = shuffle(X,Y);

erKNN = [];
  for k=10:20
     for j = 2:size(X,2)
     distanceX = d_euclid(X,X(:,j));
     [~, index] = sort(distanceX);
     newClass(j) = mode(Y(index(2:k+1)));
     end
     erKNN = [erKNN sum(Y~=newClass)*100/size(X,2)];
  end
disp('Error obtained by the KNN classificator(%)');
disp(num2str(erKNN));    
            
