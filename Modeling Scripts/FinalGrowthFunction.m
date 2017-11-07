clear
clc
tspan = 0:.01:7.99;
dsupData = [1.76385542200000,1.06024096400000,0.651655629000000,0.678122935000000,0.752129472000000,0.606222222000000,0.658515284000000,0.765597148000000,0.927687916000000,0.746999077000000;0.963855422000000,0.865060241000000,0.645695364000000,0.550561798000000,0.602214651000000,0.589333333000000,0.558078603000000,0.637254902000000,0.581351094000000,0.506001847000000;0.583132530000000,0.590361446000000,0.600662252000000,0.459352280000000,0.432708688000000,0.429333333000000,0.408733624000000,0.455436720000000,0.488106565000000,0.421975993000000;0.0144578310000000,0.0168674700000000,0.570860927000000,0.268341044000000,0.301533220000000,0.313777778000000,0.278602620000000,0.348484848000000,0.296860133000000,0.227146814000000];
nonResist = [0.533622560000000,0.457820738000000,0.782442748000000,0,0.781376518000000;0.319956616000000,0.217047452000000,0.656488550000000,0.660583942000000,0.408906883000000;0.0368763560000000,0.00878734600000000,0.374045802000000,0.299270073000000,0.425101215000000;0,0,0.0725190840000000,0.0839416060000000,0.0526315790000000];
Nmax = 1.9823*10^10;
N0 = 3.13*10^5;
Nmin = 312999;
f=0.9174;
c=0.74;
k1=0.008098;
k2=0.003947;
I_obs=0.03;
I_test= .07;
lambda = .000583333;
noUV=false;
td = 5.5;
fix = true;

[t0, N0UV] = ode45(@(t,N) dN(N,Nmax,Nmin,c),0:.01:td,N0); 
N0U = N0UV(td*100+1);
lambdaRes = paramEst(tspan,I_obs,.0002,.01,f,k1,k2,.0001,dsupData);
lambdaNorm = paramEst(tspan,I_obs,.0002,.01,f,k1,k2,.0001,nonResist);

Ieff_dsup = IeffCurve(tspan, I_test, lambdaRes);
Ieff_norm = IeffCurve(tspan,I_test,lambdaNorm);

[tdie, sdie1] = ode45(@(t,S) dS(t,f,k1,k2,Ieff_dsup,tspan), tspan,1);
[tdie, sdie2] = ode45(@(t,S) dS(t,f,k1,k2,Ieff_norm,tspan), tspan,1);

if min(sdie1)<0
    sdie1 = 0;
else
    sdie1 = min(sdie1);
end
if min(sdie2)<0
    sdie2 = 0;
else
    sdie2 = min(sdie2);
end

dSurv_dsup = rot90(arrayfun(@(t) dS(t,f,k1,k2,Ieff_dsup,tspan), tspan),3);
dSurv_dsup = dSurv_dsup*-((1-sdie1)/sum(dSurv_dsup));
dSurv_norm = rot90(arrayfun(@(t) dS(t,f,k1,k2,Ieff_norm,tspan), tspan),3);
dSurv_norm = dSurv_norm*-((1-sdie2)/sum(dSurv_norm));

dNum_norm = zeros(length(tspan),1);
dNum_norm(1) = dN(N0U,Nmax,Nmin,c)*.01;
dNum_dsup = zeros(length(tspan),1);
dNum_dsup(1) = dN(N0U,Nmax,Nmin,c)*.01;

Num_norm = zeros(length(tspan),1);
Num_dsup = zeros(length(tspan),1);

for i = 1:1:length(tspan)
if i == 1
    Num_norm(i) = N0U+dNum_norm(i)+N0U*dSurv_norm(i);
else
    dNum_norm(i) = dN(Num_norm(i-1),Nmax,Nmin,c)*.01;
    Num_norm(i) = Num_norm(i-1)+dNum_norm(i)+N0U*dSurv_norm(i)+sum(dNum_norm(1:i-1).*rot90(dSurv_norm(1:i-1),2));
end
end
for i = 1:1:length(tspan)
if i == 1
    Num_dsup(i) = N0U+dNum_dsup(i)+N0U*dSurv_dsup(i);
else
    dNum_dsup(i) = dN(Num_dsup(i-1),Nmax,Nmin,c)*.01;
    Num_dsup(i) = Num_dsup(i-1)+dNum_dsup(i)+N0U*dSurv_dsup(i)+sum(dNum_dsup(1:i-1).*rot90(dSurv_dsup(1:i-1),2));
end
end

normGrow = zeros(length(t0)+length(tspan),1);
dsupGrow = zeros(length(t0)+length(tspan),1);

tGrow = 0:.01:(length(normGrow)-1)/100;

normGrow(1:length(t0)) = N0UV;
dsupGrow(1:length(t0)) = N0UV;

normGrow(length(t0)+1:end) = Num_norm;
dsupGrow(length(t0)+1:end) = Num_dsup;

plot(tGrow,normGrow)
hold on
plot(tGrow,dsupGrow)