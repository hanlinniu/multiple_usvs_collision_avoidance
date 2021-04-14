function [x_t, y_t]= rightside_tangent_point(uav_x, uav_y, p_obs_x,p_obs_y,r)

%This tangent-point function provides the usv the starboard side( with respect to the usv) tangent point
%of the intruder safety circle
%p_t is the current position of the USV
%p_obs is the current position of the obstacle

syms x y a b
p_t = [uav_x, uav_y];
x1=p_t(1);
y1=p_t(2);
x2=p_obs_x;
y2=p_obs_y;

%x1 is the longitude of the USV
%y1 is the latitude of the USV
%x2 is the longitude of the intruder
%y2 is the latitude of the intruder

if sqrt((x1-x2)^2+(y1-y2)^2)>=r

    t=solve(r^2==((x-x2)^2+(y-y2)^2), -x1*x2-y1*y2==y^2-(y1+y2)*y+x^2-(x1+x2)*x);
    x=vpa(t.x);
    y=vpa(t.y);
    
    % The solutions are the two tangent points of the intruder safety circle
    % The tangent point of the starboard side should be selected
    % p_tangent1 and p_tangent2 are the two tangent points position

    p_tangent1 = [x(1) y(1)];
    p_tangent2 = [x(2) y(2)];


    % vectors are used to change the range of theta_1 and theta_2 to be [0 2*pi]
    % The range of theta_1 and theta_2 needs to be mapped into [0 2*pi]
    theta_1 = course_angle (p_t, p_tangent1);
    theta_2 = course_angle (p_t, p_tangent2);
    
    % choose the starboard side tangent point based on the range of the
    % difference between theta_1 and theta_2;
    
    delta_theta = theta_1 - theta_2;
    
    if delta_theta > 0 && delta_theta < pi
        x_t = x(2);
        y_t = y(2);
    elseif delta_theta < -pi
        x_t = x(2);
        y_t = y(2);
    else
        x_t = x(1);
        y_t = y(1);
    end
else
    
    % if the usv is in the circle of the vessel safty zone, it will generate
    % a new path to leave the safety zone.
    x_t = 2*p_t(1)-x2;
    y_t = 2*p_t(2)-y2;
    
    
end
    




    


        
    


