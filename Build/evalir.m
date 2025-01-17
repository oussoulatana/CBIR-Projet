function [Precision,Rappel, pc, rc] = evalir(rr, nsubs, TopN)
%
% EVALIR Evalue la performance du CBIR
%
% Input:
%	rr:	classement des TopN images pertinentes retourn�es, 
%          une colonne par requ�te
%    nsubs�: nombre d�images par classe ou v�rit� terrain
%    TopN :  nombre d�images retourn�es par la recherche
%
%
% Output:
%	Precision:	Pr�cision moyenne de toutes les recherches 
%	Rappel:	Rappel moyen de toutes les recherches
%	pc:	Pr�cision moyenne pour chaque classe de texture
%	rc:	Rappel moyen pour chaque classe de texture
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                 


rr = rr(1:TopN,:); % Le nombre de r�sultats retourn�s est limit� � TopN
nimages = size(rr,2); % Nombre total de requ�tes 
tp = zeros(1, nimages); % initialisation

%--------------------------------------------

for q = 1:nimages       % pour chaque requ�te 
    cl = floor((q-1)/nsubs)+1;  % trouver la classe de la requ�te

    %nombre d�images de la m�me classe cl que la requ�te (true positives)
    tp(q) = length(find(rr(:, q)<=nsubs*cl & rr(:, q)>nsubs*(cl-1)));
    
end


  Precision = mean(tp) / TopN * 100; % Pr�cision moyenne 
  Rappel    = mean(tp) / nsubs * 100; % Rappel moyen 
  %-----------------------------------------------
  % Pr�cision et rappel moyens pour chaque classe (pc et rc)
  
     t = reshape(tp, nsubs, floor(nimages/nsubs)); 
     pc = mean(t) / TopN * 100; 
     rc = mean(t) / nsubs * 100; 
  
    
end