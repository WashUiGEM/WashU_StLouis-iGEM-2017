function dl = lesions(l,I,lambda)
if I>0
    dl = 500*I - lambda*l;
    if dl<0
        dl=0;
    end
else
    dl=0;
end