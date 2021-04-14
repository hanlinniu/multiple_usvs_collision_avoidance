% This script is to test collision avoidance demo
clear,clc,close all
pause(0.01)
figure(1)
hold on
xlim([-1000 1700]);
ylim([-600 1100]);
hold on
xlabel('East');
ylabel('North');
grid on

% Define vessel shape
x_shape = [0,0.3,0.7,1,0.5,0,-0.5,-1,-0.7,-0.3,0];
y_shape = [6,4.6,2,0,-1.2,-2,-1.2,0,2,4.6,6];
scale = 12;
[m_shape, n_shape] = size(x_shape);

% Define start point
startpoint_x = 0;
startpoint_y = -500;

% Define destination
destination_x = 0;
destination_y = 1000;

% plot the start point and plot the destination
plot(startpoint_x, startpoint_y, 'o', 'MarkerFaceColor','g')
hold on
plot(destination_x, destination_y, 'o', 'MarkerFaceColor','g')
hold on
text(startpoint_x+20, startpoint_y,'Start Point','Fontsize',10 );
hold on
text(destination_x+20, destination_y,'Destination','Fontsize',10 );
hold on


% Define USV
x_usv = startpoint_x;
y_usv = startpoint_y;
v_usv = 4;
h_usv = 0;
delta_t = 1;

%% Define intruder number
n_intruder = 7;

% Define intruder one
x_intruder(1) = 100;
y_intruder(1) = 400;
v_intruder(1) = 0;
h_intruder(1) = pi;

% Define intruder two
x_intruder(2) = -20;
y_intruder(2) = 0;
v_intruder(2) = 0;
h_intruder(2) = 3*pi/2;

% Define intruder three
x_intruder(3) = 1600;
y_intruder(3) = 700;
v_intruder(3) = 4;
h_intruder(3) = pi;

% Define intruder four
x_intruder(4) = 1200;
y_intruder(4) = 500;
v_intruder(4) = 4;
h_intruder(4) = pi;

% Define intruder five
x_intruder(5) = 500;
y_intruder(5) = 0;
v_intruder(5) = 0;
h_intruder(5) = pi;

% Define intruder six
x_intruder(6) = -800;
y_intruder(6) = -200;
v_intruder(6) = 2;
h_intruder(6) = 0;

% Define intruder seven
x_intruder(7) = 1300;
y_intruder(7) = 500;
v_intruder(7) = 4;
h_intruder(7) = pi;



%% Define safety parameters (safety raius cpa, TCPA)
cpa = 100;
tcpa = 60;

% Define the proportionality constant of PN guidance method
N1 = 10;

% Define other parameters
tmatrix = zeros(2);

% Initialize the last commanded usv heading angle
double h_usv
double print_h_usv
double tangent_course_sight
double delta_tangent_course_sight
double course_sight_rate
%relative_v_usv_tangent = vpa(4)

pre_h_usv = 0;
previous_tangent_course_angle = pi/3;
current_avoiding_intruder = 0;
distance = 100;
intruder_index = 0;


for time = 1:1000
    x_usv = x_usv + v_usv*cos(h_usv)*delta_t;
    y_usv = y_usv + v_usv*sin(h_usv)*delta_t;
    
    for i = 1:n_intruder
        x_intruder(i) = x_intruder(i) + v_intruder(i)*cos(h_intruder(i))*delta_t;
        y_intruder(i) = y_intruder(i) + v_intruder(i)*sin(h_intruder(i))*delta_t;
    end
    
%     x_intruder(1) = x_intruder(1) + v_intruder(1)*cos(h_intruder(1))*delta_t;
%     y_intruder(1) = y_intruder(1) + v_intruder(1)*sin(h_intruder(1))*delta_t;
%     x_intruder(2) = x_intruder(2) + v_intruder(2)*cos(h_intruder(2))*delta_t;
%     y_intruder(2) = y_intruder(2) + v_intruder(2)*sin(h_intruder(2))*delta_t;
%     x_intruder(3) = x_intruder(3) + v_intruder(3)*cos(h_intruder(3))*delta_t;
%     y_intruder(3) = y_intruder(3) + v_intruder(3)*sin(h_intruder(3))*delta_t;
    
    %% check the collision
    % the status flag output from check_collision will only equal to 0, 1,
    % 2.
    % status_flag = 0, no collision in 2*tcpa time
    % status_flag = 1, warning, collision in 2*tcpa time
    % status_flag = 2, collision in tcpa time, does not need to turn
    % status_flag = 3, This will be added in check colregs part!!!!!!
    
    % c = 0, decide avoid
    % c = 1, decide not avoid
    
    h_usv_origional = atan2(destination_y - y_usv, destination_x -x_usv);
    if h_usv_origional < 0
        h_usv_origional = h_usv_origional + 2*pi;
    end
    
    for j = 1:n_intruder
        status_flag(j) = 0;
        c(j) = 0;
        [c(j), status_flag(j)] = check_collision(x_usv, y_usv, v_usv, h_usv_origional, x_intruder(j), y_intruder(j), v_intruder(j), h_intruder(j), cpa, tcpa);
    end
       
    
    %% check the Colregs scenario
    % scenario = 0, no collision case
    % scenario = 1, heading on under potential collision in tcpa
    % scenario = 2, crossing under potential collision in tcpa
    % scenario = 3, overtaking under potential collision in tcpa
    
    % status_flag = 0, no collision in 2*tcpa time
    % status_flag = 1, warning, collision in 2*tcpa time
    % status_flag = 2, collision in tcpa time, does not need to turn
    % status_flag = 3, collision in tcpa time, need to turn 
    
    for k = 1:n_intruder
        if c(k)==1
            % choose the front and right side as the required to turn
            % scenarios
            
            
            % Transpose matrix
            tmatrix = [sin(h_usv) -cos(h_usv);
                       cos(h_usv)  sin(h_usv)];
                   
            % Transpose the intruder position into the usv frame and the
            % usv position is (0,0)
            body_position_intruder = tmatrix * [x_intruder(k)-x_usv;y_intruder(k)-y_usv];
            body_x_intruder = body_position_intruder(1);
            body_y_intruder = body_position_intruder(2);
            
            % Calculate the line of sight angle of the intruder in the usv
            % body frame
            body_theta = atan2(body_y_intruder, body_x_intruder);
            
            %status_flag(k) = 3;
            if body_theta>=pi/2-10*pi/180 && body_theta<=pi/2+10*pi/180
                scenario = 1;
                status_flag(k) = 3;
            elseif body_theta>=-22.5*pi/180 && body_theta<pi/2-10*pi/180
                scenario = 2;
                status_flag(k) = 3;
            else status_flag(k) = 0;
            end
            
            if k == current_avoiding_intruder
                status_flag(k) = 3;
            end
       
        end
        
    end
 
    %% calculate out the collision resoultion
    % choose the status_flag = 3 case and calculate out the collision
    % resolution point 
    [row, col] = find(status_flag==3);
    % if no need to change course angle, just follow the origional path
%     if isempty(col)==1
%         h_usv = h_usv_origional;
%     end    


    %% if potential collision exists and required to change course angle!
    if isempty(col)==0
        [row_col, col_col] = size(col);
        %% Calculate the number of the potential collisions and the collision resolution
  
        % When there is one intruder required to be avoided
        if col_col==1
            % Calculate the right side tangent point
            if sqrt((x_usv - x_intruder(col))^2+(y_usv - y_intruder(col))^2)<cpa
                 h_relative_usv_required = pre_h_usv;
            else [tangent_x, tangent_y] = rightside_tangent_point(x_usv, y_usv, x_intruder(col), y_intruder(col), cpa);
                 tangent_x = vpa(tangent_x, 7);
                 tangent_y = vpa(tangent_y, 7);
                 h_relative_tangent = atan2(y_usv - tangent_y, x_usv - tangent_x);
                 h_relative_usv_required = required_course(v_usv, v_intruder(col),h_relative_tangent,h_intruder(col));
            end
            
             if abs(h_relative_usv_required - h_usv)>10*pi/180
                 h_usv = h_usv + sign(h_relative_usv_required - h_usv)*10*pi/180;
             else h_usv = h_relative_usv_required;
             end
            
            %h_usv = h_relative_usv_required
            
            
            
            v_intruder_collision = v_intruder(col);
            h_intruder_collision = h_intruder(col);
            intruder_index = col;
            
            % Record the current intruder index 
            current_avoiding_intruder = intruder_index;
            
            dist = norm([x_usv - x_intruder(col), y_usv - y_intruder(col)]);
            distance = [distance, dist];
        % When there is multiple intruders required to be avoided
        elseif col_col>1
            % Calculate the collision resolution point of multiple collisions 
             multi_h_relative_usv_required = zeros(1,col_col);
             
             
             for k = 1:col_col
                 [multi_tangent_x(k),multi_tangent_y(k)] = rightside_tangent_point(x_usv, y_usv, x_intruder(col(k)), y_intruder(col(k)), cpa);
                 multi_h_relative_tangent(k) = atan2(y_usv - multi_tangent_y(k), x_usv - multi_tangent_x(k));
                 multi_h_relative_usv_required(k) = required_course(v_usv, v_intruder(col(k)), multi_h_relative_tangent(k),h_intruder(col(k)));
             end
  
            
            [row_max, col_max] = max(abs(multi_h_relative_usv_required - h_usv_origional)); 
            h_relative_usv_required = multi_h_relative_usv_required(col_max);
            
              if abs(h_relative_usv_required - h_usv)>10*pi/180
                 h_usv = h_usv + sign(h_relative_usv_required - h_usv)*10*pi/180;
              else h_usv = h_relative_usv_required;
              end
            
             %h_usv = h_relative_usv_required;
             
             tangent_x = multi_tangent_x(col_max);
             tangent_y = multi_tangent_y(col_max);
             v_intruder_collision = v_intruder(col_max);
             h_intruder_collision = h_intruder(col_max);
             intruder_index = col_max;
             
             
             %calculate the distance between usv and the intruder
             dist = norm([x_usv - x_intruder(col_max), y_usv - y_intruder(col_max)]);
             distance = [distance, dist];
             
            % Record the current intruder index 
            current_avoiding_intruder = intruder_index;
        end
        
        %% PN guidance
        % calculate the current line of sight angle
        tangent_course_sight = atan2(tangent_y - y_usv, tangent_x - x_usv);
        if tangent_course_sight < 0
            tangent_course_sight = tangent_course_sight + 2*pi;
        end
           
        
        % delta_tangent_course_sight is the difference between the line of sight
        % and the previous line of sight angle (from the usv to the tangent point)
        delta_tangent_course_sight = tangent_course_sight - previous_tangent_course_angle;
        
        % delta_tangent_course_sight is regulated into the right range
%         if delta_tangent_course_sight > pi
%             delta_tangent_course_sight = -delta_tangent_course_sight + 2*pi;
%         elseif delta_tangent_course_sight < -pi
%             delta_tangent_course_sight = -2*pi + delta_tangent_course_sight;
%         end
%         
        course_sight_rate = delta_tangent_course_sight;
        
        % calculate the relative speed betweent the usv and the tangent
        % point
        relative_v_usv_tangent = sqrt((v_usv*cos(pre_h_usv) - v_intruder_collision*cos(h_intruder_collision))^2+(v_usv*sin(pre_h_usv) - v_intruder_collision*sin(h_intruder_collision))^2);
        relative_v_usv_tangent = double(relative_v_usv_tangent);
        % h_usv_acceleration is the acceleration perpendicular to the usv
        % heading
        h_usv_acceleration = N1 * course_sight_rate * relative_v_usv_tangent;
        
        % h_usv_rate is the angular velocity
        h_usv_rate = h_usv_acceleration / relative_v_usv_tangent;
        
        h_desired_usv = double(pre_h_usv + h_usv_rate);
  
        if abs(h_desired_usv - pre_h_usv) > 10*pi/180
           h_usv = pre_h_usv + sign(h_desired_usv - pre_h_usv)*10*pi/180;
        else h_usv = h_desired_usv;
        end
     
        
        %h_usv = h_relative_usv_required;
        
        while abs(h_usv) >2*pi
            if h_usv<0
                h_usv = h_usv + 2*pi;
            elseif h_usv>2*pi
                h_usv = h_usv - 2*pi;
            end
        end
            
        
        previous_tangent_course_angle = tangent_course_sight;
        pre_h_usv = h_usv;
    end
    
    
    
    %% If no collision, go back to origional path
     if isempty(row)==1 %status_flag == 0
         h_usv_back = double(atan2(destination_y-y_usv,destination_x-x_usv));
         current_avoiding_intruder = [];
         intruder_index = 0;
         if abs(h_usv_back - pre_h_usv) > 10*pi/180
            h_usv = pre_h_usv + sign(h_usv_back - pre_h_usv)*10*pi/180;
           else h_usv = h_usv_back;
         end        
     end
     

     
    % record the commanded usv heading angle in previous_h_usv
    pre_h_usv = h_usv;
    
    %% Draw and delete the usv and the intruders
    [x_usv_plot, y_usv_plot, H, G] = draw_kayaka(x_shape,y_shape,x_usv,y_usv,scale, h_usv);
    
    for i = 1:n_intruder
        
        if i==current_avoiding_intruder
            [x_intruder_one_plot, y_intruder_one_plot, H_intruder(i), G_intruder(i)] =draw_intruder(x_shape, y_shape, x_intruder(i), y_intruder(i), scale, h_intruder(i), [1 0 0]);
            intruder_text(i) = text(x_intruder(i), y_intruder(i)+40, num2str(i), 'Color',[1 0 0]);
        else
            [x_intruder_one_plot, y_intruder_one_plot, H_intruder(i), G_intruder(i)] =draw_intruder(x_shape, y_shape, x_intruder(i), y_intruder(i), scale, h_intruder(i), [0 0 1]);
            intruder_text(i) = text(x_intruder(i), y_intruder(i)+40, num2str(i), 'Color',[0 0 1]);
        end   
        
        
    end
    
    plot(x_usv, y_usv,'.','MarkerEdgeColor','b')
    hold on
    usv_text = text(x_usv + 20, y_usv-20,'USV','Color',[1 0 0]);
    
    pause(0.1)
    delete(H);
    delete(G);
    delete(usv_text);
    for i = 1:n_intruder
        delete(H_intruder(i));
        delete(G_intruder(i));
        delete(intruder_text(i));
    end
   time = time+1;
   
   distance_usv_destination = [destination_y-y_usv,destination_x-x_usv];
   if norm(distance_usv_destination)<10
       break
   end
   
end

figure(2)
[m_d, n_x] = size(distance);
for i = 2:n_x
    plot(i, distance(i), '.','MarkerEdgeColor','b')
    hold on 
end
plot([0, max(distance)], [100, 100], 'r', 'Linewidth',2)

xlim([0,n_x+10])
ylim([0, max(distance)])
grid on
xlabel('t')
ylabel('Distance')
hold on





