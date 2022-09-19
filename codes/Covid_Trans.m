function Xn = Covid_Trans(k, X, param, vk)
% Tranistion model
sigma = param.sigma;
gamma = param.gamma;
gamma_hat = param.gamma_hat;
epsilon = param.epsilon;
omega = param.omega;
omega_hat = param.omega_hat;
sym = param.sym;
N = param.N;
Xn = X;
beta_k = param.betaf(Xn,param);

%S, E, P,Y, A, R, beta
Xn(1) = round(X(1) - beta_k.*(omega*X(3)+omega_hat*X(5)+X(4))./N.*X(1));%S
Xn(2) = round(X(2) + beta_k.*(omega*X(3)+omega_hat*X(5)+X(4))./N.*X(1) - sigma*X(2));%E
Xn(3) = round(X(3) + sym*sigma*X(2) - epsilon*X(3));%P
Xn(4) = round(X(4) + epsilon*X(3)   - gamma*X(4));%Y
Xn(5) = round(X(5) + (1-sym)*sigma*X(2) - gamma_hat*X(5));%A
Xn(6) = round(X(6) + gamma*X(4) + gamma_hat*X(5));%R

% Beta is same.
Xn(7) = Xn(7) + 0.1*randn();

Xn(8) = sym*beta_k.*(omega*X(3)+omega_hat*X(5)+X(4))./N.*X(1);
end