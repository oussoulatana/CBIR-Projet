function [Precision,Rappel, pc, rc] = evalir(rr, nsubs, TopN)
%
% EVALIR Evalue la performance du CBIR
%
% Input:
%	rr:	classement des TopN images pertinentes retournées, 
%          une colonne par requête
%    nsubs : nombre d’images par classe ou vérité terrain
%    TopN :  nombre d’images retournées par la recherche
%
%
% Output:
%	Precision:	Précision moyenne de toutes les recherches 
%	Rappel:	Rappel moyen de toutes les recherches
%	pc:	Précision moyenne pour chaque classe de texture
%	rc:	Rappel moyen pour chaque classe de texture
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                 


rr = rr(1:TopN,:); % Le nombre de résultats retournés est limité à TopN
nimages = size(rr,2); % Nombre total de requêtes 
tp = zeros(1, nimages); % initialisation

%--------------------------------------------

for q = 1:nimages       % pour chaque requête 
    cl = floor((q-1)/nsubs)+1;  % trouver la classe de la requête

    %nombre d’images de la même classe cl que la requête (true positives)
    tp(q) = length(find(rr(:, q)<=nsubs*cl & rr(:, q)>nsubs*(cl-1)));
    
end


  Precision = mean(tp) / TopN * 100; % Précision moyenne 
  Rappel    = mean(tp) / nsubs * 100; % Rappel moyen 
  %-----------------------------------------------
  % Précision et rappel moyens pour chaque classe (pc et rc)
  
     t = reshape(tp, nsubs, floor(nimages/nsubs)); 
     pc = mean(t) / TopN * 100; 
     rc = mean(t) / nsubs * 100; 
  
    
end