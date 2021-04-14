function theta = convert_angle(p_x, p_y)
% This function is to generate the tangential angle of the vector

vector = [p_x p_y];
theta = atan(p_y/p_x);

% The tangential angle range needs to be converted into [0 2*pi)
if vector(1)>0&&vector(2)>0
     theta = theta;
 end
 if vector(1)>0&&vector(2)<0
     theta = theta+2*pi;
 end
 if vector(1)<0&&vector(2)>0
     theta = theta+pi;
 end
 if vector(1)<0&&vector(2)<0
     theta = theta+pi;
 end