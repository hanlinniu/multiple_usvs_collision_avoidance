% this code is used to draw catamaran
clear,clc,close all

xlim([-10 10]);
ylim([-10 10]);
hold on


x_center = 0;
y_center = 0;

scale = 0.2;

heading = 0;

x_shape = [3,3,4,5,5,3,3,-3,-3,-5,-5,-4,-3,-3,3];
y_shape = [5,7,9,7,-7,-7,-5,-5,-7,-7,7,9,7,5,5];

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
    delete(H);
    delete(G);
    j = j+1;
end