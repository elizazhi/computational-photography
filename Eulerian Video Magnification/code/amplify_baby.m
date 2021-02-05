T = cell(6,1);

 p = 6;
    sz = size(lpyr{p});
    T{p} = zeros([prod(sz(1:2)) N 3]);
    T{p}(:,:,1) = reshape(pyr{p}(:,:,1,:), [prod(sz(1:2)) N]);
    T{p}(:,:,2) = reshape(pyr{p}(:,:,2,:), [prod(sz(1:2)) N]);
    T{p}(:,:,3) = reshape(pyr{p}(:,:,3,:), [prod(sz(1:2)) N]);

% the frequency band of interest
Fc1 = 140/60;
Fc2 = 160/60;


files= dir('baby_images/*.jpg');
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
y = fft(x, m);           % DFT
fs =30;
f = (0:n-1)*(fs/m);     % Frequency range

% suppress all other signals
y(f <= Fc1 | f>= Fc2, :) =0;
y(m/2+1:end, :) = flipud(y(1:m/2, :));
xprime = ifft(y, m);
tyR = xprime';

% Amplify
if(c==1)
tyR = 1 * tyR;
T{p}(:,:,c) = 0.5* tyR + 0.5* T{p}(:,:,c);
else
    if(c==2)
        tyR = 500 * tyR;
        T{p}(:,:,c) = 0.5* tyR + 0.5* T{p}(:,:,c);
    else
        tyR = 500 * tyR;
        T{p}(:,:,c) = 0.5* tyR + 0.5* T{p}(:,:,c);
    end
end

pyr{p}(:,:,c,:) = reshape(T{p}(:,:,c), [sz(1:2) n]);
end
%%

if ~exist('baby_amp', 'dir')
  mkdir('baby_amp');
end

for i = 1:n
    lpyr{p} = ntsc2rgb(pyr{p}(:,:,:,i));
    lpyr{1} = pyr{1}(:,:,:,i);
    lpyr{4} = pyr{4}(:,:,:,i);
    lpyr{5} = pyr{5}(:,:,:,i);
    lpyr{2} = pyr{2}(:,:,:,i);
    lpyr{3} = pyr{3}(:,:,:,i);
newI = reconstruct(lpyr);
imwrite(newI,['baby_amp/' int2str(i) '.jpg']);
end

%% 
% the original signal plot
x = T{6}(110,:,1);
 Fs=30;
 N = length(x);
 xdft = fft(x);
 xdft = xdft(1:N/2+1);
 psdx = (1/(Fs*N)) * abs(xdft).^2;
 psdx(2:end-1) = 2*psdx(2:end-1);
 freq = 0:Fs/length(x):Fs/2;
 plot(freq,10*log10(psdx))
 grid on
 title('Periodogram Using FFT')
 xlabel('Frequency (Hz)')
 ylabel('Power/Frequency (dB/Hz)')
% 
%% making the plot of the bandpassed signal
m = length(x);
y = fft(x);           % DFT
f = (0:n-1)*(Fs/m);     % Frequency range
% suppress all other signals
y(f <= Fc1 | f>= Fc2) =0;

y(m/2+1:end) = flipud(y(1:m/2));
y = ifft(y);

xdft = fft(x);
ydft = fft(y);
plot(freq,10*log10(abs(xdft(1:length(x)/2+1))));
hold on;
plot(freq,10*log10(abs(ydft(1:length(y)/2+1))),'r','linewidth',2);
grid on;
legend('Original Signal','Bandpass Signal');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
%%


