Fc1 = 50/60;
Fc2 = 60/60;

files= dir('face_images/*.jpg');
n = size(files,1);

 %%
p = 6;
sz = size(lpyr{p});
T{p} = rgb2ntsc(T{p});
for c = 2:3
tR = T{p}(:,:,c);
x= tR';
m = size(x,1);          % Window length
y = fft(x, m);           % DFT
fs =30;
f = (0:n-1)*(fs/m);     % Frequency range

% suppress all other signals
y(f <= Fc1 | f>= Fc2, :) =0;
y(m/2+1.5:end, :) = flipud(y(1:m/2-0.5, :));
xprime = ifft(y, m);
tyR = xprime';

%% Amplify
%tyRm = max(tyR, 2);
tyR = 100 * tyR;

T{p}(:,:,c) = 0.5* tyR + 0.5* T{p}(:,:,c);

pyr{p}(:,:,c,:) = reshape(T{p}(:,:,c), [sz(1:2) n]);
end

if ~exist('face_amp', 'dir')
  mkdir('face_amp');
end

for i = 1:n
    lpyr{p} = ntsc2rgb(pyr{p}(:,:,:,i));
    lpyr{1} = pyr{1}(:,:,:,i);
    lpyr{4} = pyr{4}(:,:,:,i);
    lpyr{5} = pyr{5}(:,:,:,i);
    lpyr{2} = pyr{2}(:,:,:,i);
    lpyr{3} = pyr{3}(:,:,:,i);
newI = reconstruct(lpyr);
imwrite(newI,['face_amp/' int2str(i) '.jpg']);
end
%%

