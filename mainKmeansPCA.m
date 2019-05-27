close all;
clear all;
clc;

%Preparing data base
[X,Y] = preparingData();
Xo = X;
Yo = Y;
%To reduce the dimensionality (with PCA)

%PCA
W = pca(Xo,50);
X = W*X;



%to mix the patterns to remove the sort
[X,Y] = shuffle(X,Y);

%Using crossvalidation
erKm = [];
erKM = Inf(10,11)
centerKm = {};
 erKm = [];
for c = 1:10 %10 groups for crossvalidation
    cont =1;
    for k = 10:20 %Change the number of centroides. 
        for n = 1:2;%to initialize 2 times the train and test data with crossval
            [XTrain,XTest,YTrain,YTest] = crossval(X,Y,10,c); %C is the group selected

            %K-means (10)
            centers = kmeans(XTrain,k); %10 is the number of centroides
            [class, ~] = mycenter(XTrain,centers); %return the closer center.
            testCenters = mycenter(XTest, centers); %Associated Centers(index)
             %Associated class center by Mode.
            classAsoc = asociar(centers, testCenters, YTest);
            %Original classes of the associated centers.
            classNew = classAsoc(testCenters);
            errorIKmeans = 0;            
            
            erKm =sum(YTest~=classNew);
            if erKM(c,cont)>erKm
                centerKm{c,cont} = {centers};
                erKM(c,cont) = erKm;
            end
        end
       cont=cont+1;
    end
end

disp('Error obtained by the k-means classificator with 10 centers (%)');
disp(num2str(mean(erKM)*100/size(YTest,2)));