imageNames = dir('morph1/morph*.jpg');
imageNames = {imageNames.name}';


for u=16:length(imageNames)
     img = imread(fullfile('morph1',imageNames{u}));
     movefile(['morph1/', imageNames{u}],['morph1/morph',int2str(u),'.jpg']);
     %imwrite(img,['morph_1/' 'morph' int2str(61-u) '.jpg']);
    % end
 end