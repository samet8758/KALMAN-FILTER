function [posKf, velKf] = velKalman(z)

persistent A H Q P R
persistent x
persistent firstRun

if (isempty(firstRun))
    dt = 0.02  ; 
    A = [1 dt;0 1] ;
    H = [1 0] ;
    Q = [0.5 0;0 0.35] ; 
    R = 16 ;
    x = [0;0] ; %% Initial states [position, velocity] 
    P = eye(2)*5 ;
    firstRun = 1 ;
end

xp = A*x;  
Pp = A*P*A' + Q;    

K = Pp*H'*inv(H*Pp*H' + R);

x = xp + K*(z - H*xp);
P = Pp - K*H*Pp;  



posKf = x(1) ; 
velKf = x(2) ; 

end