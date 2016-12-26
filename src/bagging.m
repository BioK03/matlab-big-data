function bagging(XA, num, XT)
    trees = []; % Stocke l'arbre de chaque bootstrap
    predictions=[]; % Stocke les pr�dictions de chaque bootstrap
    % G�n�ration de num bootstrap
    for k=1:num
        bootstrap=[];
        
        % Cr�ation des bootstrap
        for l=1:size(XA, 1)
            bootstrap=[bootstrap ; XA(ceil(rand*size(XA, 1)), :)];
        end;
        
        % On s�lectionne les cibles
        YA=(bootstrap(:, end:end));
        YT=(XT(:, end:end));
        
        % On convertit en string
        YA=num2str(YA);
        YT=num2str(YT);
        
        % Transformation des donn�es
        A1=dataset(bootstrap(:,1:(size(bootstrap, 2)-1)),YA);
       
        tree = treec(A1,1,0);
        T1=dataset(XT(:,1:size(XT, 2)-1),YT) ;
        [F, predictionT]=tree_map(T1,tree);
        % Calcul de pr�diction
        
        % Ajout de l'arbre du bootstrap pr�sent
        trees=[trees, tree];
    
        % Ajout des pr�dictions pr�sentes
        predictions=[predictions, predictionT];
        
    end;
    
    disp('*** R�sultats ***');
    results=[];
    for l=1:size(predictions, 1)
        resultspart=[];
        
        % Construction d'un tableau vertical avec les pr�dictions des
        % bootstrap
        for m=1:num
            resultspart=[resultspart ; predictions(l,m)];
        end;        
        results=[results,resultspart];
    end;
    disp('Une ligne par bootstrap, derni�re ligne : mode');
    disp([results;mode(results)]);
    
    % Calcul du nombre de classes
    nbclasses=max(XA(:,size(XA,2)));
    
    % Evaluation via la matrice de confusion
    evaluation(mode(results).', YT, nbclasses);
    
end