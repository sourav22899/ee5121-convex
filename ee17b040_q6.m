clear all;
C = [1 -0.76 0.07 -0.96; -0.76 1 0.18 0.07; 0.07 0.18 1 0.41; -0.96 0.07 0.41 1];
cvx_begin sdp % semi definite constraints
    variable X(4,4) symmetric;
    minimize (norm(C-X,'fro')); % Minimize ||C-X||_F
    subject to
    X >= 0; % X is semi definite
    X(1,1) == 1;
    X(2,2) == 1;
    X(3,3) == 1;
    X(4,4) == 1;
cvx_end