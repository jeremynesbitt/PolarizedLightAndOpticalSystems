function figP = plotIncidentAndReflectedRays(theta,rAmp, pol)
% Inspired by Fig 8.19 in Polarized Light and Optical Systems
% but not nearly as pretty
% Jeremy Nesbitt 7/13/25

% Some hard coded values that may change in a future version
phi = 90*pi/180;
r = 10; % length of rays
ra = 5; % radius of incident/reflected arrows
h = 0.5; % radial height of arrow
aT = 10*pi/180; % angle of arrow triangle (I don't think this is workikng as intended

figP = figure;
view([-30,0])
hold on;
phi = 90;

for ii=1:length(theta)
    tta = theta(ii)*pi/180;

    % Define the line in spherical coordinates.
    origin_x = r*sin(tta)*cos(phi); 
    origin_y = r*sin(tta)*sin(phi); 
    origin_z = r*cos(tta);

    plot3([origin_x, 0], [origin_y, 0], [origin_z, 0])



    % Arrow head for incident beam
    triMat = getArrowVertices(tta,phi,ra,h,aT, 'i');
    % Plot the triangle using fill3
    fill3(triMat(1,:),triMat(2,:), triMat(3,:), 'r'); % 'r' specifies the color (red)

    % Draw Pol Unit Vector
    switch pol
        case 's'
         unitVector = 0.5*[cos(tta)*cos(phi); ...
                       cos(tta)*sin(phi); ...
                       -sin(tta)];
        case 'p'
         unitVector = 0.5*[-sin(phi); cos(phi); 0];
    end
         plot3([origin_x+unitVector(1),origin_x-unitVector(1)], ...
               [origin_y+unitVector(2),origin_y-unitVector(2)], ...
               [origin_z+unitVector(3),origin_z-unitVector(3)], 'b-^');


    % Reflected Ray
    tta = tta-2*tta;
    origin_x = r*sin(tta)*cos(phi); 
    origin_y = r*sin(tta)*sin(phi); 
    origin_z = r*cos(tta);

    plot3([origin_x, 0], [origin_y, 0], [origin_z, 0])
    % Arrow head for incident beam
    triMat = getArrowVertices(tta,phi,ra,h,aT, 'r');
    % Plot the triangle using fill3
    fill3(triMat(1,:),triMat(2,:), triMat(3,:), 'b'); 
    % Draw Pol Unit Vector
    switch pol
        case 's'
         unitVector = 0.5*[cos(tta)*cos(phi); ...
                       cos(tta)*sin(phi); ...
                       -sin(tta)];
        
        case 'p'
         unitVector = 0.5*[-sin(phi); cos(phi); 0];
    end
     % Scale by reflected amplitude
     unitVector = abs(rAmp(ii))*unitVector;
     vStr = 'b-^';
     if sign(angle(rAmp(ii))) == -1
         vStr = 'b-v';
     end
     plot3([origin_x+unitVector(1),origin_x-unitVector(1)], ...
           [origin_y+unitVector(2),origin_y-unitVector(2)], ...
           [origin_z+unitVector(3),origin_z-unitVector(3)], vStr); 

end

end

function triMat = getArrowVertices(tta,phi,ra,h,aT, rayDir)
% Arrow definition.  Logic here is to define the vector from
% head to base of the triangle, find the normal vector and project
% it 
    ah_x = (ra)*sin(tta)*cos(phi);
    ah_y = (ra)*sin(tta)*sin(phi);
    ah_z = (ra)*cos(tta);

    a1 = [ah_x;ah_y;ah_z];
    

    ab_x = (ra+h)*sin(tta)*cos(phi);
    ab_y = (ra+h)*sin(tta)*sin(phi);
    ab_z = (ra+h)*cos(tta);

    a0 = [ab_x;ab_y;ab_z];

    % vector perp is theta_hat 
    theta_hat = [cos(tta)*cos(phi); ...
                 cos(tta)*sin(phi); ...
                 -sin(tta)];
    bMag = h*tan(aT);

    switch rayDir
        case('i')
            v2 = a0+sqrt(bMag)*theta_hat;
            v3 = a0-sqrt(bMag)*theta_hat;
            triMat = [a1 v2 v3];
        case('r')
            v2 = a1+sqrt(bMag)*theta_hat;
            v3 = a1-sqrt(bMag)*theta_hat;
            triMat = [a0 v2 v3];           
    end

end