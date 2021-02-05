T = cell(6,1);

 p = 6;
    sz = size(lpyr{p});
    T{p} = zeros([prod(sz(1:2)) N 3]);
    T{p}(:,:,1) = reshape(pyr{p}(:,:,1,:), [prod(sz(1:2)) N]);
    T{p}(:,:,2) = reshape(pyr{p}(:,:,2,:), [prod(sz(1:2)) N]);
    T{p}(:,:,3) = reshape(pyr{p}(:,:,3,:), [prod(sz(1:2)) N]);

% make the bandpass filterFs = 30;
% Fs=30;
% N = 30;
Fc1 = 65/60;
Fc2 = 95/60;
% Hd = butterworthBandpassFilter(Fs, N, Fc1, Fc2);

files= dir('xiaowei_images/*.jpg');
n = size(files,1);

 %%
p = 6;
sz = size(lpyr{p});
T{p} = rgb2ntsc(T{p});
%%
for c = 2:3
tR = T{p}(:,:,c);
x= tR';
m = size(x,1);          % Window length
% N = pow2(nextpow2(m));  % Transform length
y = fft(x, m);           % DFT
fs =25;
f = (0:n-1)*(fs/m);     % Frequency range

% suppress all other signals
y(f <= Fc1 | f>= Fc2, :) =0;
y(m/2+1:end, :) = flipud(y(1:m/2, :));
xprime = ifft(y, m);
tyR = xprime';

% Amplify
%tyRm = max(tyR, 2);
tyR = 150 * tyR;

T{p}(:,:,c) = 0.5* tyR + 0.5* T{p}(:,:,c);

pyr{p}(:,:,c,:) = reshape(T{p}(:,:,c), [sz(1:2) n]);
end
%%

if ~exist('xiaowei_amp', 'dir')
  mkdir('xiaowei_amp');
end

for i = 1:n
    lpyr{p} = ntsc2rgb(pyr{p}(:,:,:,i));
    lpyr{1} = pyr{1}(:,:,:,i);
    lpyr{4} = pyr{4}(:,:,:,i);
    lpyr{5} = pyr{5}(:,:,:,i);
    lpyr{2} = pyr{2}(:,:,:,i);
    lpyr{3} = pyr{3}(:,:,:,i);
newI = reconstruct(lpyr);
imwrite(newI,['xiaowei_amp/' int2str(i) '.jpg']);
end
%%

