function [c, status_flag] = check_collision( uav_x, uav_y, uav_v, uav_h, obs_x, obs_y, obs_v, obs_h, safety_r, TCPA)

% theta is the angle between the tangent line that from the usv to the intruder safety circle and the line that is between
% the intruder and the usv.
theta = atan(safety_r/sqrt((uav_x-obs_x)^2+(uav_y-obs_y)^2));

% theta 1 is the tangential angle of the vector that is between the
% intruder and the usv
theta1 = atan2(obs_y-uav_y, obs_x-uav_x);

if theta1 < 0 
    theta1 = theta1 + 2*pi;
end

% theta 2 is the tangential angle of the relative speed vector that is between
% the usv speed and the intruder speed
theta2 = atan2(uav_v*sin(uav_h)-obs_v*sin(obs_h),uav_v*cos(uav_h)-obs_v*cos(obs_h));%convert_angle(uav_v*cos(uav_h)-obs_v*cos(obs_h), uav_v*sin(uav_h)-obs_v*sin(obs_h));
if theta2 < 0 
    theta2 = theta2 + 2*pi;
end


delta = abs(theta1-theta2);
delta = vpa(delta,4);
theta = vpa(theta,4);

% Due to the equation solving accuracy, the error is assumed to be 0.01
if delta > theta+0.01
    c = 0;
else c =1;
end
if abs(delta) > 2*pi-theta
   c = 1;
end


status_flag = 0;


% % Check the TCPA
if c == 1
    status_flag = 1;
    distance_uav_obs = sqrt((uav_x-obs_x)^2+(uav_y-obs_y)^2);
    
    % the line of the relative speed crossing the uav
    % y = tan(theta2)x - tan(theta2)*uav_x + uav_y
    
    distance_obs_line = abs(tan(theta2)*obs_x-obs_y-tan(theta2)*uav_x + uav_y)/sqrt((tan(theta2))^2+1);
    distance_CPA = sqrt((distance_uav_obs)^2-(distance_obs_line)^2);
    relative_uav_obs = sqrt((uav_v*cos(uav_h)-obs_v*cos(obs_h))^2+(uav_v*sin(uav_h)-obs_v*sin(obs_h))^2);
    if distance_CPA/relative_uav_obs <= TCPA
        c = 1;
        status_flag = 2;
    elseif distance_CPA/relative_uav_obs >TCPA && distance_CPA/relative_uav_obs < 2*TCPA
        c = 0;
        status_flag = 1;
    else c = 0;
        status_flag = 0;
    end
end

end











