%% 
clear all;
data = load('Q4_data.mat');
X = data.xs;
U = data.us;
delta = 0.01;
%% No sparsity constraints 
cvx_begin
    variables A(10,10) B(10,4);
    minimize (norm(X(:,2:100)-A*X(:,1:99)-B*U,'fro'));
    % minimize ||Y-AX-BU||_F, for notations, please refer the report.
cvx_end
%% Solution with sparsity constraints
card = zeros(36,1);
f_opt_val = zeros(36,1);
i = 1;
for lambda = 0:2:70
    cvx_begin quiet
        variables A(10,10) B(10,4);
        minimize (norm(X(:,2:100)-A*X(:,1:99)-B*U,'fro')+lambda*(norm(A(:),1)+norm(B(:),1)));
        % minimize ||Y-AX-BU||_F + lambda*(||A||_1+||B||_1), for notations, please refer the report.
    cvx_end
    f_opt = norm(X(:,2:100)-A*X(:,1:99)-B*U,'fro');
    f_opt_val(i) = f_opt;
    card(i) = length(find(abs(A) > delta)) + length(find(abs(B) > delta));
    i = i+1;
    fprintf('lambda: %d, card(A): %d, card(B): %d, f_opt: %f\n',lambda,length(find(abs(A) > delta)),length(find(abs(B) > delta)),f_opt);
end
%% Plot the trade-off curve
plot(card,f_opt_val,'-o')
grid on;
grid minor
