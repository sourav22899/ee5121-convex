clear all;
x = [-3.9265307; -3.171616; -1.6115988; -2.6679398; -1.7299714; -2.2185018; ...
     -2.06185; -1.4774499; -3.2095408; -2.0139385; -2.0965393; -2.8414848; ...
     -3.5516322; -2.3325005; -1.6889345; -1.4937155; -1.3103945; -1.3082423; ...
     -1.5221371; -1.8621796; -2.8784185; -3.3058351; -2.9418136; -3.5689305; ...
     -3.2715656; -1.816783; -2.6160985; -3.6369299; -3.609496; -3.8213899; ...
     -3.5639197; -2.966715; -1.9473222; -3.0470691; -2.8955875; -3.2029692; ...
     -2.2688964; -2.321299; -1.1585153; -1.8993455; -3.5771792; -2.6473229; ...
     -1.4699478; -3.7978927; -2.0968345; -4.011844; -2.2415905; -1.3737454; ...
     -2.0935937; -1.4260492];

y = [5.7992251; 7.313062; 7.5592434; 7.6911348; 5.5113079; 7.7442101; 7.7091849; ...
     6.0549104; 7.5170875; 7.6045473; 5.1354212; 5.0671844; 7.3910732; ...
     7.6949226; 5.3469286; 7.3473664; 6.8715471; 6.7842012; 5.728363; 7.7633148; ...
     7.7677261; 5.4778857; 5.0690285; 5.524619; 7.6772318; 5.3181407; 7.614868; ...
     7.352473; 6.0303455; 5.8476992; 5.8479253; 5.3237261; 5.1703804; 5.4245981; ...
     7.7991795; 5.5734007; 7.8705366; 5.1617927; 6.1579013; 5.4067639; ...
     7.2445803; 7.6805233; 6.1180277; 7.3691475; 7.646388; 6.147951; 7.7414349; ...
     7.2054473; 5.2385698; 5.8594283];
 
%% Optimization Objective
m = size(x,1);
A = [-2*x -2*y ones(m,1)]; % Building A matrix
b = -x.^2 -y.^2; % Building b vector
cvx_begin
    variables z(3)
    minimize (norm(A*z-b,2)) % L2-norm minimzation
cvx_end

%% Plot best fir circle and data points
t = linspace(0, 2*pi,1000);
x_c = z(1);
y_c = z(2);
r = sqrt(x_c^2+y_c^2-z(3));
plot(x,y,'o',r*cos(t)+x_c,r*sin(t)+y_c,'-')
grid on;
grid minor
