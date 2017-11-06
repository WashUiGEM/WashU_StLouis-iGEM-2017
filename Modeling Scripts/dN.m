function growth = dN(N,Nmax,Nmin,c)
if (N<=0)
    growth=0;
else
    growth=exp(21-6230/310.15)*N*(1-N/Nmax)*((1-Nmin/N)^c);
end
end