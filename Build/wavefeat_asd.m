function [asd] = wavefeat_asd(file, nlevels,wavelet, useYCbCr)
    % Input:
    %   file: filename of the input texture image.
    %   nlevels: number of wavelet pyramid levels.
    %   useYCbCr: (optional): if true, convert to YCbCr format. Default is false.
    %
    % Output:
    %   asd: feature vector of average and standard deviation of wavelet subbands.
    
    % Lecture de l'image
    im = imread(file);
    
    if useYCbCr
        % Conversion au format YCbCr
        imYCbCr = rgb2ycbcr(im);
    
        % Extraction des trois canaux Y, Cb, Cr
        im1 = double(imYCbCr(:, :, 1));  % Luminance
        im2 = double(imYCbCr(:, :, 2)); % Composante bleue
        im3 = double(imYCbCr(:, :, 3)); % Composante rouge
    else
        % Extraction des trois canaux RGB
        im1 = double(im(:, :, 1)); % Canal rouge
        im2 = double(im(:, :, 2)); % Canal vert
        im3 = double(im(:, :, 3)); % Canal bleu
    end
    
    
    % Extraction des descripteurs pour chaque canal
    stats1 = extract_wavelet_features(im1, nlevels, wavelet);
    stats2 = extract_wavelet_features(im2, nlevels, wavelet);
    stats3 = extract_wavelet_features(im3, nlevels, wavelet);
    
    % Concatenation des descripteurs des trois canaux
    asd = [stats1; stats2; stats3];
    %asd = (asd - mean(asd)) / std(asd); %Normalisation
end

% Fonction pour extraire les descripteurs d'un canal
function stats = extract_wavelet_features(channel, nlevels, wavelet)
    % Input:
    %   channel: une seule composante de l'image (ex. imR, imG, imB).
    %   nlevels: nombre de niveaux de décomposition.
    %
    % Output:
    %   stats: vecteur des descripteurs
    
    %filters = 'Bior2.4';
    [CA, CH, CV, CD] = swt2(channel, nlevels, wavelet);
    nbands = 3*nlevels +1 ; %nbands= 3*3 +1 = 10 sous bandes 
    
    % Initialisation du vecteur des descripteurs
    stats = zeros(nbands * 2, 1); %10 sous bandes et 2 descripteurs par sous bande(moyenne, ecart-type);
    
    for b = 1:nbands
        band = sbcoef2(CA,CH,CV,CD,b);
        a= sum(sum(abs(band)))/(size(band,1)*size(band,2));
        sd= sqrt(sum(sum(abs(band-a).^2))/(size(band,1)*size(band,2)));
        stats(2*b-1:2*b) = [sd,a];
        
    end
end 



