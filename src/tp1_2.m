% On sélectionne la cible de l'apprentissage et celle de test
YA=(XA(:, end:end));
YT=(XT(:, end:end));

% On convertit en string
YA=num2str(YA);
YT=num2str(YT);

A1=dataset(XA(:,1:p-1),YA); % Transformer les données au format approprié
tree=treec(A1,1,0); % Pour construire l'arbre de décision, 1 pour dire 
% que le gain d'information sera utilisé comme critère de découpage 
% (splitting) et 0 pour dire que les arbres sont construits sans élagage 
% (pruning)



T1=dataset(XT(:,1:p-1),YT) ; % Transformer les données de test au format approprié
[F,predictionT]=tree_map(T1,tree); % calcul des classes prédites

