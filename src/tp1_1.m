% Première partie du TP, fonctionne uniquement avec IRIS

disp('*** Lecture de la base ***'); 
[filename, pathname] = uigetfile( ... 
    {'*.*', 'All Files (*.*)'; ... 
    }, ... 
    'open data'); S = [pathname filename]; 
sD=som_read_data(S);%lecture de la base
p=size(sD.data,2);%nb de colonnes dans la base (nombre de variables+1) 
n=size(sD.data,1); %nb de lignes (individus) dans la base  
X=sD.data;%la matrice des données 
global nclasses;
nclasses=max(sD.data(:,p)); %le nombre de classes 

disp('*** Séparation des données de test et d` apprentissage ***');

% Tri en Classes
Class1=X(X(:,end)==1, :);
Class2=X(X(:,end)==2, :);
Class3=X(X(:,end)==3, :);

% Génération d'un tableau [1 .. taille] puis random de l'ordre
indicesCl1=randperm(length(Class1));
indicesCl2=randperm(length(Class2));
indicesCl3=randperm(length(Class3));

% On prend les éléments correspondant au premier tiers du tableau précédent
% pour le test
Class1Test=Class1(indicesCl1(1:round(1/3*length(Class1))), 1:5);
Class2Test=Class2(indicesCl2(1:round(1/3*length(Class2))), 1:5);
Class3Test=Class3(indicesCl3(1:round(1/3*length(Class3))), 1:5);

% Même chose pour l'apprentissage (les 2/3 suivants)
Class1Apprentissage=Class1(indicesCl1(round(1/3*length(Class1))+1:end), 1:5);
Class2Apprentissage=Class2(indicesCl2(round(1/3*length(Class2))+1:end), 1:5);
Class3Apprentissage=Class3(indicesCl3(round(1/3*length(Class3))+1:end), 1:5);

% On concatène les tableaux (XT = test, XA = apprentissage)
XT=[Class1Test ; Class2Test ; Class3Test];
XA=[Class1Apprentissage ; Class2Apprentissage ; Class3Apprentissage];

% Puis on sauvegarde les séries
save 'irisApprentissage.mat' XA;
save 'irisTest.mat' XT;

