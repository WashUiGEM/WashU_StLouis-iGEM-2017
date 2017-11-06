function Survival = dS(t,f,k1,k2,Ieff,tspan)
    %Survival = (1-f)*exp(-k1*(I*4.4/26)*t)+f*exp(-k2*(I*4.4/26)*t);
if(isfloat(Ieff)==true)
    Survival = -3600*f*k2*Ieff*exp(-k2*Ieff*(t*3600))-3600*(1-f)*Ieff*k1*exp(-k1*Ieff*(t*3600));
else
    Idif = fit(rot90(tspan,3),differentiate(Ieff,tspan),'exp1');
    Survival = f*exp(-3600*k2*t*feval(Ieff,60*t))*(-216000*k2*t*feval(Idif,60*t)-3600*k2*feval(Ieff,60*t))+(1-f)*exp(-3600*k1*t*feval(Ieff,60*t))*(-216000*k1*t*feval(Idif,60*t)-3600*k1*feval(Ieff,60*t));
end
 if(Survival>0)
        Survival = 0;
 end
end