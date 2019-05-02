%   Kenneth Schackart
%   schackartk@email.arizona.edu
%   2 May 2019
%   Modelling droplet formation in a T-Junction, an extension on the model
%   given by Van Steijn

% Key variables
h_div_w = [0:0.05:0.5];        %Channel height divided by channel width, h/w
flow_ratio = [0:1:10];         %Flow rate ratios. Disperse over continuous
win_w = [1:0.1:3];             %Channel width ratios, inlet over main
gutter_volumes = [0:0.05:0.5]; %Portion of continuous phase through gutter
epsilon = [0:0.05:0.5];        %Corner roundness measure

% Calculate matrices
fill_vols = filling(win_w,h_div_w);
r_pinch_hc = pinch(0.25,win_w,epsilon);
r_pinch_wc = pinch2(h_div_w,win_w,epsilon);
alpha = squeezing(h_div_w,win_w,0);
alpha_eps = squeezing_vary_eps(0.25,win_w,epsilon);
volumes = filling(win_w,1/3) + squeezing(1/3,win_w,0.3)*flow_ratio;
volumes_eps = filling(2,1/3) + transpose(squeezing_vary_eps(1/3,2,epsilon))*flow_ratio;

% Generate plots
plot_fill_volumes(h_div_w,win_w,fill_vols)
plot_r_pinch(epsilon,win_w,r_pinch_hc)
plot_r_pinch2(epsilon,h_div_w,r_pinch_wc)
plot_alphas(h_div_w,win_w,alpha)
plot_alphas_eps(epsilon,win_w,alpha_eps)
plot_volumes(flow_ratio,win_w,volumes)
plot_volumes_eps(flow_ratio,epsilon,volumes_eps)

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
function r_pin = pinch(h_div_w,win_w,eps)
    width = 3;
    height = h_div_w * width;
    for k = 1:length(eps)
        for m = 1:length(win_w)
            win = width*win_w(m);
            
            r_pin(m,k) = width + win - (((height*width)/(height+width))-eps(k)) + ( 2*(win-((height*width)/(height+width))-eps(k))*(width-((height*width)/(height+width))-eps(k)) )^(0.5);
        end
    end
end % Return r_pinch by varying w/w_in and epsilon
function r_pin2 = pinch2(h_div_w,win_w,eps)
    wi = 3;
    for k = 1:length(eps)
        for m = 1:length(h_div_w)
            w_inlet = wi*win_w(m);
            height = h_div_w(m) * wi;
            
            r_pin2(k,m) = wi + w_inlet - (((height*wi)/(height+wi))-eps(k)) + ( 2*(w_inlet-((height*wi)/(height+wi))-eps(k))*(wi-((height*wi)/(height+wi))-eps(k)) )^(0.5);
        end
    end
end % Return r_pinch by varying h/w and epsilon
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
function alpha = squeezing_vary_eps(h_div_w,win_w,eps)% Returns the squeezing coefficient alpha
    w = 3;
    for i = 1:length(eps)
        for j = 1:length(win_w)
            w_in = w*win_w(j);
            h = h_div_w * w;
            ratio = ((h*w)/(h+w))-eps(i);

            r_pinch = w + w_in - (ratio) + ( 2*(w_in-ratio)*(w-ratio) )^(0.5);
            r_fill = max([w,w_in]);

            rpw = r_pinch/w;
            rfw = r_fill/w;

            alpha(j,i) = (1-(pi/4))*( (1-0.1)^(-1) )*( (rpw^2)-(rfw^2)+(pi/4)*(rpw-rfw)*(h_div_w) );
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
function plot_r_pinch(epsilon,win_w,r_pinch_hc)
    figure(2) % Squeezing coefficient
    surf(epsilon,win_w,r_pinch_hc,'FaceColor','interp')
    hold on
    
    xlim([0 0.5])
    xlabel('$$\varepsilon$$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 18])
    zlabel('$$R_{pinch}$$','Interpreter','latex','FontSize',20)
    title('$$R_{pinch}$$ vs. $$\varepsilon$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap cool
    drawnow
    hold off
end
function plot_r_pinch2(epsilon,h_div_w,r_pinch_wc)
    figure(3) % Squeezing coefficient
    surf(epsilon,h_div_w,r_pinch_wc,'FaceColor','interp')
    hold on
    
    %xlim([0 0.5])
    xlabel('$$\varepsilon$$','Interpreter','latex','FontSize',20)
    %ylim([1 3])
    ylabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 13])
    zlabel('$$R_{pinch}$$','Interpreter','latex','FontSize',20)
    title('$$R_{pinch}$$ vs. $$\varepsilon$$ and $\frac{h}{w}$','Interpreter','latex','FontSize',14)
    colormap cool
    drawnow
    hold off
end
function plot_alphas(h_div_w,win_w,alpha)
    figure(4) % Squeezing coefficient
    surf(h_div_w,win_w,alpha,'FaceColor','interp')
    hold on
    
    xlim([0 0.5])
    xlabel('$\frac{h}{w}$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 8])
    zlabel('$\alpha$','Interpreter','latex','FontSize',20)
    title('Squeezing coefficient, $$\alpha$$ vs. $$\frac{h}{w}$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap cool
    drawnow
    hold off
end
function plot_alphas_eps(epsilon,win_w,alpha_eps)
figure(5) % Squeezing coefficient
    surf(epsilon,win_w,alpha_eps,'FaceColor','interp')
    hold on
    xlim([0 0.5])
    xlabel('$$\varepsilon$$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlim([0 8])
    zlabel('$\alpha$','Interpreter','latex','FontSize',20)
    title('Squeezing coefficient, $$\alpha$$ vs. $$\varepsilon$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap summer
    drawnow
    hold off
end
function plot_volumes(flow_ratio,win_w,volumes)
    figure(6) % Dimensionless volume
    surf(flow_ratio,win_w,volumes,'FaceColor','interp')
    hold on
    
    xlim([0 10])
    xlabel('$\frac{q_d}{q_c}$','Interpreter','latex','FontSize',20)
    ylim([1 3])
    ylabel('$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',20)
    zlabel('$\frac{V}{hw^2}$','Interpreter','latex','FontSize',20)
    title('Dimensionless volume vs. flow rate ratio, $$\frac{q_{d}}{q_{c}}$$ and $$\frac{w_{in}}{w}$','Interpreter','latex','FontSize',14)
    colormap parula
    drawnow
    hold off
end
function plot_volumes_eps(flow_ratio,epsilon,volumes_eps)
    figure(7) % Dimensionless volume
    surf(flow_ratio,epsilon,volumes_eps,'FaceColor','interp')
    hold on
    
    xlim([0 10])
    xlabel('$\frac{q_d}{q_c}$','Interpreter','latex','FontSize',20)
    ylim([0 0.5])
    ylabel('$$\varepsilon$$','Interpreter','latex','FontSize',20)
    zlabel('$\frac{V}{hw^2}$','Interpreter','latex','FontSize',20)
    title('Dimensionless volume vs. flow rate ratio, $$\frac{q_{d}}{q_{c}}$$ and $$\varepsilon$$','Interpreter','latex','FontSize',14)
    colormap parula
    drawnow
    hold off
end
