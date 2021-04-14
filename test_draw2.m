clear,clc,close all
x_shape = [3,3,4,5,5,3,3,-3,-3,-5,-5,-4,-3,-3,3];
y_shape = [5,7,9,7,-7,-7,-5,-5,-7,-7,7,9,7,5,5];

scale = 0.5;
heading = pi/2;
x_center = 4;
y_center = 6;

[ x_shape_plot, y_shape_plot] = draw_catamaran(x_shape, y_shape,x_center, y_center,scale, heading );


xlim([x_center-15*scale, x_center+15*scale])
ylim([y_center-15*scale, y_center+15*scale])
hold on
H=plot(x_shape_plot, y_shape_plot,'Linewidth',2,'Color',[0 0 0]);
G=fill(x_shape_plot, y_shape_plot,[1 1 0]);