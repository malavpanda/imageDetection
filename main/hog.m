function ohist = hog(I)
%
% compute orientation histograms over 8x8 blocks of pixels
% orientations are binned into 9 possible bins
%
% I : grayscale image of dimension HxW
% ohist : orinetation histograms for each block. ohist is of dimension (H/8)x(W/8)x9
%

[h,w] = size(I); %size of the input
h2 = ceil(h/8); %the size of the output
w2 = ceil(w/8);
nori = 9;       %number of orientation bins

[mag,ori] = mygradient(I);
thresh = 0.1*max(mag(:));  %threshold for edges


% separate out pixels into orientation channels
ohist = zeros(h2,w2,nori);
or_int = -90;
for i = 1:nori
  % create a binary image containing 1's for the pixels that are edges at this orientation
  B = zeros(h,w);
  
  ind = find(mag>thresh & (or_int + 20)>ori & ori> or_int);
  B(ind) = 1;
  or_int = or_int + 20;

  % sum up the values over 8x8 pixel blocks.
  chblock = im2col(B,[8 8],'distinct');  %useful function for grabbing blocks
                                         %sum over each block and store result in ohist
  one_count = zeros(1,size(chblock,2));
  for j = 1:size(chblock,2)
      one_count(1,j) = sum(chblock(:,j));
  end
  a_count = reshape(one_count,h2,w2);
  ohist(:,:,i) = a_count;       %how many edges of orientation i             
end

 s = zeros(h2,w2);
 for i = 1:nori
     s = s + ohist(:,:,i);
 end
 
 ohist = ohist ./ (s + (s==0));
% normalize the histogram so that sum over orientation bins is 1 for each block
%   NOTE: Don't divide by 0! If there are no edges in a block (ie. this counts sums to 0 for the block) then just leave all the values 0. 



