function newI = reconstruct(Lpyramid)
for i = length(Lpyramid):-1:2
	Lpyramid{i-1} = Lpyramid{i-1}+impyramid(Lpyramid{i}, 'expand');
end
newI = Lpyramid{1};
end