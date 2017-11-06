function lambdaEstimate = paramEst(tspan,I,lambda1,lambda2,f,k1,k2,precision,survivalData)
Ieff = {IeffCurve(tspan,I,lambda1),IeffCurve(tspan,I,lambda2)};
[t_surv,surv1] = ode45(@(t,S) dS(t,f,k1,k2,Ieff{1},tspan),0:.01:5,1);
plot(t_surv,surv1)
hold on
[t_surv,surv2] = ode45(@(t,S) dS(t,f,k1,k2,Ieff{2},tspan),0:.01:5,1);
plot(t_surv,surv2)
curveLoc = [surv1(101),surv1(201),surv1(301),surv1(401);
    surv2(101),surv2(201),surv2(301),surv2(401)];
squareDif = [sum(sum([(survivalData(1,~isoutlier(survivalData(1,1:end)))-curveLoc(1,1)).^2,(survivalData(2,~isoutlier(survivalData(2,1:end)))-curveLoc(1,2)).^2,(survivalData(3,~isoutlier(survivalData(3,1:end)))-curveLoc(1,3)).^2,(survivalData(4,~isoutlier(survivalData(4,1:end)))-curveLoc(1,4)).^2]));
    sum(sum([(survivalData(1,~isoutlier(survivalData(1,1:end)))-curveLoc(2,1)).^2,(survivalData(2,~isoutlier(survivalData(2,1:end)))-curveLoc(2,2)).^2,(survivalData(3,~isoutlier(survivalData(3,1:end)))-curveLoc(2,3)).^2,(survivalData(4,~isoutlier(survivalData(4,1:end)))-curveLoc(2,4)).^2]))];
if (squareDif(1,1)-squareDif(2,1))>precision
    lambdaEstimate = paramEst(tspan,I,mean([lambda1,lambda2]),lambda2,f,k1,k2,precision,survivalData);
elseif (squareDif(1,1)-squareDif(2,1))< -precision
    lambdaEstimate =  paramEst(tspan,I,lambda1,mean([lambda1,lambda2]),f,k1,k2,precision,survivalData);
else
    plot(t_surv,surv2,'--k','LineWidth',3)
    lambdaEstimate = mean([lambda1,lambda2]);
end
end