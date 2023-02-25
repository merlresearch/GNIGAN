% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% Input:
% fun - evaluate function value for each player i using fun(i,x)
% gradfun - evaluate gradient for each player i using gradfun(i,x)
% n - dimension of x_i
% N - number of players
% x0 - initial guess
% eta - perturbation used in constructing V_i
% rho - step-size for descent on GNI
% tol - convergence tolerance
% maxit - max #iters
% Output:
% res - array in which each row is: iter# V 0.5*norm(df)^2
% x1 - final iterate
function [res,x1] = gradNI(fun,gradfun,n,N,x0,eta,rho,tol,maxit)

flag = 0;

[V0,df0] = evalV(fun,gradfun,n,N,eta,x0);
res = [0 V0 0.5*norm(df0)^2, x0(1), x0(2)];

%rho = 1/(3*L^2);

it = 0;

while 1

  % this implements the QN version
  dV = zeros(n*N,1);
  for i = 1:N
    inds = [(i-1)*n+1:i*n];
    x_1i = x0; x_1i(inds) = x_1i(inds)-eta*df0(inds);
    df_1i = gradfun(i,x_1i);
    x_2i = x0; x_2i(inds) = x_2i(inds)+eta*df_1i(inds);
    df_2i = gradfun(i,x_2i);
    dV = dV+df_2i-df_1i;
  end

  % update the step
  x1 = (x0 - rho*dV);

  % evaluate V at the current point
  [V1,df1] = evalV(fun,gradfun,n,N,eta,x1);

  res = [ res ; it V1 0.5*norm(df1)^2, x1(1), x1(2)];

  % print function value
  fprintf('%d \t %0.3e \t %0.3e\n',it,V1,norm(dV));

  if (abs(V0-V1) <= tol)
    break;
  end

  V0 = V1;
  x0 = x1;
  df0 = df1;
  it = it + 1;

  if it == maxit
    fprintf('Max iteration limit reached!!!\n');
    flag = 1;
    break;
  end
end

function [V,df] = evalV(fun,gradfun,n,N,eta,x)

V = 0;
df = zeros(n*N,1);
for i = 1:N
  be = (i-1)*n+1; en = i*n;
  dff = gradfun(i,x);
  dfi = dff(be:en);
  xdx = x ; xdx(be:en) = xdx(be:en)-eta*dfi;
  V = V + fun(i,x) - fun(i,xdx);
  df(be:en) = dfi;
end
