clear all;
%% L1 Norm minimization
data = load('Q5_data.mat');
A = data.A;
b = sin(data.a)';
cvx_begin
    variables x(4);
    minimize (norm(A*x-b,1));
cvx_end
%% Linear Programming formulation
cvx_begin
    variables x(4) z(20);
    minimize sum(z(:)); % minimize 1^T.z
    subject to 
    A*x-b <= z;
    -A*x+b <= z;           
cvx_end

%% Plot of sin(x) and the best fit cubic polynomial
plot(A(:,2),b,'-s');
hold on;
grid on;
grid minor
plot(A(:,2),A*x,'-o');