function rr = ranked(fs, TopN, normflag, normorder)
%
% RANKED classe/ordonne les images par ordre de pertinence en utilisant
%        une distance Euclidienne ou une autre distance 
%
% Input:
%	fs:	vecteurs descripteurs, une colonne par image
%	TopN:	(optionnel), nombre d�images � r�cup�rer (16 par d�faut)
%	normflag: (optionnel), indique la m�thode de normalisation
%               des vecteurs descripteurs
%			1 utilise l��cart type (par d�faut)
%			2 utilise l��cart type � partir de la m�diane
%			3 utilise des poids de 1 (aucune pond�ration)
%	normorder: (optionnel), indique la norme ou m�trique
%                pour le calcul des distances :
%                1 pour L1-norm, 2 for L2-norm (2 par d�fault)
%
% Output:
%	rr:	Matrice de classement (ranked matrix) des images retourn�es, 
%          une colonne = r�sultat d�une requ�te
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if nargin < 2
    TopN = 16;   % valeur par d�faut
 end

 if nargin < 3
    normflag = 1; % valeur par d�faut
 end

 if nargin < 4
    normorder = 2; % valeur par d�faut
 end

 % Extraire le nombre de descripteurs et leur taille
 [nf, nimages] = size(fs);


 % ---------------------------------------- %
 % Normalisation: calcul des poids w  

 switch normflag
    case 1
	% M�thode 1: utilise l��cart type (standard deviation)
	w = std(fs, 1, 2);
    case 2
	% M�thode 2: utilise l��cart type � partir de la m�diane
	m = median(fs, 2);
	w = sum(abs(fs - m(:, ones(1, nimages))), 2) / nimages;
    otherwise
	% Aucune pond�ration (tous les poids sont � 1)
	w = ones(nf, 1);
 end

 % Normalisation des vecteurs descripteurs
 fs = fs ./ w(:, ones(1, nimages)); 

 % Initialisation
 rr = zeros(TopN, nimages); % rr�: r�sultats retourn�s


  
 for q = 1:nimages			% Pour chaque requ�te	q		
    % Calculer la distance entre la requ�te q et chaque image
    % de la base de donn�es

    Dq = fs(:, q);                % Dq: descripteur de la requ�te q

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

        
    % S�lection des TopN images pertinentes pour la requ�te q
    rr(:, q) = si(1:TopN);  % si�: no d�images

 end

end 