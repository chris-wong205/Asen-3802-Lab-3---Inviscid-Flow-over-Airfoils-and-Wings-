% Input Parameters:
% NACA_num = character array of NACA Airfoil number (Ex: '0012')
% => Note: Must be wrapped in single quotes and no NACA name
% chord_length = length of airfoil chord
% half_num_of_panels = half of the total number of panels

% Return Values:
% x = x values starting at TE and going CW around airfoil
% y = Corresponding y values


function [x,y] = NACA_Airfoil_Gen(NACA_num, chord_length, half_num_of_panels)
    
    % Split NACA code into parts
    m = str2double(NACA_num(1))/100; % Max Camber - % chord
    p = str2double(NACA_num(2))/10; % Location of max camber - 1/10 chord
    t = str2double(NACA_num(3:end))/100; % Max Thickness - % chord
    
    
    %Use Circular clustering for x
    theta = linspace(0,pi, half_num_of_panels);
    x = (chord_length/2).*(1-cos(theta));

    %Calculate thickness distribution
    y_t = (t./.2).*(chord_length).*(.2969.*sqrt(x./chord_length) -.1260 .* (x./chord_length)-.3516 .* (x./chord_length).^2+.2843.*(x./chord_length).^3-.1036.*(x./chord_length).^4);
    
    %Calculate the mean chamber line piecewise equation
    x_lower = x(x < p*chord_length);
    x_upper = x(x >= chord_length*p);

    y_c_less = ((m.*x_lower)./(p^2)).*(2*p-(x_lower./chord_length));
    y_c_plus = (m.*(chord_length-x_upper)./((1-p)^2)) .*(1 + (x_upper./chord_length) - 2*p);
    y_c = [y_c_less, y_c_plus];
    
    %Calculate xi value
    xi = atan(gradient(y_c,x));
    
    %Calculate individual coordinates of upper and lower surfaces
    x_u = x - y_t.*sin(xi);
    x_l = x + y_t.*sin(xi);

    y_u = y_c + y_t.*cos(xi);
    y_l = y_c - y_t.*cos(xi);
    
    % Arrange coordinates so they start at TE and go aroung CW
    x_l = flip(x_l);
    y_l = flip(y_l);
    
    % Delete repeated instance of 0 coordinate and put them all in one set
    x = [x_l, x_u(2:end)];
    y = [y_l, y_u(2:end)];

end
