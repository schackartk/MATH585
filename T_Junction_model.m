%   Kenneth Schackart
%   schackartk@email.arizona.edu
%   13 February 2019
%   Modelling droplet formation in a T-Junction

% Key geometric variables
h_div_w = [0:0.1:0.5]; % channel height divided by channel width, h/w
flow_ratio = [0:1:10]; %Flow rate ratios. disperse over continuous

% Calculate volume at end of filling
r1_f = (3*pi/8) - (pi/2)*(1-(pi/4))*h_div_w; % w_in / w <= 1
r133_f = filling_wrong(4/3,h_div_w); 
r2_f = filling_wrong(2,h_div_w);
r3_f = filling_wrong(3,h_div_w);

r133_f_right = filling_right(4/3,h_div_w); 
r2_f_right = filling_right(2,h_div_w);
r3_f_right = filling_right(3,h_div_w);

% Calculate alpha
alpha_033 = squeezing(h_div_w,3,1,0);
alpha_067 = squeezing(h_div_w,3,2,0);
alpha_1 = squeezing(h_div_w,3,3,0);
alpha_133 = squeezing(h_div_w,3,4,0);
alpha_2 = squeezing(h_div_w,3,6,0);
alpha_3 = squeezing(h_div_w,3,9,0);

% Calculate total volumes
V_033 = (3*pi/8) - (pi/2)*(1-(pi/4))*(1/3) + squeezing(1/3,3,1,0.3)*flow_ratio
V_067 = (3*pi/8) - (pi/2)*(1-(pi/4))*(1/3) + squeezing(1/9,3,2,0.3)*flow_ratio
V_1 = (3*pi/8) - (pi/2)*(1-(pi/4))*(1/3) + squeezing(1/3,3,3,0.3)*flow_ratio
V_133 = filling_wrong(4/3,1/3) + squeezing(0.17,3,4,0.3)*flow_ratio
V_3 = filling_wrong(3,1/3) + squeezing(1/3,3,9,0.3)*flow_ratio

% Generate plots
figure(1)
plot(h_div_w,r1_f,'DisplayName','w_{in}/w<=1')
    hold on
    plot(h_div_w,r133_f,'DisplayName','w_{in}/w=1.33')
    plot(h_div_w,r2_f,'DisplayName','w_{in}/w<=2')
    plot(h_div_w,r3_f,'DisplayName','w_{in}/w<=3')
xlim([0 0.5])
xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
ylim([0 2])
ylabel('$\frac{V_{fill}}{hw^{2}}$','Interpreter','latex','FontSize',20)
legend('Location','southeast')
title('Dimensionless fill volume vs. $$\frac{h}{w}$$ (Incorrect equation)','Interpreter','latex','FontSize',14)
drawnow
hold off

figure(2)
plot(h_div_w,r1_f,'DisplayName','w_{in}/w<=1')
    hold on
    plot(h_div_w,r133_f_right,'DisplayName','w_{in}/w=1.33')
    plot(h_div_w,r2_f_right,'DisplayName','w_{in}/w<=2')
    plot(h_div_w,r3_f_right,'DisplayName','w_{in}/w<=3')
xlim([0 0.5])
xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
ylim([0 2])
ylabel('$\frac{V_{fill}}{hw^{2}}$','Interpreter','latex','FontSize',20)
legend('Location','southeast')
title('Dimensionless fill volume vs. $$\frac{h}{w}$$ (Correct equation)','Interpreter','latex','FontSize',14)
drawnow
hold off

figure(3)
plot(h_div_w,alpha_033,'DisplayName','w_{in}/w<=0.33')
hold on
plot(h_div_w,alpha_067,'DisplayName','w_{in}/w=0.67')
plot(h_div_w,alpha_1,'DisplayName','w_{in}/w=1')
plot(h_div_w,alpha_133,'DisplayName','w_{in}/w=1.33')
plot(h_div_w,alpha_2,'DisplayName','w_{in}/w=2')
plot(h_div_w,alpha_3,'DisplayName','w_{in}/w3')
xlim([0 0.5])
xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
ylim([0 8])
ylabel('$\alpha$','Interpreter','latex','FontSize',20)
legend('Location','northeast')
title('Squeezing coefficient, $\alpha$ vs. $\frac{h}{w}$','Interpreter','latex','FontSize',14)
drawnow
hold off

figure(4)
plot(flow_ratio,V_033,'DisplayName','w_{in}/w=0.33')
hold on
plot(flow_ratio,V_067,'DisplayName','w_{in}/w=0.67')
plot(flow_ratio,V_1,'DisplayName','w_{in}/w=1')
plot(flow_ratio,V_133,'DisplayName','w_{in}/w=1.33')
plot(flow_ratio,V_3,'DisplayName','w_{in}/w=3')
xlim([0 10])
xlabel('$\frac{q_d}{q_c}$','Interpreter','latex','FontSize',20)
ylim([0 25])
ylabel('$\frac{V}{hw^2}$','Interpreter','latex','FontSize',20)
legend('Location','southeast')
title('Dimensionless volume vs. flow rate ratio, $\frac{q_{d}}{q_{c}}$','Interpreter','latex','FontSize',14)
drawnow
hold off

function vf_hw2 = filling_wrong(win_w,h_div_w)% Returns fill volume / h8w^2
    w_win = 1/win_w;
    first_term = ((pi/4)-0.5*asin(1-w_win))*(win_w)^2;
    second_term = (-1/2)*(win_w-1)*((2*win_w)-1)^(1/2)+(pi/8);
    third_term = -0.5*(1-pi/4)*(pi/2-asin(1-w_win)*win_w + pi/2);
    
    vf_hw2 = first_term + second_term + third_term*h_div_w;
end
function vf_hw2 = filling_right(win_w,h_div_w)
    w_win = 1/win_w;
    first_term = ((pi/4)-0.5*asin(1-w_win))*(win_w)^2;
    second_term = (-1/2)*(win_w-1)*((2*win_w)-1)^(1/2)+(pi/8);
    third_term = -0.5*(1-pi/4)*((pi/2-asin(1-w_win))*win_w + pi/2);
    
    vf_hw2 = first_term + second_term + third_term*h_div_w;
end
function alpha = squeezing(h_div_w,w,w_in,eps)
    for i = 1:length(h_div_w);
        h = h_div_w(i) * w;
        ratio = ((h*w)/(h+w))-eps;

        r_pinch = w + w_in - (ratio) + ( 2*(w_in-ratio)*(w-ratio) )^(0.5);
        r_fill = max([w,w_in]);

        rpw = r_pinch/w;
        rfw = r_fill/w;

        alpha(i) = (1-(pi/4))*( (1-0.1)^(-1) )*( (rpw^2)-(rfw^2)+(pi/4)*(rpw-rfw)*(h_div_w(i)) );
    end
end