function prior = Covid_init(obs,P,param)
    % init the particle at time step 1.
    prior = zeros(P,8);
    
    S_mean = param.N-4*(obs);
    Y_mean = obs;
    P_mean = obs;
    E_mean = obs;
    A_mean = obs;
    R_mean = 0; % Not important
    
    prior(:,1) = poissrnd(S_mean,P,1);
    prior(:,2) = poissrnd(E_mean,P,1);
    prior(:,3) = poissrnd(P_mean,P,1);
    prior(:,4) = poissrnd(Y_mean,P,1);
    prior(:,5) = poissrnd(A_mean,P,1);
    prior(:,6) = poissrnd(R_mean,P,1);
    prior(:,7) = unifrnd(param.umin,param.umax,P,1); % for a
    prior(:,8) = 0;
end