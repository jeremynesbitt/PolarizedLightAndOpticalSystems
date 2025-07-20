function figJ = plotJonesVector(jin)
% Fancy plot of jones vector (with arrow!)
% Note for people like me who tend to forget.  
% The plots here are done by remembering that the E field varies
% in time as well as space, and these plot are over one period 
% of the time varying field, represented here by theta.

assert(length(jin) == 2, 'Error!  Inproper jones matrix!');
assert(isreal(jin(1)), 'Error!  Plots do not support imaginary first term')

magnitude = sqrt(sum(abs(jin).*abs(jin)));


theta = linspace(0,2*pi,101);
ex = exp(-1i*theta)*jin(1);
ey = exp(-1i*theta)*jin(2);

figJ = figure;
plot(real(ex),real(ey),'LineWidth',8);

% Now the hard part.  drawing the arrow correctly.  
h = 0.2; % height of arrow (relative to magnitude)
aT = 5*pi/180; % angle of arrow triangle 

if isreal(jin(1)) & isreal(jin(2)) % Linear pol
    phi = atan2(jin(2),jin(1));
    v1 = [jin(1);jin(2)]; 
    dr = [cos(phi); sin(phi)];
    vb = v1-h*dr;
    dphi = [-sin(phi);cos(phi)];
    v2 = vb+tan(aT)*dphi;
    v3 = vb-tan(aT)*dphi;
    triMat = [v1,v2,v3];
    hold on;
    fill(triMat(1,:),triMat(2,:),'b');
    xlim([-magnitude,magnitude]);
    ylim([-magnitude,magnitude]);   
else % some form of circular
    phi = angle(jin(2));
    theta0 = -pi/6; % pick an angle
        ex0 = exp(-1i*theta0)*jin(1);
        ey0 = exp(-1i*theta0)*jin(2);

        phi = atan2(real(ey0),real(ex0));
        dr = [cos(phi); sin(phi)];
        dphi = [-sin(phi);cos(phi)];


        v1 = [real(ex0);real(ey0)];
        % essentially switched from linear.
              
        %dr = v1/sqrt(sum(v1.*v1));
        %dphi = [-sin(theta0);cos(theta0)];

        vb = v1-sign(angle(jin(2)))*h*dphi;

        % Debug - plot dphi and dr.  


        % Use finite differences
        dtta = .01;
        dex0 = exp(-1i*(theta0+dtta))*jin(1);
        dey0 = exp(-1i*(theta0+dtta))*jin(2); 
        dphi = 1./(theta0-dtta).*[real(ex0-dex0);real(ey0-dey0)];
        dphi = dphi*1/sqrt(sum(dphi.*dphi));

        %vb = v1-sign(angle(jin(2)))*h*dphi;
        vb = v1-h*dphi;
        dr = [-dphi(2); dphi(1)];

        hold on;
        plot([v1(1),vb(1)],[v1(2),vb(2)], 'r')
        plot([v1(1),v1(1)-h*dr(1)],[v1(2),v1(2)-h*dr(2)],'g')        


        v2 = vb+tan(aT)*dr;
        v3 = vb-tan(aT)*dr;
        triMat = [v1,v2,v3];
        hold on;
        fill(triMat(1,:),triMat(2,:),'b');
        xlim([-magnitude,magnitude]);
        ylim([-magnitude,magnitude]); 

    end



end

    % if jin(1) == 0 % V pol
    %     v1 = [jin(1);jin(2)]; 
    %     v2 = [-(v1(2)-h*magnitude)*tan(aT);(v1(2)-h*magnitude)];
    %     v3 = [+(v1(2)-h*magnitude)*tan(aT);(v1(2)-h*magnitude)];
    %     triMat = [v1,v2,v3];
    %     hold on;
    %     fill(triMat(1,:),triMat(2,:),'b');
    %     xlim([-magnitude,magnitude]);
    %     ylim([-magnitude,magnitude]);