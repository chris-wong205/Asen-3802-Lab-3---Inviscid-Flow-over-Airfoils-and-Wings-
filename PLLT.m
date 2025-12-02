%% This function is the PLLT Function. 
%{
The function includes e the span efficiency factor (to be computed and returned), C_L is the coefficient of lift (to be
computed and returned), C_Di is the induced coefficient of drag (to be computed and reported), b is the
span (in feet), a0_t is the cross-sectional lift slope at the tips (per radian), a0_r is the cross-sectional lift
slope at the root (per radian), c_t is the chord at the tips (in feet), c_r is the chord at the root (in feet),
aero_t is the zero-lift angle of attack at the tips (in radians), aero_r is the zero-lift angle of attack at the
root (in radians), geo_t is the geometric angle of attack (geometric twist + α) at the tips (in radians),
geo_r is the geometric angle of attack (geometric twist + α) at the root (in radians), and N is the number
of odd terms to include in the series expansion for circulation.

%}

% This code was written in collaboration with Aiden Hayes,Ignacio Huber,
% Mikah Laufer, & Christopher Wong with additional assistance from
% Professor John Evans, and the CU ASEN 3802 Faculty team and lab
% resources.

function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)


i = (1:N);
%% Create linear
% functions WRT theta variable for all spanwise variables
theta_i = (i.*pi)/(2.*N);
c_theta = c_r - (c_r - c_t).*cos(theta_i);
a_theta = a0_r - (a0_r - a0_t).*cos(theta_i);
aero_theta = (aero_t-aero_r)*cos(theta_i) + aero_r;
geo_theta = (geo_t-geo_r)*cos(theta_i) + geo_r;

%% Create matrix and vector of linear equation coefficients
 for m = 1:N
     for n = 1:N
        M(m, n) = ((4*b)/(c_theta(m)*a_theta(m)))*sin((2*n -1)*theta_i(m)) + (2*n -1)*sin((2*n -1)*theta_i(m))/sin(theta_i(m));
     end
     d(m,1) = geo_theta(m) - aero_theta(m);
 end

% Calculate
A_coeffs = (M\d)';

% Caculate delta
delta = 0;
for k = 2:N
    delta = delta + (2*k - 1) * (A_coeffs(k)/A_coeffs(1))^2;
end


% Calculate planform
S = (c_t+c_r)*(b/2);
% Aspect ratio
AR = b^2 /S;


% Calculate coefficients of lift and drag
c_L = A_coeffs(1)*pi*AR;
c_Di = ((c_L^2)*(1+delta))/(pi*AR);

% Calculate span efficiency factor
e = 1/(1+delta);

end


