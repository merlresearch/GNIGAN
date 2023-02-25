% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% Implementation of GradNI for Bilinear and Quadratic games. See the
% options (obj_type) below for the various game settings.


addpath('../gni');
addpath('../utils');
randn('state', 123); rand('twister', 123);
global Q q;

d = 10; % data dimensionality
N = 2; % number of players
maxit = 5000; % max-num optimizer iterations
tol = 1e-8;

% type of game payoff for each player.
obj_type = 3; % choices 0: nonconvex QPs
              %         1: convex QPs
              %         2: strictly convex QPs
              %         3: bilinear min-max, only makes sense for N=2

% generate data
Q = cell(N,1);
q = cell(N,1);
L = 0 ;
for i = 1:N
  Qi = full(sprandsym(N*d,1.0));
  be = (i-1)*d+1; en = i*d;
  Qii = Qi(be:en,be:en);
  eigQii = eig(Qii);
  mineig = min(eigQii);

  if (obj_type==1)
    % convex objective
    Qi(be:en,be:en) = Qii+max(-mineig,0)*eye(d);
  elseif (obj_type == 2)
    % strongly convex
    Qi(be:en,be:en) = Qii+max(-1.5*mineig,1)*eye(d);
  elseif (obj_type==3)
    if (i == 1)
      Qi(be:en,be:en) = 0;
    elseif (i == 2)
      Qi = -Q{1};
    end
    % uncomment to make saddle-point problem
    for i1 = 1:N
      for j1 = 1:N
        if (i1 == i) || (j1 == i)
          continue;
        else
          Qi((i1-1)*d+1:i1*d,(j1-1)*d+1:j1*d) = 0;
        end
      end
    end
  end

  q{i} = rand(N*d,1);
  Q{i} = Qi;
  L = max(L,norm(Q{i}));
end

% Lipschitz constant for VI
QQ = zeros(d*N,d*N);
for i = 1:N
  be = (i-1)*d+1; en = i*d;
  QQ(be:en,:) = Q{i}(be:en,:);
end
LF = norm(QQ);

x00 = zeros(N*d,1)/N*d; %rand(N*n,1); %
x0 = x00;

% Gradient Nikaido-Isoda minimization
% fun,gradfun,n,N,x0,eta,rho,tol,maxit
if obj_type == 0
    [res,xf] = gradNI(@funQ,@gradfunQ,d,N,x0,1/L,1/L,tol,maxit);
elseif obj_type == 1 || obj_type == 2
    [res,xf] = gradNI(@funQ,@gradfunQ,d,N,x0,1/L,1/L,tol,maxit);
else
    [res,xf] = gradNI(@funQ,@gradfunQ,d,N,x0,1/(2*L),1/(2*L),tol,maxit);
end

make_plot(obj_type, res);
