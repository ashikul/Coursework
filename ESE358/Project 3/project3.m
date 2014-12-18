%{
@Ashikul Alam
11/8/2014

ESE 358 Computer Vision
ECE, Stony Brook University
Prof. Murali Subbarao

Project  4: Stereo Matching
 

%}

%{
TODO:

input object.txt
input R image
input L image








%}


O = imread ('FaceObj.txt');
Left = imread ('FaceL.jpg');
Right = imread ('FaceR.jpg');

M = size(Right,1);%columns
N = size(Right,2);%rows




%{
I = imread ('mountain1-gray.jpg'); % input image
%I = imread ('ny1g1.jpg'); % input image
I= rgb2gray(I); % input image to grayscale

M = size(I,1);%columns
N = size(I,2);%rows



%%
%Part 1

%create histogram of image
H = imhist(I);

%create discrete probabilities for brightness
P = zeros(256,1);
for k = 1:256;
    P(k) = H(k)/(M*N);
end

%create cumulative distribution function
C = zeros(256,1);
sum = 0;
for k = 1:256;
    sum = sum + P(k);
    C(k) = sum;
end

%final image intenstiy transformation
J = zeros(M,N);
for i = 1 : M-1;
    for j = 1 : N-1;
        J(i,j)=256*C((I(i,j)+1));
    end
end

J = mat2gray(J);
imwrite(J,'mountain1-gray_hist_equalized.jpg');

%%
%Part 2

P = I; %grayscale image

%outer 2 pixels borders to 0
P([1, end], :) = 0;
P(:, [1, end]) = 0;
P([2, end-1], :) = 0;
P(:, [2, end-1]) = 0;

P = double(P);
Q = zeros(M,N);

%apply filter1 from text to input image
F = dlmread('filter1.txt');
for i = 3 : M-3;
    for j = 3 : N-3;
        %filters are known to be 5x5
        t = 0;
        for a = 1 : 5;
            for b = 1 : 5;
                itemp = i -(a - 3);
                jtemp = j -(b - 3);
                temp =  F(a,b) * P(itemp,jtemp);
                t = t+temp;
            end
        end
        Q(i,j) = t;
        
    end
end
imwrite(Q,'mountain1-gray_filter1.jpg');

%apply filter2 from text to input image
F = dlmread('filter2.txt');
for i = 3 : M-3;
    for j = 3 : N-3;
        %filter 5x5
        t = 0;
        for a = 1 : 5;
            for b = 1 : 5;
                itemp = i -(a - 3);
                jtemp = j -(b - 3);
                temp =  F(a,b) * P(itemp,jtemp);
                t = t+temp;
            end
        end
        Q(i,j) = t;
        
    end
end
Q = mat2gray(Q);
imwrite(Q,'mountain1-gray_filter2.jpg');

%}
%%
%Part 3

Sigma = 1.0;
Threshold = 50;
G = zeros(1,9);
Sum = 0;

%Generate a 1x9 Gaussian filter
for j = 1 : 9;
    G(1,j) = exp(-1*((j-5)^2)/(2*Sigma^2));
    Sum = Sum + G(1,j);
end

%Normalize Gaussian filter
for j = 1 : 9;
    G(1,j) = G(1,j)/Sum;
end

%apply filter to image
F = zeros(M,N);
for i = 5 : M-5;
    for j = 5 : N-5;
        temp = 0;
        temp2 = 0;
        for a = 1 : 9;
            for b = 1 : 9;
                itemp = i -(a - 5);
                jtemp = j -(b - 5);
                temp =  temp + G(1,b) * I(itemp,jtemp);
            end
            temp2 =  temp2 + temp * G(1,a);
            temp = 0;
        end
        F(i,j) = temp2;
        temp2 = 0;
    end
end

E= zeros(M,N);

%compute gradient mag
for i = 5 : M-5;
    for j = 5 : N-5;
        a=F(i,j);
        b=F(i+1,j)- a;
        c=F(i,j+1)- a;
        h = sqrt((b)^2 + (c)^2);
        if ( h >= Threshold)
            E(i,j) = 1;
        end
    end
end

imwrite(E,'mountain1-gray_1.0_threshold_50.jpg');
%}
