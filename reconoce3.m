function [r] = reconoce3(image)

    im = imread(image);
    disp('Se mostrará la imagen de la cuadrícula, y posteriormente los recuadros detectados');
    pause(0.1);
    [X,~] = removeEdge(im);
    load('centersKM.mat');
    load('classKM.mat');
    r = [];
    Xo = X;
   %PCA
    W = pca(Xo,10);
    X = W*X;
   for j = 1:size(X,2)
     distanceX = d_euclid(centerKm,X(:,j));
     [~, index] = sort(distanceX);
     A(j) = mode(classAsoc(index(1:5)));
   end
    
    for i = 1:length(A)/22
        r =[r ;A((i-1)*22+1:i*22)];
    end
    end