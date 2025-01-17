function rr = ranked(fs, TopN, normflag, normorder)
%
% RANKED classe/ordonne les images par ordre de pertinence en utilisant
%        une distance Euclidienne ou une autre distance 
%
% Input:
%	fs:	vecteurs descripteurs, une colonne par image
%	TopN:	(optionnel), nombre d’images à récupérer (16 par défaut)
%	normflag: (optionnel), indique la méthode de normalisation
%               des vecteurs descripteurs
%			1 utilise l’écart type (par défaut)
%			2 utilise l’écart type à partir de la médiane
%			3 utilise des poids de 1 (aucune pondération)
%	normorder: (optionnel), indique la norme ou métrique
%                pour le calcul des distances :
%                1 pour L1-norm, 2 for L2-norm (2 par défault)
%
% Output:
%	rr:	Matrice de classement (ranked matrix) des images retournées, 
%          une colonne = résultat d’une requête
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if nargin < 2
    TopN = 16;   % valeur par défaut
 end

 if nargin < 3
    normflag = 1; % valeur par défaut
 end

 if nargin < 4
    normorder = 2; % valeur par défaut
 end

 % Extraire le nombre de descripteurs et leur taille
 [nf, nimages] = size(fs);


 % ---------------------------------------- %
 % Normalisation: calcul des poids w  

 switch normflag
    case 1
	% Méthode 1: utilise l’écart type (standard deviation)
	w = std(fs, 1, 2);
    case 2
	% Méthode 2: utilise l’écart type à partir de la médiane
	m = median(fs, 2);
	w = sum(abs(fs - m(:, ones(1, nimages))), 2) / nimages;
    otherwise
	% Aucune pondération (tous les poids sont à 1)
	w = ones(nf, 1);
 end

 % Normalisation des vecteurs descripteurs
 fs = fs ./ w(:, ones(1, nimages)); 

 % Initialisation
 rr = zeros(TopN, nimages); % rr : résultats retournés


  
 for q = 1:nimages			% Pour chaque requête	q		
    % Calculer la distance entre la requête q et chaque image
    % de la base de données

    Dq = fs(:, q);                % Dq: descripteur de la requête q

    switch normorder
	case 1
	    % Norme L1
	    d = sum(abs(fs - Dq), 1);
	case 2
	    % Norme L2 (Euclidienne) 
	    d = sum((fs - Dq) .^2, 1);
	
      end
    
    % Tri des distances par ordre croissant;
    [sd, si] = sort(d);

        
    % Sélection des TopN images pertinentes pour la requête q
    rr(:, q) = si(1:TopN);  % si : no d’images

 end

end 