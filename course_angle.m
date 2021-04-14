function theta = course_angle(p_t, p_f)


%p_t and p_f stand for two arbitrary  points
%Theta is the course angle of two points 


theta = atan((p_f(2)-p_t(2))/(p_f(1)-p_t(1)));

vector = [p_f(1)-p_t(1) p_f(2)-p_t(2)];
    

% The range of the course angle should be changed from (-pi/2 pi/2) to be
% [0 2*pi]
 if vector(1)>=0&&vector(2)>0
     theta = theta;
 end
 if vector(1)>=0&&vector(2)<0
     theta = theta+2*pi;
 end
 if vector(1)<0&&vector(2)>=0
     theta = theta+pi;
 end
 if vector(1)<0&&vector(2)<=0
     theta = theta+pi;
 end