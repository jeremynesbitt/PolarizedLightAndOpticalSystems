% Some reproduced plots from Section 13.2 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/13/25
% Use at your own risk - I make lots of mistakes

addpath('..');
add_tftb_to_path();

% wavelength
lambda = 0.532;  % um
theta = 0;       % AOI in degrees

% Get n of MgF2 at WL of interest
rih = tf_readnk('mgf2', 'sopra');
nh = real( tf_nk(rih, lambda) );

% define multilayer stack
S(1) = tf_layer(@n_air);
S(2) = tf_layer(tf_readnk('mgf2', 'sopra'), 0.25, lambda);
S(3) = tf_layer(1.5);

% calculate swing curve
% This is going through two glass interfaces, so that is why it is lower
% than what is shown in the book (I think
D = linspace(0,lambda/nh,101);
[R,T,A] = tf_swingcurve(S, lambda, theta, 2, D, 'u');
figure;plot(D/max(D),T)
title('Figure 13.3 - Transmission of MgF2 coating on Glass')
xlabel('Optical Thickness [t/n]');
ylabel('Intensity Transmission');

% wavelength
lambda = 0.550;  % um
theta = 0;       % AOI in degrees

% Get n of MgF2 at WL of interest
rih = tf_readnk('mgf2', 'sopra');
nh = real( tf_nk(rih, lambda) );

% define multilayer stack
S(1) = tf_layer(@n_air);
S(2) = tf_layer(tf_readnk('mgf2', 'sopra'), 0.25, lambda);
S(3) = tf_layer(1.5);
S(4) = tf_layer(1.5); % To avoid seeing results in air duplicate n=1.5 layer

Sunc(1) = S(1);
Sunc(2) = S(3);
Sunc(3) = S(4);

% calculate t aoi for both pols
theta = linspace(0,50,101);
[Rp, Tp, ~] =tf_rayfan(S, lambda, theta, 'p');
[Rs, Ts, ~] =tf_rayfan(S, lambda, theta, 's');

[Rp_unc, Tp_unc, ~] =tf_rayfan(Sunc, lambda, theta, 'p');
[Rs_unc, Ts_unc, ~] =tf_rayfan(Sunc, lambda, theta, 's');

figure;plot(theta,[Tp,Ts, Tp_unc, Ts_unc])
title('Figure 13.4a - Pol. Transmission of 0.25 wave MgF2 coating on Glass')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Intensity Transmission');
legend('Coated Tp', 'Coated Ts', 'Uncoated Tp', 'Uncoated Ts');

figure;plot(theta,[Rp,Rs, Rp_unc, Rs_unc])
title('Figure 13.4b - Pol. Transmission of 0.25 wave MgF2 coating on Glass')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Intensity Transmission');
legend('Coated Rp', 'Coated Rs', 'Uncoated Rp', 'Uncoated Rs');

%% Figure 13.5 - Diattenuation 
% Diattentution = (Tmax-Tmin)/(Tmax+Tmin).  

figure;plot(theta,[(Tp-Ts)./(Tp+Ts), (Tp_unc-Ts_unc)./(Tp_unc+Ts_unc)])
title('Figure 13.5a - Transmission Diattentuaion of 0.25 wave MgF2 coating on Glass')
xlabel('Angle of Incidence in Air [deg]');
legend('Coated', 'Uncoated');

figure;plot(theta,[(Rs-Rp)./(Rs+Rp), (Rs_unc-Rp_unc)./(Rs_unc+Rp_unc)])
title('Figure 13.5b - Reflection Diattentuaion of 0.25 wave MgF2 coating on Glass')
xlabel('Angle of Incidence in Air [deg]');
legend('Coated', 'Uncoated');

%% Figure 13.6 Phase Change in Transmission

for ii=1:length(theta)
[R_faz_p(ii,1), T_faz_p(ii,1)] = tf_phase(S, lambda, theta(ii), 'p', 0);
[R_faz_s(ii,1), T_faz_s(ii,1)] = tf_phase(S, lambda, theta(ii), 's', 0);
[Runc_faz_p(ii,1), Tunc_faz_p(ii,1)] = tf_phase(Sunc, lambda, theta(ii), 'p', 0);
[Runc_faz_s(ii,1), Tunc_faz_s(ii,1)] = tf_phase(Sunc, lambda, theta(ii), 's', 0);
end

figure;plot(theta,-180/pi*[T_faz_p, T_faz_s]);
title('Figure 13.6 - Transmission Phase of 0.25 wave MgF2 coating on Glass')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Transmission Phase [deg]')
legend('p', 's');

%% Figure 13.7 - Retardance
% retardance = phis-phip
figure;plot(theta,[-180/pi*(T_faz_p-T_faz_s),-180/pi*(Tunc_faz_p-Tunc_faz_s)]);
title('Figure 13.7a - Transmission Retardance')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Retardance [deg]')
legend('coated', 'uncoated');

% This does not reproduce the values in the book.
figure;plot(theta,[-180/pi*(R_faz_p-R_faz_s),-180/pi*(Runc_faz_p-Runc_faz_s)]);
title('Figure 13.7b - Reflection Retardance')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Retardance [deg]')
legend('coated','uncoated');

% This is closer to what is in the book.  Are the units wrong for the
% reflecance retardance?
figure;plot(theta,[(R_faz_s-R_faz_p),(Runc_faz_p-Runc_faz_s)]);
title('Figure 13.7b - Reflection Retardance')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Retardance [rad]')
legend('coated','uncoated');

%% Figure 13.8 
% Diattenuation and Retardance of a fictiious substrate index
% define multilayer stack
S(1) = tf_layer(@n_air);
S(2) = tf_layer(1.38,0.25, lambda);
S(3) = tf_layer(1.38^2);
S(4) = tf_layer(1.38^2); % To avoid seeing results in air duplicate layer

Sunc(1) = S(1);
Sunc(2) = S(3);
Sunc(3) = S(4);

% calculate t aoi for both pols
[RDia, TDia] = tf_dia_vs_angle(S, lambda, theta);
[RDiaUC, TDiaUC] = tf_dia_vs_angle(Sunc, lambda, theta);
figure;plot(theta,[TDia, TDiaUC])
title('Figure 13.8a - Transmission Diattentuaion of 0.25 wave MgF2 coating on n^2 sub')
xlabel('Angle of Incidence in Air [deg]');
legend('Coated', 'Uncoated');
% Also switched with book?

% Interesting to note that t and r retardance are identical here
rs = tf_amp_vs_angle(S,lambda, theta, 's');
rp = tf_amp_vs_angle(S,lambda, theta, 'p');

[Rret, Tret] = tf_ret_vs_angle(S, lambda, theta);
figure;plot(theta,[Tret*180/pi])
title('Figure 13.8b - Retardance of 0.25 wave MgF2 coating on n^2 substrate')
xlabel('Angle of Incidence in Air [deg]');
ylabel('Transmission Retardance [deg]')

% Look at intensity vs film thickness for a Al film on glass

lambda = 0.6;
% define multilayer stack
S(1) = tf_layer(@n_air);
S(2) = tf_layer(tf_readnk('al', 'sopra'), 0.25, lambda);
S(3) = tf_layer(1.5);
S(4) = tf_layer(1.5); % To avoid seeing results in air duplicate n=1.5 layer

rih = tf_readnk('al', 'sopra');
nh = real( tf_nk(rih, lambda) );

D = linspace(0,0.035*lambda,101);
[R,T,A] = tf_swingcurve(S, lambda, 0.0, 2, D, 'u');
figure;plot(D/lambda,[T,R])
title('Figure 13.9a - T/R of Al on Glass vs Thickness')
xlabel('Film Thickness [waves]');
ylabel('Intensity');
legend('Transmission', 'Reflection');

for ii=1:length(D)
S(2).d = D(ii)
[R_faz_p(ii,1), T_faz_p(ii,1)] = tf_phase(S, lambda, 0.0, 'p', 0);
[R_faz_s(ii,1), T_faz_s(ii,1)] = tf_phase(S, lambda, 0.0, 's', 0);
end

figure;plot(D/lambda,[T_faz_p*180/pi,(R_faz_p-pi)*180/pi])
title('Figure 13.9b - T/R Phase of Al on Glass vs Thickness')
xlabel('Film Thickness [waves]');
ylabel('Phase in Degrees');
legend('Transmission', 'Reflection');

%% 13,10 - 45 degree
D = linspace(0,0.02*lambda,101);
[Rs,Ts,A] = tf_swingcurve(S, lambda, 45.0, 2, D, 's');
[Rp,Tp,A] = tf_swingcurve(S, lambda, 45.0, 2, D, 'p');
figure;plot(D/lambda,[Ts,Tp,Rs,Rp])
title('Figure 13.10a - T/R of Al on Glass vs Thickness')
xlabel('Film Thickness [waves]');
ylabel('Intensity');
legend('Ts', 'Tp','Rs','Rp');

for ii=1:length(D)
S(2).d = D(ii)
[R_faz_p(ii,1), T_faz_p(ii,1)] = tf_phase(S, lambda, 45.0, 'p', 0);
[R_faz_s(ii,1), T_faz_s(ii,1)] = tf_phase(S, lambda, 45.0, 's', 0);
end

figure;plot(D/lambda,[T_faz_s*180/pi,T_faz_p*180/pi,(R_faz_s-pi)*180/pi,(R_faz_p-pi)*180/pi])
title('Figure 13.10b - 45 Deg T/R Phase of Al on Glass vs Thickness')
xlabel('Film Thickness [waves]');
ylabel('Phase in Degrees');
legend('Ts', 'Tp','Rs','Rp');




