function p = Likelihood_Emission(k,Y,X,param)

if any(X(1:6)<0)
    p = 0;
elseif X(7)*param.Fatigue_PM3n_k + param.b <= 0
    p = 0;
else
    x = Y - X(8);
    p = normpdf(x,0,param.oev);
end

if X(7)>param.umax || X(7) <param.umin
    p = 0;
end

end