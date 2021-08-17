%% Read SQF for B1 mapping ;  FLIP ANGLE = 90 ; 
% TE = 0.219ms ; TR = 150 AVERAGE = 1
% % ACQUISITION TIME = 4m23s ; MATRIX = 24 X 24x 24; RECONSTRUCTED MATRIX = 256X256;  
% % FOV = 50mm 0R 5cm; SLICE THICKNESS 50mm; SPATIAL RESOLUTION =

path ='D:\SODIUM\sodium old data\2018.10.23B1map\13\pdata\2\2dseq';


fileID = fopen(path);
data_SQF = fread(fileID, 'int16');
fclose(fileID);
%% reshape and multiply by slop
data_SQF = reshape(data_SQF,[256 256 24]);
data_SQF = data_SQF*0.0229498900051462;
data_SQF_Slice = (data_SQF(:,:,13));
In = data_SQF_Slice;

% figure
% imagesc(In);
% title ('original image');

h = RobustKessy(In,150);


figure
imagesc(h);
title ('RobustKessy denosing, 90 degrees');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


%% Read SQF for B1 mapping  ;  FLIP ANGLE = 45 ; 
% TE = 0.219ms ; TR = 150 AVERAGE = 1
% % ACQUISITION TIME = 4m23s ; MATRIX = 24 X 24x 24; RECONSTRUCTED MATRIX = 256X256;  
% % FOV = 50mm 0R 5cm; SLICE THICKNESS 50mm; SPATIAL RESOLUTION =

path ='D:\SODIUM\sodium old data\2018.10.23B1map\14\pdata\2\2dseq';

fileID = fopen(path);
data_SQF = fread(fileID, 'int16');
fclose(fileID);
%% reshape and multiply by slop
data_SQF = reshape(data_SQF,[256 256 24]);
data_SQF = data_SQF*0.0169220298547961;
data_SQF_Slice = (data_SQF(:,:,13));
I = data_SQF_Slice;

% figure
% imagesc(In);
% title ('original image');
% axis off

B = RobustKessy(I,150);


figure
imagesc(B);
title ('RobustKessy denosing, 45 degrees');
axis off

% % % % % fleyer et el
% CALCULATING THE ACTUAL FLIP ANGLE

zzz=h./(2*B);
ALPHA =acos(zzz);
% %  in degrees 
% figure,imagesc(abs(ALPHA)*180/pi,[0 100])
% in radians
% figure,imagesc(abs(ALPHA),[0 2])

% title ('ACTUAL FLIP ANGLE');


% % CALCULATING THE CORRECTION FACTOR 

A = ALPHA./45;
C = sin(90*A);

% figure,imagesc(abs(C)*180/pi,[-180 180])

% figure,imagesc(abs(C),[0 2])
% title ('sin(90*A)');

D = ALPHA.*C;

% figure,imagesc(abs(D)*180/pi,[-180 180])
% % figure,imagesc(abs(D),[0 2])
% title (' ALPHA.*C');


% E = inv (D);

E= 1./D;
figure,imagesc(abs(E),[0.5 1]);
title ('B1 CORRECTION FACTOR MAPPING'); 