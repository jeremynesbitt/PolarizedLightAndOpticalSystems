% Some reproduced plots from Section 8.4 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/5/25
% Use at your own risk - I make lots of mistakes
addpath('..');
add_tftb_to_path();

% define multilayer stack
S(1) = tf_layer(1.5);
S(2) = tf_layer(@n_air); 
lambda = 0.550;

% For 3D plot
theta = linspace(10,80,9);
rs = tf_amp_vs_angle(S, lambda, theta, 's');
figP = plotIncidentAndReflectedRays(theta,rs,'s');
title('Figure 8.19c')


theta = linspace(0,89,101);
[Rs, Ts] = tf_rayfan(S,lambda,theta,'s');
[Rp, Tp] = tf_rayfan(S,lambda,theta,'p');



figure;plot(theta, [Rs,Rp]);
xlabel('angle of incidende [deg]')
ylabel('Reflectance')
legend('Rs','Rp')
title('Figure 8.21a')

figure;plot(theta, [Ts,Tp]);
xlabel('angle of incidende [deg]')
ylabel('Transmission')
legend('Ts','Tp')
title('Figure 8.21b')

[rs, ts] = tf_amp_vs_angle(S, lambda, theta, 's');
[rp, tp] = tf_amp_vs_angle(S, lambda, theta, 'p');

figure;plot(theta,[real(rs)', real(rp)', imag(rs)', imag(rp)'])
xlabel('angle of incidence [deg]')
ylabel('Real and Imaginary Parts of Fresnel Coefficients')
legend('Re(rs)','Re(rp)','Imag(rs)','Imag(rp)', 'Location','southwest')
title('Figure 8.22a (Calculated via Characteristic Matrix)');

% Just as a sanity check calc this with fresnel coefficients and verify we
% get the same answer

nk = evalnk(S,lambda);
[rfs, tfs] = fresnel_vs_angle(nk,theta,'s');
[rfp, tfp] = fresnel_vs_angle(nk,theta,'p');

figure;plot(theta,[real(rfs)', real(rfp)', imag(rfs)', imag(rfp)'])
xlabel('angle of incidence [deg]')
ylabel('Real and Imaginary Parts of Fresnel Coefficients')
legend('Re(rs)','Re(rp)','Imag(rs)','Imag(rp)', 'Location','southwest')
title('Figure 8.22a (Calculated using Fresnel Coefficients)');



figure;plot(theta,[abs(rs)', abs(rp)'])
xlabel('angle of incidence [deg]')
ylabel('Magnitude of Fresnel Reflection Coefficients')
legend('Abs(rs)','Abs(rp)', 'Location','southeast')
title('Figure 8.22b');


figure;plot(theta, angle(rs),theta,angle(rp));
xlabel('angle of incidende [deg]')
ylabel('Phase')
legend('rs','rp')
title('Figure 8.23a')

thetaFtr = (theta>40);
% The results in the textbook are bigger by pi.  I am not sure why?
% Leaving it as is for now.
figure;plot(theta(thetaFtr), (angle(rs(thetaFtr))-angle(rp(thetaFtr))));
xlabel('angle of incidence [deg]')
ylabel('Retardance [rad]')
title('Figure 8.23b')

%% Al 

lambda = 0.633;
S(1) = tf_layer(@n_air); 
S(2) = tf_layer(tf_readnk('al', 'sopra'), 0.0, lambda);
[rs, ts] = tf_amp_vs_angle(S, lambda, theta, 's');
[rp, tp] = tf_amp_vs_angle(S, lambda, theta, 'p');
figure;plot(theta, abs(rs),theta,abs(rp));
xlabel('angle of incidende [deg]')
ylabel('Reflectance')
legend('rs','rp','Location','southwest')
title('Figure 8.28a')



% Sign convention is different between ttfb and this book, and can be
% addressed by the -1 for p polarization shown below
figure;plot(theta, abs(rs),theta,abs(rp));
xlabel('angle of incidende [deg]')
ylabel('Reflectance')
legend('rs','rp')
title('Figure 8.28a')

[DR, DT] = tf_dia_vs_angle(S,lambda,theta);
figure;plot(theta, DR);
xlabel('angle of incidende [deg]')
ylabel('Diattenuation for Reflection')
title('Figure 8.28b')

% Note that I added some questionable logic to the tf_amp_vs_angle function
% to make this consistent with the assumption that at a metal interface the
% reflected wave should be ~pi out of phase with the incident wave.
figure;plot(theta, angle(rs), theta, angle(rp));
xlabel('angle of incidence [deg]')
ylabel('Phase Shift [radians]')
legend('rs','rp')
title('Figure 8.29a');

% Just for fun, noting that the fresnel equations in this book do not allow
% for a 180 degree phase shift for p polarized light at normal incidence
nk = evalnk(S,lambda);
[rfs, tfs] = fresnel_vs_angle(nk,theta,'s');
[rfp, tfp] = fresnel_vs_angle(nk,theta,'p');
figure;plot(theta, angle(rfs), theta, angle(rfp));
xlabel('angle of incidence [deg]')
ylabel('Phase Shift [radians]')
%legend('rs','rp')
title('Figure 8.29a - Fresnel Equations');


retAl = tf_ret_vs_angle(S, lambda, theta);

figure;plot(theta, retAl);
xlabel('angle of incidence [deg]')
ylabel('Retardance [rad]')
%legend('rs','rp')
title('Figure 8.29b');

Rs = tf_rayfan(S, lambda, theta, 's');
Rp = tf_rayfan(S, lambda, theta, 'p');

figure;plot(theta, Rs,theta,Rp);
xlabel('angle of incidence [deg]')
ylabel('Fresnel Reflection Intensity Coefficient')
legend('s','p')
title('Figure 8.30a');

figure;plot(theta, 1-Rs,theta,1-Rp);
xlabel('angle of incidence [deg]')
ylabel('Absorption')
legend('s','p')
title('Figure 8.30b');




