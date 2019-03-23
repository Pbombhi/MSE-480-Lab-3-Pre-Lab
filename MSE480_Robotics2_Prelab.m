clc
clear all
close all

%Case 1
T_0t = [0  0 1 28.58;
        0 -1 0 0;
        1  0 0 20.8;
        0  0 0 1]

% %Case 2
% T_0t = [1  0  0 15.0;
%         0 -1  0 5.0;
%         0  0 -1 10.0;
%         0  0  0 1];
% 
% %Case 3
% T_0t = [1  0  0 15.0;
%         0 -1  0 5.0;
%         0  0 -1 1.0;
%         0  0  0 1];
% 
% %Case 4
% T_0t = [1  0  0  15.0;
%         0 -1  0 -5.0;
%         0  0 -1  5.0;
%         0  0  0  1];


d1 = 6.193;
L2 = 14.605;
L3 = 18.733;
d5 = 9.843;


n = T_0t(1:3,1);
s = T_0t(1:3,2);
a = T_0t(1:3,3);
d = T_0t(1:3,4);

dc = d - a*d5;
dcx = dc(1);
dcy = dc(2);
dcz = dc(3);


%Theta 1 calculations
Theta_1 = atan2d(dcy,dcx)

%Theta 3 calculations
sin_Theta_3 = (((dcz-d1)^2)+(dcx^2)+(dcy^2)-(L2^2)-(L3^2))/(2*L2*L3);
cos_Theta_3 = sqrt(1-(sin_Theta_3)^2);
Theta_3 = atan2d(sin_Theta_3,cos_Theta_3)

%Theta 2 calculations
A_Matrix = [L2+(L3*sin_Theta_3), L3*cos_Theta_3;
L3*cos_Theta_3, -L2-(L3*sin_Theta_3)];
Matrix_b = [dcz-d1; sqrt((dcx^2)+(dcy^2))];
Theta_2_Matrix = A_Matrix\Matrix_b
cos_Theta_2 = Theta_2_Matrix(1,1);
sin_Theta_2 = Theta_2_Matrix(2,1);
Theta_2 = atan2d(sin_Theta_2,cos_Theta_2)

%Theta 4 & 5 calculations
A_01 = [cosd(Theta_1), 0, sind(Theta_1); sind(Theta_1), 0, -cosd(Theta_1); 0, 1, 0];
A_12 = [-sind(Theta_2), -cosd(Theta_2), 0; cosd(Theta_2), -sind(Theta_2), 0; 0, 0, 1];
A_23 = [sind(Theta_3), cosd(Theta_3), 0; -cosd(Theta_3), sind(Theta_3), 0; 0, 0, 1];
R_03 = A_01*A_12*A_23;
R_0t = [n,s,a];
R_03_Transpose = R_03';
R_3t = R_03_Transpose*R_0t
cos_Theta_4 = R_3t(1,3)
sin_Theta_4 = R_3t(2,3)
Theta_4 = atan2d(sin_Theta_4,cos_Theta_4)

cos_Theta_5 = R_3t(3,2);
sin_Theta_5 = R_3t(3,1);
Theta_5 = atan2d(sin_Theta_5,cos_Theta_5)


