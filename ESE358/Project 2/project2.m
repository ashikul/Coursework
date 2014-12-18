%{
@Ashikul Alam
09/19/2014

ESE 358 Computer Vision
ECE, Stony Brook University
Prof. Murali Subbarao

Project  2: Binary Image Analysis

    Two binary image files 'pic1bin.tif' and 'pic2bin.tif' are given.
This program uses a sequential labeling algorithm to label all
4-connected components with unique labels. Then, for each 4-connected
component,the following features are computed:
    -area,
    -position
    -perimeter
    -orientation (rho, theta)
    -maximum second central moment
    -minimum second central moment
    -elongation.

%}

B = imread('pic2bin.tif'); %binary image
f = zeros(1,50); %labeling array
M = 60; %columns
N = 80; %rows
L = 2; %first label to use
numLabels = 0; %store number of unique labels
theLabels = zeros(1,numLabels); %store the unique labels

%Binary image B, change 255 to 1
for i = 2 : M-1;
    for j = 2 : N-1;
        if(B(i,j)==255)
            B(i,j)=1;
        end
    end
end

%Sequential Labeling - First Pass
for i = 2 : M-1;
    for j = 2 : N-1;
        if(B(i,j)==1)
            a = B(i,j);
            b = B(i, j-1);
            c = B(i-1,j);
            
            if ((b==0) && (c==0))
                B(i,j) = L;
                L = L + 1;
            elseif(( b==0)&&(c>1))
                B(i,j) = c;
            elseif(( b>1)&&(c==0))
                B(i,j) = b;
            elseif(( b>1)&&(c>1))
                if(b==c)
                    B(i,j) = b;
                else
                    while(f(b)>0)
                        b=f(b);
                    end
                    while(f(c)>0)
                        c=f(c);
                    end
                    if(b==c)
                        B(i,j) = b;
                    elseif (b<c)
                        B(i,j) = b;
                        f(c) = b;
                    else
                        B(i,j) = c;
                        f(b)= c;
                    end
                end
            end
        end
    end
end

%Labeling Connecting - Second Pass
for i = 1 : M;
    for j = 1 : N;
        if(B(i,j)>0)
            k = B(i,j);
            while (f(k)>0)
                k = f(k);
            end
            B(i,j)=k;
            if ~any(k==theLabels)
                numLabels = numLabels+1;
                theLabels(1,numLabels) = k;
            end
        end
    end
end

%Arrays to store calculations
Area = zeros(1,numLabels);
Perimeter = zeros(1,numLabels);
xbar = zeros(1,numLabels);
ybar = zeros(1,numLabels);
moment_a = zeros(1,numLabels);
moment_b = zeros(1,numLabels);
moment_c = zeros(1,numLabels);
theta = zeros(1,numLabels);
ro = zeros(1,numLabels);
xmax = zeros(1,numLabels);
xmin = zeros(1,numLabels);
elongation = zeros(1,numLabels);

%find Area
for k = 1:numLabels;
    for i = 2 : M-1;
        for j = 2 : N-1;
            if(B(i,j)==theLabels(1,k))
                Area(1,k) = Area(1,k) +1;
            end
        end
    end
end

%generate Perimeter matrix C
C = zeros(M,N);
for k = 1:numLabels;
    label = theLabels(1,k);
    %Boundary-Following Algorithm
    %Find the starting pixel
    flag = false;
    for i = 2 : M-1;
        if(flag ==true)
            break;
        end
        for j = 2 : N-1;
            if(flag == true)
                break;
            end
            if(B(i,j)==label)
                C(i,j)=label;
                si = i; %starting pixel x
                sj = j; %starting pixel y
                ci = i; %current pixel x
                cj = j; %current pixel y
                n=1;
                flag = true;
                
            end
        end
    end
    
    %boundary loop
    bloop = true;
    while(bloop)
        findb = false;
        while(~findb)
            
            n = n + 1;
            if n == 9
                n =1;
            end
            
            ni=ci;
            nj=cj;
            bi=ni;
            bj=nj;
            switch (n)
                case 1
                    ni = ci;
                    nj = cj-1;
                    
                case 2
                    ni = ci - 1;
                    nj = cj - 1;
                    
                case 3
                    ni = ci-1;
                    nj = cj;
                    
                case 4
                    ni = ci - 1;
                    nj = cj + 1;
                    
                case 5
                    ni = ci;
                    nj = cj+1;
                    
                case 6
                    ni = ci + 1;
                    nj = cj + 1;
                    
                case 7
                    ni = ci+1;
                    nj = cj;
                    
                case 8
                    ni = ci + 1;
                    nj = cj - 1;
                    
            end
            
            if B(ni,nj) == label
                findb = true;
                %new center
                ci = ni;
                cj = nj;
                %label boundary
                C(ci,cj) = label;
                %figure out new n c relation to b
                di = bi - ci;
                dj = bj - cj;
                
                if ((di==0)&&(dj==-1))
                    n=1;
                elseif ((di==-1)&&(dj==-1))
                    n=2;
                elseif ((di==-1)&&(dj==0))
                    n=3;
                elseif ((di==-1)&&(dj==1))
                    n=4;
                elseif ((di==0)&&(dj==1))
                    n=5;
                elseif ((di==1)&&(dj==1))
                    n=6;
                elseif ((di==1)&&(dj==0))
                    n=7;
                elseif ((di==1)&&(dj==-1))
                    n=8;
                end
                
            end
            
        end
        if ((ci == si)&&(cj == sj))
            bloop = false;
        end
    end
end

%calculate Perimeter
for k = 1:numLabels;
    for i = 2 : M-1;
        for j = 2 : N-1;
            if(C(i,j)==theLabels(1,k))
                Perimeter(1,k) = Perimeter(1,k) +1;
            end
        end
    end
end

%calculate Position
for k = 1:numLabels;
    for i = 2 : M-1;
        for j = 2 : N-1;
            if(B(i,j)==theLabels(1,k))
                xbar(1,k) = xbar(1,k) +j;
                ybar(1,k) = ybar(1,k) +i;
            end
        end
    end
end
for k = 1:numLabels;
    xbar(1,k) = xbar(1,k)/Area(1,k);
    ybar(1,k) = (-1)*ybar(1,k)/Area(1,k);
end

%Calculate a, b, and c second order moments
for k = 1:numLabels;
    for i = 2 : M-1;
        for j = 2 : N-1;
            if(B(i,j)==theLabels(1,k))
                xI =(j-((M-1)/2));
                yI =-1*(i -((N-1)/2));
                moment_a(1,k) = moment_a(1,k) + ((xI-xbar(1,k))^2);
                moment_b(1,k) = moment_b(1,k) + ((xI-xbar(1,k))*(yI-ybar(1,k)));
                moment_c(1,k) = moment_c(1,k) + ((yI-ybar(1,k))^2);
            end
        end
    end
    moment_b(1,k) = moment_b(1,k)*2;
end

%Calculate theta & ro
for k = 1:numLabels;
    theta(1,k) = (atand(moment_b(1,k)/(moment_a(1,k)-moment_c(1,k)))/2);
    ro(1,k) = xbar(1,k)*cosd(theta(1,k)) + ybar(1,k)*sind(theta(1,k));
end

%Maximum second central moment
for k = 1:numLabels;
    Ax = moment_a(1,k);
    Bx = moment_b(1,k);
    Cx = moment_c(1,k);
    xmax(1,k) = xmax(1,k) + (.5)*(Ax + Cx);
    xmax(1,k) = xmax(1,k) + (.5)*(Ax - Cx)*(1)*((Ax-Cx)/(sqrt(Bx^2 + (Ax-Cx)^2)));
    xmax(1,k) = xmax(1,k) + (.5)*(Bx)*(1)*((Bx)/(sqrt(Bx^2 + (Ax-Cx)^2)));
    xmax(1,k) = sqrt(xmax(1,k));
end

%Minimum second central moment
for k = 1:numLabels;
    Ax = moment_a(1,k);
    Bx = moment_b(1,k);
    Cx = moment_c(1,k);
    xmin(1,k) = xmin(1,k) + (.5)*(Ax + Cx);
    xmin(1,k) = xmin(1,k) + (.5)*(Ax - Cx)*(-1)*((Ax-Cx)/(sqrt(Bx^2 + (Ax-Cx)^2)));
    xmin(1,k) = xmin(1,k) + (.5)*(Bx)*(-1)*((Bx)/(sqrt(Bx^2 + (Ax-Cx)^2)));
    xmin(1,k) = sqrt(xmin(1,k));
end

%Calculated elongation
for k = 1:numLabels;
    elongation(1,k) =(xmax(1,k))/(xmin(1,k));
end

%Final Output
fprintf('There are %d unique components\n',numLabels);

for k = 1:numLabels;
    fprintf('\n');
    fprintf('Component %d\n',k);
    fprintf('\tArea: %d\n',Area(1,k));
    fprintf('\tPerimeter: %d\n',Perimeter(1,k));
    fprintf('\tPosition: %f, %f\n',xbar(1,k),ybar(1,k));
    fprintf('\tTheta: %f\n',theta(1,k));
    fprintf('\tRo: %f\n',ro(1,k));
    fprintf('\tMaximum 2nd moment: %f\n',xmax(1,k));
    fprintf('\tMinimum 2nd moment: %f\n',xmin(1,k));
    fprintf('\tElongation: %f\n',elongation(1,k));
end
imshow(C); %Boundary labeled matrix


