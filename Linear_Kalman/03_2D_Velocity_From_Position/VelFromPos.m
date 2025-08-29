clear all
close all
clc

load('posDataFromAcc.mat') ;
dt = 0.02; % time step (s)
t  = 0:dt:20;

Nsamples = length(t);

Xsaved = zeros(Nsamples, 1);
posxEkfSaved = zeros(Nsamples,1) ;
velxEkfSaved = zeros(Nsamples,1) ;
posyEkfSaved = zeros(Nsamples,1) ;
velyEkfSaved = zeros(Nsamples,1) ;

for k=1:Nsamples
    
[posxKf velxKf posyKf velyKf] = velKalman(posNoise(:,k)) ; 
    posxEkfSaved(k) =posxKf ; 
    velxEkfSaved(k) = velxKf ;
    posyEkfSaved(k) =posyKf ; 
    velyEkfSaved(k) = velyKf ;
    
end


figure ; 
subplot(1,2,1) ; 
plot(t, pos(1,:),'linewidth',2) ; hold on ; grid minor ; title('X Position') ; 
plot(t, posNoise(1,:),'linewidth',2) ; 
plot(t, posxEkfSaved,'linewidth',2) ; 
legend('Position Ground Truth','Position with Noise','Kalman Filtered Position') ; 

subplot(1,2,2) ; 
plot(t, pos(2,:),'linewidth',2) ; hold on ; grid minor ; title('Y Position') ; 
plot(t, posNoise(2,:),'linewidth',2) ; 
plot(t, posyEkfSaved,'linewidth',2) ; 
legend('Position Ground Truth','Position with Noise','Kalman Filtered Position') ; 

figure ; 
subplot(1,2,1) ; 
plot(t,vel(1,:),'linewidth',2) ; hold on ; grid minor ; title('X Velocity') ; 
plot(t,velxEkfSaved,'LineWidth',2) ; 
legend('Velocity Ground Truth','Kalman Filtered Velocity') ;
subplot(1,2,2) ; 
plot(t,vel(2,:),'LineWidth',2) ; hold on ; grid minor ; title('Y Velocity') ; 
plot(t, velyEkfSaved,'linewidth',2) ; 
legend('Velocity Ground Truth','Velocity From Differentiating') ; 
