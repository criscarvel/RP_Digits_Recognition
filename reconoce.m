function [A] = reconoce(image)

    im = imread(image);
    disp('Se mostrará la imagen de la cuadrícula, y posteriormente los recuadros detectados');
    pause(0.1);
    [X,~] = removeEdge(im);
    load('bestNet2.mat');
    Xo = X;
    r = [];
    %PCA
    W = pca(Xo,60);
    X = W*X;
    Y = sim(bestNet,X);
    [~,A] = max(Y);
    A = A-1;
    for i = 1:length(A)/22
        r =[r ;A((i-1)*22+1:i*22)];
    end
end