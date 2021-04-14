function [ x_shape_plot, y_shape_plot, H, G] = draw_intruder(x_shape, y_shape,x_center, y_center,scale, heading, color)

[m_shape, n_shape] = size(x_shape);

for i=1:n_shape
    length = sqrt(x_shape(i)^2+y_shape(i)^2);
    origional_theta = atan2(y_shape(i),x_shape(i));
    x_shape_new(i) = length*scale*cos(heading-pi/2+origional_theta);
    y_shape_new(i) = length*scale*sin(heading-pi/2+origional_theta);
end

x_shape_plot = (x_shape_new+x_center);
y_shape_plot = (y_shape_new+y_center);

H=plot(x_shape_plot, y_shape_plot,'Linewidth',1.3,'Color',color);
G=fill(x_shape_plot, y_shape_plot,color);
% drawnow
% pause(0.1);
% delete(H);
% delete(G);
end

