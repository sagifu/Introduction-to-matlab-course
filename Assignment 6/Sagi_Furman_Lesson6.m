%% Ques. 1
% load picture
puppiesImage = imread('puppies.jpg');
%% Ques. 2
% display picture without axis values
imagesc(puppiesImage);
axis off;
title('original photo','FontSize',13);
%% Ques. 3
% rectangle coordinates chosen using the image itself
% rectangle coordinates [X Y Width Height]
WDHeadPosition = [190 35 220 175];
BDHeadPosition = [410 70 185 170];
% using imcrop function, crop original picture according to the rectangle 
% values
whiteDogHead = imcrop(puppiesImage,WDHeadPosition);
blackDogHead = imcrop(puppiesImage,BDHeadPosition);

% plot
% the axis of each picture will be with no values, and be displayed in a
% square shape
figure(); hold on;
subplot(1,2,1);imagesc(whiteDogHead);
axis off; axis square; title('white dog head','FontSize',13);
subplot(1,2,2);imagesc(blackDogHead);
axis off; axis square; title('black dog head','FontSize',13);
%% Ques. 4
% save head pictures using imwrite. inputs: the picture, filename
imwrite(whiteDogHead, 'WDHead.jpg');
imwrite(blackDogHead, 'BDHead.jpg');
%% Ques. 5
wDHead = fliplr(whiteDogHead);
bDHead = fliplr(blackDogHead);
%% Ques. 6
figure();
imagesc(puppiesImage); hold on;
% using the X & Y values of the head position, we add the flipped head
% pictures on the original picture' in the same location of the original
% heads
imagesc(WDHeadPosition(1),WDHeadPosition(2),wDHead);
imagesc(BDHeadPosition(1),BDHeadPosition(2),bDHead);
title('reverse heads','FontSize',13);
%% Ques. 7
% reduce pixle rate with self-written function
mean5PuppiesImage = pixleReduction(puppiesImage,5);

figure();
subplot(1,2,1); imagesc(puppiesImage);
axis off; axis square; title('original photo','FontSize',13);
subplot(1,2,2); imagesc(mean5PuppiesImage);
axis off; axis square; title('blurred photo - 5 pixle reduction','FontSize',13);
%% Ques. 8
% reduce pixle rate with self-written function
mean25PuppiesImage = pixleReduction(puppiesImage,25);
% calculate the sum across 3rd dimension
threeColorImage = sum(mean25PuppiesImage,3);
% create three values image using boolean criteria
% order is important! the first line MUST come before the other two
threeColorImage(threeColorImage <= 600 & threeColorImage >= 150) = 155;
threeColorImage(threeColorImage > 600) = 255;
threeColorImage(threeColorImage < 150) = 0;

% plot
figure();
imagesc(threeColorImage);
colormap gray
axis off;
title(['{\color{red}The ','\color{magenta}Image}'],'FontSize',14);