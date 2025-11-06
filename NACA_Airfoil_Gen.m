function [x_u, y_u, x_l, y_l] = NACA_Airfoil_Gen(NACA_num, chord_length, half_num_of_panels)
    
    % Split the string into segments
    m = str2double(NACA_num(1))/100; % First digit
    p = str2double(NACA_num(2))/10; % Second digit
    t = str2double(NACA_num(3:end))/100; % Last two digits
    
    
    %x = 0:.01:chord_length;
    theta = linspace(0,pi, half_num_of_panels);
    x = (chord_length/2).*cos(theta) + (chord_length/2);


    y_t = (t./.2).*(chord_length).*(.2969.*sqrt(x./chord_length) -.1260 .* (x./chord_length)-.3516 .* (x./chord_length).^2+.2843.*(x./chord_length).^3-.1036.*(x./chord_length).^4);

    x_lower = x(x < p*chord_length);
    x_upper = x(x >= chord_length*p);

    y_c_less = ((m.*x_lower)./(p^2)).*(2*p-(x_lower./chord_length));
    y_c_plus = (m.*(chord_length-x_upper)./((1-p)^2)) .*(1 + (x_upper./chord_length) - 2*p);
    y_c = [y_c_less, y_c_plus];
    
    xi = atan(gradient(y_c,x));

    x_u = x - y_t.*sin(xi);
    x_l = x + y_t.*sin(xi);

    y_u = y_c + y_t.*cos(xi);
    y_l = y_c - y_t.*cos(xi);

end