%{
@Ashikul Alam
11/24/2014

ESE 358 Computer Vision
ECE, Stony Brook University
Prof. Murali Subbarao

Project  4: Stereo Matching

Obtain 3D depth from two images
using stereo matching.

Two sets of sample images provided, which
are the face and toy files.

%}

%For Face files
O = dlmread ('FaceObj.txt');
Left = imread ('FaceL.jpg');
Right = imread ('FaceR.jpg');
base = 0.065;
focal = 11.35;
p = 0.00001104;
offset = 287;

%For Toy files
% O = dlmread ('ToyObj.txt');
% Left = imread ('ToyL.jpg');
% Right = imread ('ToyR.jpg');
% base = 0.076;
% focal = 19.35;
% p = 0.00001104;
% offset = 0;

temp = 0;

%image size
M = size(Right,1);%columns
N = size(Right,2);%rows

%object size
I = size(O,1);%columns
J = size(O,2);%rows

SSD = zeros(N-8,1);
Z = zeros(I,J);

%	      //main loop
for i = 1 : I; 
    for j = 1 : J; 
        if ( O(i,j)== 1)
         
   
%             //convert to image coordinates
               io = 8 * (i-1) + 1;
               jo = 8 * (j-1) + 1;

%             //horizontal loop to build a range of SSDs
                for k = 1 : N-8;
                    sum = double(0);
                    for a = 0 : 7; %7
                        for b = 0 : 7;
                            temp = double((Right(io+a,jo+b)- Left(io+a,k+b))^2);
                            sum = sum + temp;                         
                        end
                    end
                    SSD(k) = sum;
                end

%             //find min SSD
              [minSSD, minSSDindex] = min(SSD);

%             //calculate disparity
              d = minSSDindex - jo + offset;
              
%             //calculate Z, depth
              Z(i,j) = (base*focal)/(d*p);
                      
        end     
    end
end

%dlmwrite('xface-output.txt', Z, 'precision', '%.2f', 'newline', 'pc','delimiter',' ')
%dlmwrite('xtoy-output.txt', Z, 'precision', '%.2f', 'newline', 'pc','delimiter',' ')


surf(Z);

