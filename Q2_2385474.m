clear all; clc;

%IMAGE ENHANCEMENT PART

Image2=imread("Image2.png");
figure;
subplot(2,2,1);
imshow(Image2);title("Image2.png");

Image2=im2double(Image2);%converting image to double for convolution operations

rowFilter=3;%row of median filter
columnFilter=3;%column of median filter

imgRow=size(Image2,1);%finding size of row and column of image2.png
imgColumn=size(Image2,2);

paddedImage2=padarray(Image2,[1 1],0,"both");%doing zero padding for median filtering operation
Image2Output=zeros(imgRow,imgColumn);%creating an empty array that will hold final result

%In this algorithm, I used median filtering, because it is known as best
%in removing salt and pepper noise
for i=1:imgRow
    for j=1:imgColumn
        temp=zeros(1,9);%I created a temporary array that has size of 1x9
        for k=1:rowFilter%My plan is after traversing the image by a size of 3x3, I put the values into my temp 1x9 array
            for l=1:columnFilter
               temp(3*k+l-3)=paddedImage2(i+k-1,j+l-1);%here, I put 3x3 part of my image into 1x9 temp array
            end
        end
        temp=sort(temp,"ascend");%after putting pixels into array, I sort them in an ascending order, then find the median of it.Then move 3x3 filter by one
        Image2Output(i,j)=median(temp);%after finding the median pixel, I plugged this value into my result array
    end
end

subplot(2,2,2);
imshow(Image2Output);title("Image2.png Output");

%FINDING EDGES PART1 (EDGES OF Image2)

Hx=[-1 -2 -1;0 0 0;1 2 1];%sobel filter that is derivative of X
Hy=[-1 0 1;-2 0 2;-1 0 1];%sobel filter that is derivative of Y

imgRow=size(Image2,1);%finding size of row and column of image2.png
imgColumn=size(Image2,2);

hxRow=size(Hx,1);%finding size of the sobel filters
hxColumn=size(Hx,2);
hyRow=size(Hy,1);
hyColumn=size(Hy,2);

paddedImage2=padarray(Image2,[1 1],0,"both");%doing zero padding to salt and peppered image for convolution operation


%I did not rotate filters by 180 degree as the result won't change
derivativeOfX=zeros([hxRow hxColumn]);%creating an empty array that will hold final result for horizantal edges
derivativeOfY=zeros([hyRow hyColumn]);%creating an empty array that will hold final result for vertical edges

%algorithm that helps me to find horizantal edges(convolution)
for i=1:imgRow
    for j=1:imgColumn
        sum=0;%here,I created a temporary sum value that will hold the multiplication of pixel values
        for k=1:hxRow%the sum value always equal to 0 after 3x3 matrix multiplication ends
            for l=1:hxColumn
               sum=sum+(Hx(k,l)*paddedImage2(i+k-1,j+l-1));%I store the result of multiplication of pixels here
            end
        end
        derivativeOfX(i,j)=sum;%after reaching 3x3 size, I plugged sum value into my result array, then move 3x3 filter by one
    end
end

%algorithm that helps me to find vertical edges(convolution)
for i=1:imgRow
    for j=1:imgColumn
        sum=0;
        for k=1:hyRow
            for l=1:hyColumn
                sum=sum+(Hy(k,l)*paddedImage2(i+k-1,j+l-1));
            end
        end
        derivativeOfY(i,j)=sum;
    end
end

%taking the absolute values of these derivations
derivativeOfX=abs(derivativeOfX);
derivativeOfY=abs(derivativeOfY);
edgeOfImage2=abs(derivativeOfX+derivativeOfY);%sum them up to find the overall edges of the image2.png
subplot(2,2,3);
imshow(edgeOfImage2);title("Image2.png Edges");

%FINDING EDGES PART2 (EDGES OF Image2Output)
paddedImage2Output=padarray(Image2Output,[1 1],0,"both");%doing zero padding to enhanced image for convolution operation


%I did not rotate filters by 180 degree as the result won't change
derivativeOfX=zeros([hxRow hxColumn]);%creating an empty array that will hold final result for horizantal edges
derivativeOfY=zeros([hyRow hyColumn]);%creating an empty array that will hold final result for vertical edges

%algorithm that helps me to find horizantal edges(convolution)
for i=1:imgRow
    for j=1:imgColumn
        sum=0;%here,I created a temporary sum value that will hold the multiplication of pixel values
        for k=1:hxRow%the sum value always equal to 0 after 3x3 matrix multiplication ends
            for l=1:hxColumn
               sum=sum+(Hx(k,l)*paddedImage2Output(i+k-1,j+l-1));%I store the result of multiplication of pixels here
            end
        end
        derivativeOfX(i,j)=sum;%after reaching 3x3 size, I plugged sum value into my result array, then move 3x3 filter by one
    end
end

%algorithm that helps me to find vertical edges(convolution)
for i=1:imgRow
    for j=1:imgColumn
        sum=0;
        for k=1:hyRow
            for l=1:hyColumn
                sum=sum+(Hy(k,l)*paddedImage2Output(i+k-1,j+l-1));
            end
        end
        derivativeOfY(i,j)=sum;
    end
end

%taking the absolute values of these derivations
derivativeOfX=abs(derivativeOfX);
derivativeOfY=abs(derivativeOfY);
edgeOfImage2Output=abs(derivativeOfX+derivativeOfY);%sum them up to find the overall edges of the image2output.png
subplot(2,2,4);
imshow(edgeOfImage2Output);title("Image2.png Output Edges");



