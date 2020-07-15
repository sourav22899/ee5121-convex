clear all;
    
%%    
e = exp(1);
plot_function()
%% Gradient Descent 
x = [-1 0.7];
i = 0;
step_size = 0.1;
grad_f = [10^5 10^5]; % Initialize gradients
x_val = zeros(50,2);
while norm(grad_f) >= 0.001 % Stopping criteria
    grad_f(1) = e^(x(1)+3*x(2)-0.1)+e^(x(1)-3*x(2)-0.1)-e^(-x(1)-0.1);
    grad_f(2)= 3*e^(x(1)+3*x(2)-0.1)-3*e^(x(1)-3*x(2)-0.1); % Compute the gradients
    
    i = i+1;
    x_val(i,:) = x;
    x = x - step_size*grad_f; % Update x
end
x_val = x_val(1:i,:);
f_val_1 = zeros(size(x_val,1),1);
for i = 1:length(x_val)
   f_val_1(i) = eval_function(x_val(i,:)); 
end
fmin = eval_function(x);
fprintf('f_opt: %f, x_opt: %f %f\n',fmin,x);
plot_trajectory(x_val,'bo','-r')

%% Gradient Descent with backtracking line search
x = [-1 0.7];
alpha = 0.1;
beta = 0.5;
t = 1;
j = 0;
k = 0;
grad_f = [10^5 10^5]; % Initialize gradients
x_val1 = zeros(50,2);
while norm(grad_f) >= 0.01 % Stopping criteria
    grad_f(1) = e^(x(1)+3*x(2)-0.1)+e^(x(1)-3*x(2)-0.1)-e^(-x(1)-0.1);
    grad_f(2)= 3*e^(x(1)+3*x(2)-0.1)-3*e^(x(1)-3*x(2)-0.1); % Compute the gradients
    if eval_function(x-t*grad_f) > eval_function(x) - alpha*t*norm(grad_f)^2 % Backtracking Line Search
        t = beta*t;
    else
        j = j+1;
        x_val1(j,:) = x;
        x = x - t*grad_f;  % Update x          
    end
    k = k+1;
end
x_val1 = x_val1(1:j,:);
fmin = eval_function(x);
fprintf('f_opt: %f, x_opt: %f %f\n',fmin,x);
plot_trajectory(x_val1,'rx','-g')
%% Newton's Method with backtracking line search
x = [-1 0.7];
alpha = 0.1;
beta = 0.5;
t = 1;
j = 0;
k = 0;
grad_f = [10^5 10^5]; % Initialize gradients
H = [10^5 10^5;10^5 10^5]; % Initialize Hessian
x_val2 = zeros(50,2);
while norm(grad_f) >= 0.01
    grad_f(1) = e^(x(1)+3*x(2)-0.1)+e^(x(1)-3*x(2)-0.1)-e^(-x(1)-0.1);
    grad_f(2)= 3*e^(x(1)+3*x(2)-0.1)-3*e^(x(1)-3*x(2)-0.1); % Compute the gradients
    
    H(1,1) = e^(x(1)+3*x(2)-0.1)+e^(x(1)-3*x(2)-0.1)+e^(-x(1)-0.1);
    H(2,2) = 9*e^(x(1)+3*x(2)-0.1)+9*e^(x(1)-3*x(2)-0.1);
    H(1,2) = 3*e^(x(1)+3*x(2)-0.1)-3*e^(x(1)-3*x(2)-0.1); % Compute the Hessian
    H(2,1) = H(1,2);
    
    v = -inv(H)*grad_f';
    if eval_function(x+t*v') > eval_function(x) + alpha*t*grad_f*v % Backtracking Line Search
        t = beta*t;
    else
        j = j+1;
        x_val2(j,:) = x;
        x = x + t*v'; % Update x      
    end
    k = k+1;
end
x_val2 = x_val2(1:j,:);
fmin = eval_function(x);
fprintf('f_opt: %f, x_opt: %f %f\n',fmin,x);
plot_trajectory(x_val2,'go','-b')
%% Plot variation of f(x) with number of iterations 
plot_trend(x_val,'-xr')
hold on;
grid on;
grid minor
plot_trend(x_val1,'-og')
plot_trend(x_val2,'-sb')

%% Helper Functions
function [] = draw_line(p1, p2, style) % Draw lines
    theta = atan2(p2(2)-p1(2),p2(1)-p1(1));
    r = sqrt( (p2(1) - p1(1))^2 + (p2(2) - p1(2))^2);
    line = 0:0.01: r;
    x = p1(1) + line*cos(theta);
    y = p1(2) + line*sin(theta);
    plot(x, y, style);
end
function [] = plot_trajectory(x_val,marker,style) % Plot the trajectory of x
    plot(x_val(1,1),x_val(1,2),marker)
    j = size(x_val,1);
    hold on;
    for k = 2:j
        plot(x_val(k,1),x_val(k,2),marker);
        draw_line(x_val(k-1,:),x_val(k,:),style);
        hold on;
    end
end
function [f] = eval_function(x) % Evaluate f(x) at a given x
    e = exp(1);
    f = e^(x(1)+3*x(2)-0.1)+e^(x(1)-3*x(2)-0.1)+e^(-x(1)-0.1);
end
function [] = plot_function() % Plot equicontour lines of f(x)
    x = -1.5:0.02:0;
    y = -0.6:0.02:0.8;
    [X,Y] = meshgrid(x,y);
    m = size(x,1);
    e = exp(1);
    F = e.^(X+3*Y-0.1*ones(m))+e.^(X-3*Y-0.1*ones(m))+e.^(-X-0.1*ones(m));
    contour(X,Y,F,20,'-ok')
    hold on;
end
function [] = plot_trend(x_val,style) % Plot variation of f(x) with number of iterations
    f_val_1 = zeros(size(x_val,1),1);
    for i = 1:length(x_val)
       f_val_1(i) = eval_function(x_val(i,:)); 
    end
    plot(f_val_1,style)
end
