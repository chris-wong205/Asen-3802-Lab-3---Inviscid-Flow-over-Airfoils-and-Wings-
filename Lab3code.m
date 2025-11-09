clc; clear all; close all;



%% PART 1 TASK 3

%Constant Variables for each case

chord_length = 1;
alpha = linspace(-10,10,40);
half_num_of_panels = 60;


% Define Variables for NACA Airfoil Maker
NACA_num1 = '0012';
NACA_num2 = '2412';
NACA_num3 = '4412';


[x1,y1,xCamber1,yCamber1] = NACA_Airfoil_Gen(NACA_num1, chord_length, half_num_of_panels);
[x2,y2,xCamber2,yCamber2] = NACA_Airfoil_Gen(NACA_num2, chord_length, half_num_of_panels);
[x3,y3,xCamber3,yCamber3] = NACA_Airfoil_Gen(NACA_num3, chord_length, half_num_of_panels);

%Plotting the NACA from NACA Generation

%Plots NACA 0012
figure;
    hold on;
    plot(x1,y1,'bo');
    plot(xCamber1,yCamber1,'r');
    axis equal
    legend('NACA 0012');
    xlabel('x/c'); 
    ylabel('y/c');
    title('NACA 0012 ');
    hold off;
    print('NACA 0012','-dpng','-r300')

%Plots NACA 2412
figure;
    hold on;
    plot(x2,y2,'go');
    plot(xCamber2,yCamber2,'r');
    axis equal
    legend('NACA 2412');
    xlabel('x/c'); 
    ylabel('y/c');
    title('NACA 2412 ');
    hold off;
print('NACA 2412','-dpng','-r300')

%Plots NACA 4412
figure;
    hold on;
    plot(x3,y3,'yo')
    plot(xCamber3,yCamber3,'r'); 
    axis equal
    xlabel('x/c'); 
    ylabel('y/c');
    legend('NACA 4412');
    title('NACA 4412 ');
    hold off;
print('NACA 4412','-dpng','-r300')


%Utilizes the Vortex Panel Method in order to determine Cl

for i = 1:length(alpha)
    a = alpha(i);
    CL1(i) = Vortex_Panel(x1,y1,a); %For the NACA 0012
    CL2(i) = Vortex_Panel(x2,y2,a); % For the NACA 2412
    CL3(i) = Vortex_Panel(x3,y3,a); % For the NACA 4412

end


% 3.1 Ao calculations for vortex panel method
ao1 = ((CL1(1)-CL1(2))./(alpha(1)-alpha(2)))*(180/pi); %Lift Slope NACA 0012 in terms of Radians
ao2 = ((CL2(1)-CL2(2))./(alpha(1)-alpha(2)))*(180/pi); %Lift Slope NACA 2412 in terms of Radians
ao3 = ((CL3(1)-CL3(2))/(alpha(1)-alpha(2)))*(180/pi); %Lift Slope NACA 4412 in terms of Radians

%-----THE LIFT SLOPE FOR ALL THIN AIRFOILS IS 2PI ACCORDING TO THIN AIRFOIL

vpmalpha_0L1 = interp1(CL1, alpha, 0, 'linear');
vpmalpha_0L2 = interp1(CL2, alpha, 0, 'linear');
vpmalpha_0L3 = interp1(CL3, alpha, 0, 'linear');


figure;
    hold on;
    plot(alpha,CL1,'b')
    plot(alpha,CL2,'g')
    plot(alpha,CL3,'y')

    plot(vpmalpha_0L1,0,'ro')
    plot(vpmalpha_0L2,0,'ro')
    plot(vpmalpha_0L3,0,'ro')
    grid on;
    legend('NACA 0012','NACA 2412','NACA 4412');
    xlabel('\alpha');
    ylabel('CL');
    title('Vortex Panel Method \alpha vs CL')

print('Vortex Panel Method Alpha vs CL','-dpng','-r300')


%% Thin Airfoil Theory Calculation for AoA when L=0

%Calculates dz/dx for thin airfoil theory
dzdx1 = gradient(yCamber1,xCamber1);
dzdx2 = gradient(yCamber2,xCamber2);
dzdx3 = gradient(yCamber3,xCamber3);

theta = linspace(0, pi, half_num_of_panels);

%Will map dzdx of each on over to the theta realm
x_theta = (chord_length/2) * (1 - cos(theta)); % standard thin airfoil transform
dzdx1_theta = interp1(xCamber1, dzdx1, x_theta, 'linear', 'extrap');
dzdx2_theta = interp1(xCamber2, dzdx2, x_theta, 'linear', 'extrap');
dzdx3_theta = interp1(xCamber3, dzdx3, x_theta, 'linear', 'extrap');

%Calculatates the angle of attack when lift = 0 for thin airfoil theory

tatalpha1 = (-1/pi * trapz(theta, dzdx1_theta .* (cos(theta)-1)))*(180/pi);
tatalpha2 = (-1/pi * trapz(theta, dzdx2_theta .* (cos(theta)-1))) * (180/pi);
tatalpha3 = (-1/pi * trapz(theta, dzdx3_theta .* (cos(theta)-1))) * (180/pi);

