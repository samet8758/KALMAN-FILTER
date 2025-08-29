clear all
close all
clc

load('posDataFromAcc.mat') ;
dt = 0.02; % time step (s)
t  = 0:dt:20;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 1);
posEkfSaved = zeros(Nsamples,1) ;
velEkfSaved = zeros(Nsamples,1) ;

for k=1:Nsamples
    
[posKf velKf] = velKalman(posNoise(k)) ; 
    posEkfSaved(k) =posKf ; 
    velEkfSaved(k) = velKf ; 
    
end

% What if there is no Kalman Filtering ? 
count = 1 ; 
for(k = 2 :Nsamples )
    velDif(count) = (posNoise(k)-posNoise(k-1))/0.02 ; 
    count = count + 1 ; 
end


figure ; 
plot(t, pos,'linewidth',2) ; hold on ; grid minor ; 
plot(t, posNoise,'linewidth',2) ; 
plot(t, posEkfSaved,'linewidth',2) ; 
legend('Position Ground Truth','Position with Noise','Kalman Filtered Position') ; 

figure ; 
subplot(1,2,1) ; 
plot(t,vel,'linewidth',2) ; hold on ; grid minor ; 
plot(t,velEkfSaved,'LineWidth',2) ; 
legend('Velocity Ground Truth','Kalman Filtered Velocity') ;
subplot(1,2,2) ; 
plot(t,vel,'LineWidth',2) ; hold on ; grid minor ; 
plot(t(1:1000), velDif,'linewidth',2) ; 
legend('Velocity Ground Truth','Velocity From Differentiating') ; 
