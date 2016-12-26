% On s�lectionne la cible de l'apprentissage et celle de test
YA=(XA(:, end:end));
YT=(XT(:, end:end));

% On convertit en string
YA=num2str(YA);
YT=num2str(YT);

A1=dataset(XA(:,1:p-1),YA); % Transformer les donn�es au format appropri�
tree=treec(A1,1,0); % Pour construire l'arbre de d�cision, 1 pour dire 
% que le gain d'information sera utilis� comme crit�re de d�coupage 
% (splitting) et 0 pour dire que les arbres sont construits sans �lagage 
% (pruning)



T1=dataset(XT(:,1:p-1),YT) ; % Transformer les donn�es de test au format appropri�
[F,predictionT]=tree_map(T1,tree); % calcul des classes pr�dites

