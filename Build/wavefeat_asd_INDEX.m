function [asd] = wavefeat_asd_INDEX(dirname,nlevels,wavelet, useYCbCr)

% Input:
%   dirname: directory that contains all images, e.g. '../VisTex/sub128'
%   nlevels: number of wavelet pyramid levels.
%   useYCbCr: (optional): if true, convert to YCbCr format. Default is false

% Output:
%   asd: Feature vectors from average and standard deviation.

files=dir(dirname);
% Initialize
asd  = [];

for i=3:size(files,1)
    
[fv] = wavefeat_asd(fullfile(dirname, files(i).name), nlevels,wavelet, useYCbCr);
 asd  = [asd, fv];

end