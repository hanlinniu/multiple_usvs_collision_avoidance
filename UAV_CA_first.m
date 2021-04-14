% UAV_CA_try
clear,clc,close all
% initialize the drone paramters
uav_s = [0,-900];
uav_f = [0, 1000];   
uav_v = 3;
uav_h = atan2(uav_f(2)-uav_s(2), uav_f(1)-uav_s(1)); 
uav_x = uav_s(1);
uav_y = uav_s(2);
delta_t = 1;


% initialize the obstacles
% obstacle 1
obs1_s = [1200,200]; 
obs1_v = 3;
obs1_h = pi;
obs1_x = obs1_s(1);
obs1_y = obs1_s(2);
% obstacle 2
obs2_s = [0,500];
obs2_v = 3;
obs2_h = 3*pi/2;
obs2_x = obs2_s(1);
obs2_y = obs2_s(2);
% % obstacle 3
% obs3_s =  
% obs3_f =
% obs3_v = 
% obs3_h = 
% 
% % obstacle 4
% obs4_s =
% obs4_f =
% obs4_v = 
% obs4_h = 


% initialize the time to closet point of approach
TCPA = 60; 

theta = 0:0.01:2*pi;
safety_r = 50;


figure(1)
%plot in this area
pfigure = axes('position',[.12 .25 .7 .7]);    


%display current speed 
cs = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 30 10 80 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%display current speed button

cst = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 15 30 120 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Speed(m/s)');
        
        
%..........................

ch = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 162.5 10 75 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%display current course angle button

cht = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 125 30 150 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Course Angle(degrees)');
        
        
%........................

%intruder ID

intr_i = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 305 10 50 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%intruder ID button

intr_ib = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 280 30 100 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Intruder ID');
        
%........................

%status flag

sf = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 410 10 50 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%status flag button

sfb = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 385 30 100 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Status Flag');

 %........................
 %UAV CA Demo

position = uicontrol(...
            'Style', 'text',...
            'Units', 'pixels',...
            'Position', [ 450 280 110 110],...
            'HorizontalAlignment', 'center',...
            'String', 'UAV CA Demo',...
            'Fontsize',12,...
            'ForegroundColor','r');
        
        
        
%........................
%UAV position button

position = uicontrol(...
            'Style', 'text',...
            'Units', 'pixels',...
            'Position', [ 470 250 80 40],...
            'HorizontalAlignment', 'center',...
            'String', 'UAV position',...
            'Fontsize',12,...
            'ForegroundColor','b');
        
%........................
%Longitude

long = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 485 190 50 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%Longitude button

longb = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 460 210 100 32],...
            'HorizontalAlignment', 'center',...
            'String', 'X(meters)');
        

%........................        
%Latitude

lat = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 485 140 50 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
%Latitude button

latb = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 460 160 100 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Y(meters)');
        
%Scenario        
sc = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 485 80 50 15],...
            'HorizontalAlignment', 'center',...
            'String', 0);
        
        
%Scenario button
scb = uicontrol(...
            'Style', 'pushbutton',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 460 100 100 32],...
            'HorizontalAlignment', 'center',...
            'String', 'Scenario');
        
        
        
%Author       
author = uicontrol(...
            'Style', 'text',...
            'BackGroundColor','white',...
            'Units', 'pixels',...
            'Position', [ 465 300 90 20],...
            'HorizontalAlignment', 'center',...
            'Fontsize',8,...
            'String', 'Author: Hanlin Niu',...
            'ForegroundColor','k');

xlim([-1000, 1000]);
ylim([-1000, 1000]);
hold on
xlabel('X (meters)')
ylabel('Y (meters)')
hold on
plot(pfigure,uav_s(1), uav_s(2),'o','MarkerFaceColor','g');
hold on
plot(pfigure,uav_f(1), uav_f(2),'o','MarkerFaceColor','g');
hold on
text(uav_s(1)+10, uav_s(2),'Start Point','Fontsize',10);
hold on
text(uav_f(1)+10, uav_f(2),'Destination','Fontsize',10);
hold on




for i = 1:1000
    % update uav position
    uav_h = atan2(uav_f(2)-uav_y, uav_f(1)-uav_x);
    uav_x = uav_x + uav_v * cos(uav_h) * delta_t;
    uav_y = uav_y + uav_v * sin(uav_h) * delta_t;
    ww = plot(pfigure,uav_x, uav_y, 'o','MarkerFaceColor','b');
    set(long, 'String', double(uav_x))
    set(lat, 'String', double(uav_y))
    set(cs, 'String',double(uav_v))
    set(ch, 'String',double(uav_h)*180/pi)
    
   

    % update obstacle position
    obs1_x = obs1_x + obs1_v * cos(obs1_h) * delta_t;
    obs1_y = obs1_y + obs1_v * sin(obs1_h) * delta_t;
    obs2_x = obs2_x + obs2_v * cos(obs2_h) * delta_t;
    obs2_y = obs2_y + obs2_v * sin(obs2_h) * delta_t;
    
    obs1_c_x = obs1_x + safety_r * cos(theta);
    obs1_c_y = obs1_y + safety_r * sin(theta);
    obs2_c_x = obs2_x + safety_r * cos(theta);
    obs2_c_y = obs2_y + safety_r * sin(theta);
    
    
    w1 = plot(pfigure,obs1_x, obs1_y, 'o','MarkerSize',3,'MarkerFaceColor','r');
    w2 = plot(pfigure,obs2_x, obs2_y, 'o','MarkerSize',3,'MarkerFaceColor','r');
    w1s = plot(pfigure,obs1_c_x, obs1_c_y, '.','MarkerSize',1,'Color','r');
    w2s = plot(pfigure,obs2_c_x, obs2_c_y, '.','MarkerSize',1,'Color','r');
    pause(0.01)
    delete(ww);
    delete(w1);
    delete(w2);
    delete(w1s);
    delete(w2s);
    
    plot(pfigure,uav_x, uav_y, 'b.')
    hold on
    
    % initialize there is no collision
    c = 0;
    status_flag = 0;
    set(intr_i, 'String',0)
    set(sc,'String', 0)
    % check collision function
    [c1, status_flag] = check_collision( uav_x, uav_y, uav_v, uav_h, obs1_x, obs1_y, obs1_v, obs1_h, safety_r, TCPA );
    [c2, status_flag] = check_collision( uav_x, uav_y, uav_v, uav_h, obs2_x, obs2_y, obs2_v, obs2_h, safety_r, TCPA);
    
    set(sf, 'String',double(status_flag))
    
    % check which scenario the collision belongs to
    delta_theta = 10*pi/180;

    
    if c1 == 1
        obs_x = obs1_x;
        obs_y = obs1_y;
        obs_h = obs1_h;
        obs_v = obs1_v;
        obs_index = 1;
        
        % Heading on scenario
        if abs(uav_h-obs1_h)>=pi-2*delta_theta&&abs(uav_h-obs1_h)<=pi+2*delta_theta
            scenario = 1;
            c = 1;
        elseif obs1_h-uav_h>0 && obs1_h - uav_h< pi-2*delta_theta
            scenario = 2;
            c = 1;
        elseif uav_h - obs1_h>pi+2*delta_theta && uav_h - obs1_h < 2*pi
            scenario = 2;
            c = 1;
        end
    end
    
    if c2== 1
        obs_x = obs2_x;
        obs_y = obs2_y;
        obs_h = obs2_h;
        obs_v = obs2_v; 
        obs_index = 2;
        % Crossing scenario
        if abs(uav_h-obs2_h)>=pi-2*delta_theta&&abs(uav_h-obs2_h)<=pi+2*delta_theta
            scenario = 1;
            c = 1;
        elseif obs2_h-uav_h>0 && obs2_h - uav_h< pi-2*delta_theta
            scenario = 2;
            c = 1;
        elseif uav_h - obs2_h>pi+2*delta_theta && uav_h - obs2_h < 2*pi
            scenario = 2;
            c = 1;
        end
        
    end
    
    while c == 1
        i = i+1;
        if obs_index==1
            obs_x = obs1_x;
            obs_y = obs1_y;
            obs_h = obs1_h;
            obs_v = obs1_v;  
            set(intr_i, 'String',1)
        end
        if obs_index==2
            obs_x = obs2_x;
            obs_y = obs2_y;
            obs_h = obs2_h;
            obs_v = obs2_v;
            set(intr_i, 'String',2)
        end
        % mesure the distance between uav and the obstacles
        
        if exist('d')==0
            d = sqrt((uav_x-obs_x)^2+(uav_y-obs_y)^2);
        else
            d = [d,sqrt((uav_x-obs_x)^2+(uav_y-obs_y)^2)];
        end
        
        % calculate the right side tangent point
        [tangent_x, tangent_y] = rightside_tangent_point(uav_x, uav_y, obs_x, obs_y, safety_r);
        t_m_vector = 1/sqrt((uav_x - tangent_x)^2+(uav_y - tangent_y)^2)*[-uav_x + tangent_x, -uav_y + tangent_y];
        t_a_vector = [cos(obs_h), sin(obs_h)];
        % give the collision resolution function
        relative_speed_vector = [uav_v*cos(uav_h)-obs_v*cos(obs_h), uav_v*sin(uav_h)-obs_v*sin(obs_h)];
        abs_relative_speed_vector = sqrt((relative_speed_vector(1))^2+(relative_speed_vector(2))^2);
        t_u_vector = abs_relative_speed_vector/uav_v*t_m_vector + obs_v/uav_v*t_a_vector;
        
        theta_u = atan2(t_u_vector(2), t_u_vector(1));
        if theta_u < 0
            theta_u = theta_u + 2*pi;
        end
        
        theta_u_dot = 0;
        desired_uav_h = theta_u + theta_u_dot;
        uav_h = vpa(desired_uav_h,4);
        
        uav_bh = atan2(uav_f(2)-uav_y, uav_f(1)-uav_x);
        [c, status_flag] = check_collision( uav_x, uav_y, uav_v, uav_bh, obs_x, obs_y, obs_v, obs_h, safety_r, TCPA );
        
        % update uav position
        uav_x = uav_x + uav_v * cos(uav_h) * delta_t;
        uav_y = uav_y + uav_v * sin(uav_h) * delta_t;
        set(long, 'String', double(uav_x))
        set(lat, 'String', double(uav_y))
        set(cs, 'String',double(uav_v))
        set(ch, 'String',double(uav_h)*180/pi)
        set(sf, 'String',double(status_flag))
        if scenario == 1
            set(sc,'String', 'Heading on')
        elseif scenario == 2
            set(sc,'String','Crossing')
        end
        
        ww = plot(uav_x, uav_y, 'o','MarkerFaceColor','b');
        plot(uav_x, uav_y, 'b.')
        hold on



        % update obstacle position
        obs1_x = obs1_x + obs1_v * cos(obs1_h) * delta_t;
        obs1_y = obs1_y + obs1_v * sin(obs1_h) * delta_t;
        obs2_x = obs2_x + obs2_v * cos(obs2_h) * delta_t;
        obs2_y = obs2_y + obs2_v * sin(obs2_h) * delta_t;

        obs1_c_x = obs1_x + safety_r * cos(theta);
        obs1_c_y = obs1_y + safety_r * sin(theta);
        obs2_c_x = obs2_x + safety_r * cos(theta);
        obs2_c_y = obs2_y + safety_r * sin(theta);


        w1 = plot(obs1_x, obs1_y, 'o','MarkerSize',3,'MarkerFaceColor','r');
        w2 = plot(obs2_x, obs2_y, 'o','MarkerSize',3,'MarkerFaceColor','r');
        w1s = plot(obs1_c_x, obs1_c_y, '.','MarkerSize',1,'Color','r');
        w2s = plot(obs2_c_x, obs2_c_y, '.','MarkerSize',1,'Color','r');
        pause(0.01)
        delete(ww);
        delete(w1);
        delete(w2);
        delete(w1s);
        delete(w2s);
    end
    

    distance = sqrt((uav_x-uav_f(1))^2+(uav_y-uav_f(2))^2);
    
    if distance < 20
        break
    end
    
end

plot(uav_x, uav_y, 'o','MarkerFaceColor','b');
hold on
plot(obs1_x, obs1_y, 'o','MarkerFaceColor','r');
hold on
plot(obs2_x, obs2_y, 'o','MarkerFaceColor','r');
hold on
plot(obs1_c_x, obs1_c_y, '.','MarkerSize',1,'Color','r');
hold on
plot(obs2_c_x, obs2_c_y, '.','MarkerSize',1,'Color','r');
hold on


figure(2)
[m_d, n_d] = size(d);
for i = 1:n_d
    if d(i)~=0
        plot(i,d(i),'b.')
        hold on
    end
    
end

plot([0, n_d+200], [safety_r, safety_r],'r-')
hold on
text(150,50, 'safety radius line','Fontsize',15,'Color','r')

xlim([0 200])
ylim([safety_r-50 450])
hold on

