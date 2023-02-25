% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% Input:
% fun - evaluate function value for each player i using fun(i,x)
% gradfun - evaluate gradient for each player i using gradfun(i,x)
% n - dimension of x_i
% N - number of players
% x0 - initial guess
% rho - step-size for descent on GNI
% tol - convergence tolerance
% maxit - max #iters
% Output:
% res - array in which each row is: iter# 0.5*norm(df)&2
% x1 - final iterate
function [res,x1] = gradient(gradfun,n,N,x0,eta,tol,maxit)

F0 = F(gradfun,x0,n,N);
it = 0;
res = [0 0.5*norm(F0)^2, x0(1), x0(2)];

while 1
  %xh = x0 - eta*F0;
  %Fh = F(gradfun,xh,n,N);
  x1 = x0 - eta*F0;
  F0 = F(gradfun,x1,n,N);

  it = it+1;
  err = norm(F0);
  res = [ res ; it 0.5*err^2, x1(1), x1(2)];
  fprintf('%d \t %0.3e \n',it,err);
%   if it == 1
%     x0 = x1;
%   else
%     x0 = (it-1)/it*x0 + 1/it*x1;
%   end
  x0 = x1;
  if (err < tol || it >= maxit)
    break;
  end
end

function df = F(gradfun,x,n,N)

df = zeros(n*N,1);
for i = 1:N
  be = (i-1)*n+1; en = i*n;
  dff = gradfun(i,x);
  dfi = dff(be:en);
  df(be:en) = dfi;
end
