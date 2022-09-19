nx = 8;  % number of states
sys = @Covid_Trans ;% function Xn = Covid_Trans(X, parameter)
ny = 1;               % number of observations
obs = @(k, xk, vk) xk(4);  
nu = 1;                % size of the vector of process noise
sigma_u = sqrt(10);
p_sys_noise   = @(u) normpdf(u, 0, sigma_u);
gen_x0 = @Covid_init;  
p_yk_given_xk = @Likelihood_Emission; % Observation likelihood
T = length(Observation); % Number of time steps
nv = 1; % dummy
gen_sys_noise = @(u) normrnd(0, sigma_u);  % dummy
x = zeros(nx,T);  y = zeros(ny,T);
u = zeros(nu,T);  v = zeros(nv,T);

% Epidemic model's Parameters
param.sigma = 1/3;
param.gamma = 1/4;
param.gamma_hat = 1/9;
param.epsilon = 1/2;
param.omega = 1.57;
param.omega_hat = 0.5;
param.sym = 0.75;
param.N = 7500000; % 2019 HK population
param.a = -0.3;
param.b = 0.5;
param.umin = -1;
param.umax = 0.1;

param.betaf = @(X,param)X(7)*param.Fatigue_PM3n_k + param.b;% learn function
pf.Ns              = 10000;                 % number of particles
pf.k               = 1;                   % initial iteration number
pf.w               = ones(pf.Ns, T)/pf.Ns;     % weights
pf.particles       = zeros(nx, pf.Ns, T); % particles
pf.gen_x0          = gen_x0;              % function for sampling from initial pdf p_x0
pf.p_yk_given_xk   = p_yk_given_xk;       % function of the observation likelihood PDF p(y[k] | x[k])
pf.gen_sys_noise   = gen_sys_noise;       % function for generating system noise # no used.
pf.parenets        = zeros(pf.Ns, T);

xh0 = gen_x0(Observation(:,1),1,param);
xh = zeros(nx, T); xh(:,1) = xh0;
yh = zeros(ny, T); yh(:,1) = obs(1, xh0, 0);
yhs = zeros(pf.Ns, T); yhs(:,1) = yh(:,1);
oev5 = 10;