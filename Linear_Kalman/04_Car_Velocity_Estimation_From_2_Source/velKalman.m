function [posKf, velKf] = velKalman(z,gpsFlag)

persistent A H Q P R
persistent x
persistent firstRun

if(gpsFlag==1)
if (isempty(firstRun))
    dt = 1  ; 
    A = [1 dt;0 1] ;
    H = [1 0;0 1] ;
    Q = [1 0;0 1] ; 
    R = [1 0;0 16] ;
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
else
    measurement = z(2) ; 
    dt = 1/10  ; 
    A = [1 dt;0 1] ;
    h = [0 1] ;
    Q = [2 0;0 1] ; 
    R = 6 ;
    
    xp = A*x ; 
    Pp = A*P*A' +Q ; 
    K  = Pp*h'*inv(h*Pp*h' +R) ; 

    x =xp + K*(measurement-h*xp) ; 
    P = Pp- K*h*Pp ; 

posKf = x(1) ; 
velKf = x(2) ; 
end

end