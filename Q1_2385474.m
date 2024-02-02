clear all; clc;

%here, I used "imread" function to read Image1
Image1=imread("Image1.png");
figure;
subplot(1,2,1);
imshow(Image1);title("Image1.png");

%I used "imhist" function to see the histogram of Image1.png
subplot(1,2,2);
imhist(Image1);title("Image1.png Histogram");

%I created another figure to show Image1Output.png and its histogram.
figure;
subplot(1,2,1);
%I used "histeq" function to enhance my Image1.png
Image1Output=histeq(Image1);
imshow(Image1Output);title("Image1Output.png");

%I used "imwrite" function to save my output of Image1.png
imwrite(Image1Output,"Image1Output.png");

%I used "imhist" function to see the histogram of Image1Output.png
subplot(1,2,2);
imhist(Image1Output);title("Image1Output.png Histogram");


