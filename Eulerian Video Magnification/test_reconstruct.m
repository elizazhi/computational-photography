
files= dir('face_images/*.jpg');
n = size(files,1);

for p = 1 : 6
  sz = size(lpyr{p});
  for c = 1:3
pyr{p}(:,:,c,:) = reshape(T{p}(:,:,c), [sz(1:2) n]);
  end
end

 if ~exist('face_namp', 'dir')
   mkdir('face_namp');
 end

for i = 1:n
for p =1:6
    lpyr{p} = pyr{p}(:,:,:,i);
end
newI = reconstruct(lpyr);
imwrite(newI,['face_namp/' int2str(i) '.jpg']);
end

imageNames = dir('face_namp/*.jpg');
imageNames = {imageNames.name}';

outputVideo = VideoWriter('face_namp.mp4');
outputVideo.FrameRate = 30;
open(outputVideo);

for ii = 1:length(imageNames)
   img = imread(fullfile('face_namp',imageNames{ii}));
   writeVideo(outputVideo,img);
end

close(outputVideo);

% 
% freq = 0:Fs/length(y):Fs/2;
% xdft = fft(x);
% ydft = fft(y);
% plot(freq,10*log10(abs(xdft(1:length(x)/2+1))));
% hold on;
% plot(freq,10*log10(abs(ydft(1:length(y)/2+1))),'r','linewidth',2);
% grid on;
% legend('Original Signal','Bandpass Signal');
% xlabel('Frequency (Hz)');
% ylabel('Power/Frequency (dB/Hz)');
% 
% 
% N = length(x);
% xdft = fft(x);
% xdft = xdft(1:N/2+1);
% psdx = (1/(Fs*N)) * abs(xdft).^2;
% psdx(2:end-1) = 2*psdx(2:end-1);
% freq = 0:Fs/length(x):Fs/2;
% plot(freq,10*log10(psdx))
% grid on
% title('Periodogram Using FFT')
% xlabel('Frequency (Hz)')
% ylabel('Power/Frequency (dB/Hz)')
% 
% Fs = 30;
% t = 0:1/Fs:1-1/Fs;
% %x = T{1}(1,:,1);
% n = length(y);
% ydft = fft(y);
% 
% if(mod(n,2)==0)
%     ydft = ydft(1:n/2+1);
% else
%     ydft = ydft(1:(n+1)/2);
% end
% amydft = 2 * ydft;

%plot(freq,10*log10(psdx))

