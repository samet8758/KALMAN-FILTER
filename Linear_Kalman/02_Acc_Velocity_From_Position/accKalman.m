function [posKf, velKf, accKf, Px] = accKalman(z)

persistent A H Q P R
persistent x
persistent firstRun


if (isempty(firstRun))
    dt = 0.02  ; 
    A = [1 dt 0.5*dt^2;0 1 dt;0 0 1] ;
    H = [1 0 0] ;
    %Q = [1 0 0;0 1 0;0 0 1];
    Q = 10*[dt^5/20 dt^4/8 dt^3/6;dt^4/8 dt^3/3 dt^2/2;dt^3/6 dt^2/2 dt];
    R = 100 ;
    x = [0;0;0] ; %% Initial states
    P = eye(3)*5 ;
    firstRun = 1 ;
end

xp = A*x;  
Pp = A*P*A' + Q;    

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;  



posKf = x(1) ; 
velKf = x(2) ; 
accKf = x(3) ; 

Px = [P(1,1), P(2,2), P(3,3)] ; 

end