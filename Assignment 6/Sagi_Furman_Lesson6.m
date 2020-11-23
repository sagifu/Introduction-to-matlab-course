%% Ques. 1
puppiesImage = imread('puppies.jpg');
%% Ques. 2
imagesc(puppiesImage);
axis off;
%% Ques. 3
[whiteDogHead, WDPosition] = imcrop(puppiesImage);
close;
[blackDogHead, BDPosition] = imcrop(puppiesImage);
close;

figure(); hold on;
subplot(1,2,1);imagesc(whiteDogHead);
axis off; axis square;
subplot(1,2,2);imagesc(blackDogHead);
axis off; axis square;
%% Ques. 4
imwrite(whiteDogHead, 'WDHead.jpg');
imwrite(blackDogHead, 'BDHead.jpg');
%% Ques. 5
wDHead = fliplr(whiteDogHead);
bDHead = fliplr(blackDogHead);
%% Ques. 6
imagesc(puppiesImage); hold on;
imagesc(WDPosition(1),WDPosition(2),wDHead);
imagesc(BDPosition(1),BDPosition(2),bDHead);
%% Ques. 7
mean5PuppiesImage = pixleReduction(puppiesImage,5);

figure();
subplot(1,2,1); imagesc(puppiesImage);
axis off; axis square; title('original photo','FontSize',13);
subplot(1,2,2); imagesc(mean5PuppiesImage);
axis off; axis square; title('blurred photo','FontSize',13);
%% Ques. 8
mean25PuppiesImage = pixleReduction(puppiesImage,25);

threeColorImage = mean(mean25PuppiesImage,3);

threeColorImage(threeColorImage > 200) = 255;
threeColorImage(threeColorImage < 50) = 0;
threeColorImage(threeColorImage <= 200 & threeColorImage >= 50) = 155;

threeColorImage = uint8(threeColorImage);

imagesc(threeColorImage);
axis off;
title(['{\color{red}The ','\color{magenta}Image}'],'FontSize',14);