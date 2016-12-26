% Deuxi�me partie du TP, fonctionne avec les fichiers fournis

disp('*** Lecture de la base ***'); 
[filename, pathname] = uigetfile( ... 
    {'*.*', 'All Files (*.*)'; ... 
    }, ... 
    'open data'); S = [pathname filename]; 
sD=som_read_data(S);%lecture de la base
p=size(sD.data,2);%nb de colonnes dans la base (nombre de variables+1) 
n=size(sD.data,1); %nb de lignes (individus) dans la base  
X=sD.data;%la matrice des donn�es  
nclasses=max(sD.data(:,p)); %le nombre de classes 

disp('*** S�paration des donn�es de test et d` apprentissage');



XT=[];
XA=[];

for k=1:nclasses
    % S�paration des classes
    class=X(X(:,end)==k, :);
    % G�n�ration d'un tableau [1 .. taille] puis random de l'ordre
    indicesCl=randperm(size(class, 1));
    % On prend les �l�ments correspondant au premier tiers du tableau 
    % pr�c�dent pour le test
    classTest=class(indicesCl(1:round(1/3*size(class, 1))), 1:end);
    % M�me chose pour l'apprentissage
    classApprentissage=class(indicesCl(round(1/3*size(class, 1))+1:end), 1:end);
    
    % On concat�ne les tableaux
    XT=[XT ; classTest];
    XA=[XA ; classApprentissage];
end


% Puis on sauvegarde les s�ries sous le nom fichierdebase+usage
save strcat(filename, 'Apprentissage.mat') XA;
save strcat(filename, 'Test.mat') XT;


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
[F,predictionT]=tree_map(T1,tree);% Calcul des classes pr�dites

confusion=evaluation(predictionT, YT, nclasses); % Evaluation via la matrice de confusion

