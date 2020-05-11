%% 
 imds1 = imageDatastore('rabbit');
 figure,imshow(imds1.readimage(1))
 imds2 = transform(imds1,@(x)imgaussfilt(x,8));
 figure,imshow(imds2.preview)
 %%
 augmenter = imageDataAugmenter('RandRotation',[0 90],'RandXReflection',true)
 %%
 patchds = randomPatchExtractionDatastore(imds1,imds2,[500 500], ...
    'DataAugmentation',augmenter)
%%
minibatch = preview(patchds);
inputs = minibatch.InputImage;
responses = minibatch.ResponseImage;
test = cat(2,inputs,responses);
montage(test','Size',[8 2])
title('Inputs (Left) and Responses (Right)')