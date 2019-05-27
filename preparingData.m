function [X,Y] = preparingData()
    
    
    %BD = imread('t2_1.jpg'); % numbers written with marker
    %BD2 = imread('bd1.jpg'); %numbers written with pen
    Xaux = [];
    Yaux = [];
    for i=1:5 
        BD3= imread(strcat('b',num2str(i),'.jpg'));
        %BD3 = imread(BD3);
        %Xaux2 = removeEdge(BD3);
        [Xaux2, Yaux2] = removeEdge(BD3);
  
        %Yaux2 = [];
        %for i = 1:size(Xaux2,2)
        %    if mod(i,22)~=0
        %        aux = (floor(i/22)+1); 
        %    else
        %        aux = (floor(i/22));
        %    end
        %        Yaux2=[Yaux2 aux];
        %end
        Yaux = [Yaux Yaux2];
        Xaux = [Xaux Xaux2];
    end
    Yaux = Yaux-1;
    %X = removeEdge(BD); 
    %aux2 = removeEdge(BD2);
    %X = [X aux2];
    %Set the class
    %Y = [];
    %for i = 1:size(X,2)
        %if mod(i,22)~=0
         %   aux = (floor(i/22)+1); 
        %else
       %     aux = (floor(i/22));
      %  end
     %       Y=[Y aux];
    %end
    %aux3 = Y-1;
    %Y(find(Y==10)) = 0;
    %X = [X Xaux];
    %Y = [Y Yaux];
    X = Xaux;
    Y = Yaux;

end