function r_c = required_course(v_usv,v_obs,v_h,v_obs_h)
% v_usv is the usv velocity, v_h is the usv relative heading angle
% v_obs is the intruder velocity, v_obs_h is the intruder heading angle

syms x  r_c

% b is the real heading angle the usv needed.
a = solve((v_usv*sqrt(1-x^2)-v_obs*sin(v_obs_h))/(v_usv*x-v_obs*cos(v_obs_h))==tan(v_h));

a = vpa(a);

b = acos(a);

[m,n]=size(b);
if m>1
    if b(1)>b(2)
        r_c=b(2);
    else r_c=b(1);
    end

else r_c=b;
end
    
