function [difference] =  calculateDifferenceBetweenAngles( firstAngle, secondAngle)
    mydifference = secondAngle - firstAngle;

    while (mydifference < -pi) 
        mydifference =mydifference + 2*pi;
    end
    while (mydifference > pi) 
        mydifference =mydifference - 2*pi;
    end

    difference = mydifference;
end