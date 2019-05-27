function [r, X] = reconoce2(image)

    im = imread(image);
    load('X.mat');
    load('Y.mat');
    Xi = X;
    disp('Se mostrará la imagen de la cuadrícula, y posteriormente los recuadros detectados');
    pause(0.1);
    [X,~] = removeEdge(im);
    r = [];
    Xo = X;
    Xoi = Xi;
    %Y = [Y Inf(1,size(X,2))]
    %PCA
    W = pca(Xo,10);
    X = W*X;
     %PCA
    W = pca(Xoi,10);
    Xi = W*Xi;
    
    for j = 1:size(X,2)
        distanceX = d_euclid(Xi,X(:,j));
        [~, index] = sort(distanceX);
        A(j) = mode(Y(index(1:11)));
    end
    for i = 1:length(A)/22
        r =[r ;A((i-1)*22+1:i*22)];
    end
    end