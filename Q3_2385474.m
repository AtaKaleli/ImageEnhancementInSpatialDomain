clear all; clc;

Image3=imread("Image3.png");
figure;
subplot(1,2,1);
imshow(Image3);title("Image3.png");

Image3=im2double(Image3);%converting image to double for convolution operations

rowFilter=3;%row of min filter
columnFilter=3;%column of min filter

imgRow=size(Image3,1);%finding size of row and column of image3.png
imgColumn=size(Image3,2);

paddedImage3=padarray(Image3,[1 1],0,"both");%doing zero padding for min filtering operation
Image3Output=zeros(imgRow,imgColumn);%creating an empty array that will hold final result

%In this algorithm, I used min filtering.Because as we have lots of small
%brigth starts in the image, bu using min filter, I made these small stars
%darker,as these stars neighboorhood pixels are mainly dark.But when the
%things come to biggest bright star, as its neighboorhoods are not dark,I
%can detect it after using min filter and a thresholding process
for i=1:imgRow
    for j=1:imgColumn
        temp=zeros(1,9);%I created a temporary array that has size of 1x9
        for k=1:rowFilter%My plan is after traversing the image by a size of 3x3, I put the values into my temp 1x9 array
            for l=1:columnFilter
               temp(3*k+l-3)=paddedImage3(i+k-1,j+l-1);%here, I put 3x3 part of my image into 1x9 temp array
            end
        end
        temp=sort(temp,"ascend");%after putting pixels into array, I sort them in an ascending order, so the first element is the min value.Then move 3x3 filter by one
        Image3Output(i,j)=temp(1);%after finding the pixel that has min value, I plugged this value into my result array
    end
end

row=size(Image3Output,1);
column=size(Image3Output,2);
thrsVal=0.25;%this is the threshold value that I decided to assign.

for i=1:row%here, I made pixels that has lower value than threshol value to black, so that brighest star can be visible
    for j=1:column
        if(Image3Output(i,j)<thrsVal)
            Image3Output(i,j)=0;
        end
    end
end

subplot(1,2,2);
imshow(Image3Output);title("Image3Output.png");


















