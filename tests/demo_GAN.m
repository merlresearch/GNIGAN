% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% Implementation of Linear GAN.

addpath('../gni');
addpath('../utils');
randn('state',1234); rand('twister', 1234);

tol=1e-8; maxit=100; stepsize=0.001; rho=1;verbose=1;
L = 0.01; % Lipschitz constant.
d = 10; %dimensinality of data
n = 1000; % number of data points.
num_players=2;
obj_type=4; % see demo_Q.m for other options.

% generate data.
mu = 2*ones(d,1); % mean of the real data.
X = mu*ones(1,n) + randn(d,n); % mean 3 unit variance real data.
Z = rand(d,n); % zero mean unit variance fake data.
w1 = ones(d,1)/d; w2=ones(d,1)/d; % initial weights for the GAN model.

x0 = [w1, w2];

% see the returns for gradNIGAN to see what res and xf below are.
[res,xf] = gradNIGAN(@funLinearGAN, @gradLinearGAN, ...
    d, num_players, x0, X, Z, stepsize, rho, tol,maxit, verbose);
make_plot(obj_type, res);
