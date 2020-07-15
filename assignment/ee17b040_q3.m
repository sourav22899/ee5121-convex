clear all;
A = [-1 -1; -1 1; 1 -1; 2 1];
b = [1/2; 2; 2; 4];
c = [-2; -1];
%% Primal problem
cvx_begin
    variables x(2);
    minimize (c'*x);
    subject to
    A*x <= b;
    x(1)*(x(1)-1) <= 0;
    x(2)*(x(2)-1) <= 0;
cvx_end
%% Dual problem
cvx_begin
    variables y(4);
    maximize (-(b'*y)+(min(0,c(1)+A(:,1)'*y)+min(0,c(2)+A(:,2)'*y)));
    subject to
    y >= 0;
cvx_end


