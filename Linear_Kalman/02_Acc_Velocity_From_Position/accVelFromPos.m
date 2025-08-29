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
accEkfSaved = zeros(Nsamples,1) ;


for k=1:Nsamples
    
[posKf velKf accKf Px] = accKalman(posNoise(k)) ; 
    posEkfSaved(k) =posKf ; 
    velEkfSaved(k) = velKf ; 
    accEkfSaved(k) = accKf ; 
    posCov(k) = Px(1) ; 
    velCov(k) = Px(2) ; 
    accCov(k) = Px(3) ; 
end

figure ; 
plot(t, pos,'linewidth',2) ; hold on ; grid minor ; 
plot(t, posNoise,'linewidth',2) ; 
plot(t, posEkfSaved,'linewidth',2) ; 
legend('Position Ground Truth','Position with Noise','Kalman Filtered Position') ; 

figure ; 
plot(t,vel,'linewidth',2) ; hold on ; grid minor ; 
plot(t,velEkfSaved,'LineWidth',2) ; 
legend('Velocity Ground Truth','Kalman Filtered Velocity') ; 

figure ; 
plot(t, acc,'LineWidth',2) ; hold on ; grid minor ; 
plot(t,accEkfSaved,'LineWidth',2) ; 
legend('Acc Ground Truth','Kalman Filtered Acc') ; 
