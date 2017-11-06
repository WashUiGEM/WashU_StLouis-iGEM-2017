function IeffCurve = IeffCurve(tspan,I,lambda)
[t_les, l] = ode45(@(t,l) lesions(l, I, lambda),tspan, 0);
Ieff = arrayfun(@(x,y) x/(500*y), l, t_les);
Ieff(1) = I;

IeffCurve = fit(t_les,Ieff,'exp1');
end