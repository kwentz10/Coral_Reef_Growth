% Simulating the growth and drowning of coral reefs
% Created 1/27/2015

%% INITIALIZE

clear all
close all
figure(1)

%Sea Level Oscillation-----------
%SL = A*sin(2*pi*t/P_l); m

A = 100; %m
P_l = 10^5; %every 100,000 yr
P_m = 4*10^4; %every 40,000 yr
P_s = 2*10^4; %every 20,000 yr
dt = 1000; %yr
t = 0:dt:6*10^5;
tmax = length(t);

%Coral Reef Growth---------------
%G = Gm*tanh(I*exp(-k*z)/Ik); m yr-1

Gm = 10/1000; %m yr-1 (10-15);
k = 0.04; %m-1 (0.04-0.16)
I = 2000; %muE m-2 s-1 (2000-2250)
Ik = 50; %muE m-2 s-1 (50-450)

%Subsidence Rate-----------------

angle = 85; %degrees
horz_S = 8; %rate of subsidence in horizontal direction cm yr-1
S = (horz_S/sind(angle))/100; %rate of subsidence in hypotenous direction m yr-1

%% RUN

Coral_height(1)=0;

for i=1:tmax
    
    Sub(i)=(S*dt)*i;
    SL(i) = A*sin(2*pi*(t(i)/P_l));
    G(i) = Gm*tanh(I*exp(-k*(Sub(i)+SL(i)))/Ik)*dt;
    Coral_height(i+1) = Sub(i)-(Coral_height(i) + G(i));

end

%% FINALIZE

% area(t,Sub,50000,'FaceColor','black')
plot(t,Sub,'Color','black','linewidth',2)
hold on
% area(t,SL,50000,'FaceColor','blue')
plot(t,SL,'Color','blue','linewidth',2)
% area(t,G,50000,'FaceColor','pink')
plot(t,Coral_height(1:end-1),'Color','magenta','linewidth',2)
hold off

legend('Subsidence','Sea Level Height','Coral Reef')

xlabel('Time (yr)','fontname','arial','fontsize',21)
ylabel('Depth (m)','fontname','arial','fontsize',21)
set(gca,'fontsize',18,'fontname','arial')
set(gca,'YDIR','reverse')


%% PROBLEMS
%I cannot seem to get "area" to work...also not sure if I got the coral height correct... 
%I was going to add in sea level oscillations at 100,000, 40,000, and
%20,000 years but ran out of time! (That is why the variables are there, but unused)


