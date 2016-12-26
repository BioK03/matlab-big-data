function bagging(XA, num, XT)
    trees = []; % Stocke l'arbre de chaque bootstrap
    predictions=[]; % Stocke les prédictions de chaque bootstrap
    % Génération de num bootstrap
    for k=1:num
        bootstrap=[];
        
        % Création des bootstrap
        for l=1:size(XA, 1)
            bootstrap=[bootstrap ; XA(ceil(rand*size(XA, 1)), :)];
        end;
        
        % On sélectionne les cibles
        YA=(bootstrap(:, end:end));
        YT=(XT(:, end:end));
        
        % On convertit en string
        YA=num2str(YA);
        YT=num2str(YT);
        
        % Transformation des données
        A1=dataset(bootstrap(:,1:(size(bootstrap, 2)-1)),YA);
       
        tree = treec(A1,1,0);
        T1=dataset(XT(:,1:size(XT, 2)-1),YT) ;
        [F, predictionT]=tree_map(T1,tree);
        % Calcul de prédiction
        
        % Ajout de l'arbre du bootstrap présent
        trees=[trees, tree];
    
        % Ajout des prédictions présentes
        predictions=[predictions, predictionT];
        
    end;
    
    disp('*** Résultats ***');
    results=[];
    for l=1:size(predictions, 1)
        resultspart=[];
        
        % Construction d'un tableau vertical avec les prédictions des
        % bootstrap
        for m=1:num
            resultspart=[resultspart ; predictions(l,m)];
        end;        
        results=[results,resultspart];
    end;
    disp('Une ligne par bootstrap, dernière ligne : mode');
    disp([results;mode(results)]);
    
    % Calcul du nombre de classes
    nbclasses=max(XA(:,size(XA,2)));
    
    % Evaluation via la matrice de confusion
    evaluation(mode(results).', YT, nbclasses);
    
end