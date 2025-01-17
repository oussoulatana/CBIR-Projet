function b = sbcoef2(A,H,V,D,n)
% SBCOEF2 Extract 2-D subband coefficients
%	B = SBCOEF2(A,H,V,D, N)
%
% Input:
%	[A,H,V,D, N]:	wavelet decomposition structure (see WAVEDEC2)
%	N:	subband number, 0 for approximation, 
%		1 for H(K), 2 for V(K), 3 for D(K), 4 for H(K-1), ...
%		where K is number of wavelet decomposition levels
%
% Output:
%	B:	subband coefficents (in a vector)

switch n
    case 1
        b=A(:,:,3);
    case 2
        b=H(:,:,3);
    case 3
        b=V(:,:,3);

    case 4
        b=D(:,:,3);
    case 5
        b=H(:,:,2);
    case 6
        b=V(:,:,2);
    case 7
        b=D(:,:,2);
    case 8
        b=H(:,:,1);
    case 9
        b=V(:,:,1);
    case 10
        b=D(:,:,1);
    otherwise
        disp('veuillez entrer une valeur numerique entre 1 et 10')
end