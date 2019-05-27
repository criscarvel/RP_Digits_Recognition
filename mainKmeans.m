close all;
clear all;
clc;

%Preparing data base
[X,Y] = preparingData();
%to mix the patterns to remove the sort
[X,Y] = shuffle(X,Y);

%Using crossvalidation
erKm = [];
erKM = Inf(10,7);
centerKm = {};

for c = 1:10 %10 groups for crossvalidation
    cont =1;
    for k = 10:5:40 %Change the number of centroides. (10 15 ...80)
        for n = 1:3;%to initialize 3 times the train and test data with crossval
            [XTrain,XTest,YTrain,YTest] = crossval(X,Y,10,c); %C is the group selected

            %K-means (10)
            centers = kmeans(XTrain,10); %10 is the number of centroides
            [class, ~] = mycenter(XTrain,centers); %return the closer center.
            testCenters = mycenter(XTest, centers);
             %Associated Centers(index)
            new = mycenter(XTest, centers);  
            %Associated class center by Mode.
            classAsoc = asociar(centers, new, YTest);
            %Original classes of the associated centers.
            classNew = classAsoc(new);
            errorIKmeans = 0;
            for er = 1:length(classNew)
               if(YTest(er) ~= classNew(er)) 
                   errorIKmeans = errorIKmeans + 1;
               end
            end
            erKm = [erKm errorIKmeans];
            if erKm(c)>errorIKmeans
                erKm(c) = errorIKmeans;
            end
            if erKM(c,cont)>errorIKmeans
                centerKm{c,cont} = {centers};
                erKM(c,cont) = mean(erKm);
            end
        end
        cont=cont+1;
    end
end

disp('Error obtained by the k-means classificator with 10 centers (%)');
disp(num2str(mean(erKM)*100/size(YTest,2)));

