imageNames = dir('morph_avg/*.jpg');
imageNames = {imageNames.name}';


for u=1:length(imageNames)
     img = imread(fullfile('morph_avg',imageNames{u}));
     imwrite(img,['morph_avg/' 'lala' int2str(61-u) '.jpg']);
    % end
 end