close all;
clear all;
clc;

%PreparingData
[X,Y] = preparingData();
aux = zeros(size(Y,1), size(Y,2));
for i = 1:size(Y,2)
   aux(Y(i)+1,i) = 1;
end
Y = aux;
Xo = X;
%PCA
W = pca(Xo,50);
X = W*X;
[X,Y] = shuffle(X,Y);

%Using crossvalidation
erN = [];
neu = 20;
bestErN = Inf;
for c = 1:10 %10 groups for crossvalidation
    
   [Xtrain,Xtest,Ytrain,Ytest] = crossval(X,Y,10,c); %C is the group selected
    errorI = [];
    for j = 17:neu
        net = newff(minmax(Xtrain),[j size(Y,1)],{'tansig' 'tansig'},'trainlm'); %10 number of output layer (number of classes)
        net.trainParam.epochs = 100;
        net.trainParam.goal = 0.01;
        net = train(net,Xtrain,Ytrain);
        Y2 = sim(net,Xtest);
        [~,Result]=max(Y2);
        [~,ResultE] = max(Ytest);
        errorI(c,j-1)= 1-(sum(Result==ResultE)/length(Result));
        %pause(2);
                errorN = mean(errorI);
        erN = errorN
     if(errorN < bestErN)
        bestErN = errorN;
        bestNet = net;
    end
    
     end

    
end
disp('Error obtained by the Neural Network classificator with 10 neuron in the output layer and 1 hidden layer (%)');
disp(num2str(bestErN*100));