function [Precision,Recall,pc,rc]=CBIR_Simple(dirname,nlevels,nsubs,TopN,wavelet, useYCbCr)
% Input:
%   dirname: directory that contains all images, e.g. '../VisTex/sub128'
%   nlevels: number of wavelet pyramid levels (default 3)
%   nsubs: Number of sub-images per class. 
%          nsubs=16, default for VisTex Dataset.
%   TopN: TopN retrieved images
%   useYCbCr: (optional): if true, convert to YCbCr format. Default is false.

% Output:
%     rr: Rank relevant images
%	Precision:	overall precision rate
%	Recall:	overall recall rate

%	pc:	average precision rate for each texture class
%	rc:	average recall rate for each texture class

% Définir la valeur par défaut de useYCbCr
if nargin < 6 %nargin = nombre d'argument passés à la fonction
    useYCbCr = false; % Par défaut, traitement en RGB
end

% Wavelet-based feature extraction from ALL images.
[asd] = wavefeat_asd_INDEX(dirname,nlevels,wavelet, useYCbCr);

% Rank relevant images using Euclidean-liked distance
rr = ranked(asd, TopN);

% EVALIR Evaluate Image Retrieval (IR) performance
[Precision, Recall, pc, rc] = evalir(rr, nsubs, TopN);
end