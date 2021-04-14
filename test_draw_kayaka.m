% This code is used to draw a kayaka

clear,clc,close all

xlim([-50 80]);
ylim([-50 80]);
hold on


x_center = 0;
y_center = 0;

scale = 1;

heading = 0;

x_shape = [0,0.3,0.7,1,0.5,0,-0.5,-1,-0.7,-0.3,0];
y_shape = [6,4.6,2,0,-1.2,-2,-1.2,0,2,4.6,6];



[m_shape, n_shape] = size(x_shape);

for j = 1:50

    heading = heading + pi/6;
    heading_angle = heading*180/pi
    for i=1:n_shape
        length = sqrt((x_shape(i))^2+(y_shape(i))^2);
        origional_theta = atan2(y_shape(i),x_shape(i));
        %x_shape_new(i) = length*cos(heading-pi/2+origional_theta);
        %y_shape_new(i) = length*sin(heading-pi/2+origional_theta);
        x_shape_new(i) = length*cos(pi/6+origional_theta);
        y_shape_new(i) = length*sin(pi/6+origional_theta);
    end
    x_shape = x_shape_new;
    y_shape = y_shape_new;
    
    x_shape_plot = (x_shape_new+x_center);
    y_shape_plot = (y_shape_new+y_center);
    H=plot(x_shape_plot, y_shape_plot,'Linewidth',2,'Color',[0 0 0]);
    G=fill(x_shape_plot, y_shape_plot,[1 1 0]);
    drawnow
    pause(1)
    delete(H);
    delete(G);
    j = j+1;
end

