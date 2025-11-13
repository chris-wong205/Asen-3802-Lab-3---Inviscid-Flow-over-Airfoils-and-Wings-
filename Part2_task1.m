clc, clear all, close all;

% 
% point_nums = 10;
% AR = [4,6,8,10];
% a0_t = 0;
% a0_r = 0;
% c_t = linspace(0,1,point_nums);
% c_r = ones([1,point_nums]);
% 
% aero_t = 0;
% aero_r = 0;
% geo_t = 0;
% geo_r = 0;
% N = 10;
% 
% for i = 1:4
%     b(i) = AR(i).*(c_t + c_r)./2;
%     [e(i),c_L(i),c_Di(i)] = PLLT(b(i),a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);
% end
% 
% delta = (1/e) - 1;

[e,c_L,c_Di] = PLLT(100,2*pi,2*pi,10,10,0,0,5*pi/180,5*pi/180,5)