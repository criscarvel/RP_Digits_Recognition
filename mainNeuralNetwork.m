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
[X,Y] = shuffle(X,Y);

%Using crossvalidation
erN = [];
neu = 20;
bestErN = Inf;
%for c = 1:10 %10 groups for crossvalidation
    
   [Xtrain,Xtest,Ytrain,Ytest] = crossval(X,Y,20,10); %C is the group selected
    errorI = [];
    cont=1;
    for j = 2:5
        net = newff(minmax(Xtrain),[j 10],{'tansig' 'tansig'},'trainlm'); %10 number of output layer (number of classes)
        net.trainParam.epochs = 100;
        net.trainParam.goal = 0.01;
        net = train(net,Xtrain,Ytrain);
        Y2 = sim(net,Xtest);
        [~,Result]=max(Y2);
        [~,ResultE] = max(Ytest);
        errorI(cont)= 1-(sum(Result==ResultE)/length(Result));
        %pause(2);
        cont = cont+1;
     end
        errorN = mean(errorI);
        erN = errorN
     if(errorN < bestErN)
        bestErN = errorN;
        bestNet = net;
    end
    
%end
disp('Error obtained by the Neural Network classificator with 10 neuron in the output layer and 1 hidden layer (%)');
disp(num2str(bestErN*100/size(Ytest,2)));