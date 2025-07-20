% Some reproduced plots from Section 2.6 of Polarized Light and Optical
% Systems
% Jeremy Nesbitt -7/5/25
% Use at your own risk - I make lots of mistakes

addpath('..');
add_tftb_to_path();

figH = plotJonesVector([1;0]); title('Horizontal');
figV = plotJonesVector([0;1]); title('Vertical');
fig45 = plotJonesVector(1/sqrt(2)*[1;1]); title('45');
fig135 = plotJonesVector(1/sqrt(2)*[1;-1]); title('135');
figRC = plotJonesVector(1/sqrt(2)*[1;-1i]); title('Right Circular');
figLC = plotJonesVector(1/sqrt(2)*[1;1i]); title('Left Circular');

fitEllipse = plotJonesVector([1;0.5*exp(-1i*45*pi/180)]); title('phi 45');
fitEllipse = plotJonesVector([1;0.5*exp(-1i*225*pi/180)]); title('phi 225');
fitEllipse = plotJonesVector([1;0.5*exp(-1i*270*pi/180)]); title('phi 270');
