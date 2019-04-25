%   Kenneth Schackart
%   schackartk@email.arizona.edu
%   19 April 2019
%   Modelling droplet formation in a T-Junction, an extension on the model
%   given by Van Steijn

% Key variables
h_div_w = [0:0.05:0.5];        %Channel height divided by channel width, h/w
flow_ratio = [0:1:10];         %Flow rate ratios. Disperse over continuous
win_w = [1:0.1:3];             %Channel width ratios, inlet over main
gutter_volumes = [0:0.05:0.5]; %Portion of continuous phase through gutter
epsilon = [0:0.05:0.5];         %Corner roundness measure

% Calculate matrices
fill_vols = filling(win_w,h_div_w); 

alpha = squeezing(h_div_w,win_w,0);
volumes = filling(win_w,1/3) + squeezing(1/3,win_w,0.3)*flow_ratio;

% Generate plots
plot_fill_volumes(h_div_w,win_w,fill_vols)
plot_alphas(h_div_w,win_w,alpha)
plot_volumes(flow_ratio,win_w,volumes)

function vf_hw2 = filling(win_w,h_div_w)% Returns fill volume / h/w^2 using the correct formula
    for i = 1:length(h_div_w)
        for j = 1:length(win_w)
            w_win = 1/win_w(j);
            first_term = ((pi/4)-0.5*asin(1-w_win))*(win_w(j))^2;
            second_term = (-1/2)*(win_w(j)-1)*((2*win_w(j))-1)^(1/2)+(pi/8);
            third_term = -0.5*(1-pi/4)*((pi/2-asin(1-w_win))*win_w(j) + pi/2);
    
            vf_hw2(j,i) = first_term + second_term + third_term*h_div_w(i);
        end
    end
end
function alpha = squeezing(h_div_w,win_w,eps)% Returns the squeezing coefficient alpha
    w = 3;
    for i = 1:length(h_div_w)
        for j = 1:length(win_w)
            w_in = w*win_w(j);
            h = h_div_w(i) * w;
            ratio = ((h*w)/(h+w))-eps;

            r_pinch = w + w_in - (ratio) + ( 2*(w_in-ratio)*(w-ratio) )^(0.5);
            r_fill = max([w,w_in]);

            rpw = r_pinch/w;
            rfw = r_fill/w;

            alpha(j,i) = (1-(pi/4))*( (1-0.1)^(-1) )*( (rpw^2)-(rfw^2)+(pi/4)*(rpw-rfw)*(h_div_w(i)) );
        end
    end
end
function plot_fill_volumes(h_div_w,win_w,fill_vols)
    figure(1) % Dimensionless fill volume using incorrect eqn
    surf(h_div_w,win_w,fill_vols,'FaceColor','interp')
    hold on

    xlim([0 0.5])
    xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 2])
    zlabel('$\frac{V_{fill}}{hw^{2}}$','Interpreter','latex','FontSize',20)
    title('Dimensionless fill volume vs. $$\frac{h}{w}$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap jet
    drawnow
    hold off
end
function plot_alphas(h_div_w,win_w,alpha)
    figure(3) % Squeezing coefficient
    surf(h_div_w,win_w,alpha,'FaceColor','interp')
    hold on
    
    xlim([0 0.5])
    xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
    ylim([0 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 8])
    zlabel('$\alpha$','Interpreter','latex','FontSize',20)
    title('Squeezing coefficient, $$\alpha$$ vs. $$\frac{h}{w}$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap cool
    drawnow
    hold off
end
function plot_volumes(flow_ratio,win_w,volumes)
    figure(4) % Dimensionless volume
    surf(flow_ratio,win_w,volumes,'FaceColor','interp')
    hold on
    
    xlim([0 10])
    xlabel('$\frac{q_d}{q_c}$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlabel('$\frac{V}{hw^2}$','Interpreter','latex','FontSize',20)
    title('Dimensionless volume vs. flow rate ratio, $$\frac{q_{d}}{q_{c}}$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    drawnow
    hold off
end
