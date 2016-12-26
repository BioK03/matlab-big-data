function [confusion] = evaluation(V1, V2, nbclasses)

    confusion(1:nbclasses,1:nbclasses) = 0; % Initialisation d'une matrice 3-3 avec des 0 (on aurait pu utiliser zeros() )
    if length(V1) ~= length(V2) % Erreur : longueur diff�rente
       return;
    end

    for k=1:length(V1) % Pour chaque tuple
        % On incr�mente la cellule appropri�e
        confusion(str2num(V2(k)), V1(k)) = confusion(str2num(V2(k)), V1(k))+1;
    end
    disp('*** Matrice de confusion ***');
    disp(confusion);
    
    % Pr�cision et Rappel
    for k=1:nbclasses
        precision=confusion(k,k)/sum(confusion(k,:));
        rappel=confusion(k,k)/sum(confusion(:,k));
        
        % Pour chaque classe, on affiche son rappel et sa pr�cision
        disp(strcat('C',num2str(k),' rappel : ',num2str(rappel),' | pr�cision : ',num2str(precision)));
        
    end;
    
    % R�ussite totale
    disp(strcat('R�ussite totale : ',num2str(sum(diag(confusion))/sum(confusion(:)))));
    
end

