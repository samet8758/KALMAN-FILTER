clear all
close all
clc

load('workData.mat') ; 
Nsamples = size(data.time,2);

Xsaved = zeros(Nsamples, 1);
posEkfSaved = zeros(Nsamples,1) ;
velEkfSaved = zeros(Nsamples,1) ;

gpsCount = 1 ; 
for k=1:Nsamples
 
if(data.gps_time(gpsCount)==data.time(k))
    gpsFlag = 1 ; 
    pos = [data.x_gps(gpsCount);data.v_wheel(k)] ; 
    gpsCount = gpsCount+1 ; 
else
    gpsFlag = 0 ; 
    pos = [0; data.v_wheel(k)] ; 
end



[posKf velKf] = velKalman(pos,gpsFlag) ; 
    posEkfSaved(k) =posKf ; 
    velEkfSaved(k) = velKf ; 
    
end


figure ; 
plot(data.time, data.x_true,'linewidth',2) ; hold on ; grid minor ; 
plot(data.gps_time, data.x_gps,'linewidth',2,'Marker','o') ; 
plot(data.time, posEkfSaved,'linewidth',2) ; 
legend('Position Ground Truth','Position From GPS','Kalman Filtered Position') ; 

figure ; 
plot(data.time, data.v_true,'linewidth',2) ; hold on ; grid minor ; 
plot(data.time, data.v_wheel,'linewidth',2) ; 
plot(data.time, velEkfSaved,'linewidth',2) ; 
legend('Velocity Ground Truth','Velocity From Wheel','Kalman Filtered Velocity') ; 
