% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% Input:
% fun - evaluate function value for each player i using fun(i,x)
% gradfun - evaluate gradient for each player i using gradfun(i,x)
% n - dimension of x_i
% N - number of players
% x0 - initial guess, it has two parts, [w1, w2] (we assume only two player
% X - real data, nxp1 matrix
% Z - fake data, nxp2 matrix.
% eta - perturbation used in constructing V_i
% rho - step-size for descent on GNI
% tol - convergence tolerance
% maxit - max #iters
% Output:
% res - array in which each row is: iter# V 0.5*norm(df)^2
% x1 - final iterate
function [res,x1] = gradNIGAN(fun,gradfun,n,N,x0,X,Z,eta,rho,tol,maxit, verbose)
    fprintf('grad NI...\n');
    flag = 0;
    w1=x0(:,1); w2=x0(:,2);

    [V0,df0] = evalV(fun,gradfun,n,N,eta, w1, w2, X, Z);
    [acc_D, acc_G]= accuracy(w1, w2, X, Z);
    res = [0 0.5*norm(df0, 'fro')^2, acc_D, acc_G, V0];

    it = 0;

    while 1
      w1=x0(:,1); w2=x0(:,2);
      % this implements the QN version
      dV = zeros(n,N);
      w1_1 = w1 - eta*df0(:,1);
      df1(:,1) = gradfun(1, w1_1, w2, X, Z);
      w1_2 = w1 + eta*df1(:,1);
      df2(:,1) = gradfun(1, w1_2, w2, X, Z);
      dV(:,1) = df2(:,1) - df1(:,1);

      w2_1 = w2 - eta*df0(:,2);
      df1(:,2) = gradfun(2, w1, w2_1, X, Z);
      w2_2 = w2 + eta*df1(:,2);
      df2(:,2) = gradfun(2, w1, w2_2, X, Z);
      dV(:,2) = df2(:,2) - df1(:,2);

      % update the step
      x1 = (x0 - rho*dV);

      % evaluate V at the current point
      [V1,df1] = evalV(fun,gradfun,n,N,eta,x1(:,1), x1(:,2), X, Z);

      [acc_D, acc_G]= accuracy(x1(:,1), x1(:,2), X, Z);
      res = [ res ; it 0.5*norm(df1, 'fro')^2, acc_D, acc_G, V1];

      % print function value
      if verbose == 1
        fprintf('%d \t %0.3e \t %0.3e accuracy=(D=%0.4f G=%0.4f)\n',it,V1,norm(dV, 'fro'), acc_D, acc_G);
      end

      V0 = V1;
      x0 = x1;
      df0 = df1;
      it = it + 1;

      if it == maxit
        fprintf('Max iteration limit reached!!!\n');
        res=res(1:maxit,:);
        flag = 1;
        break;
      end
    end
end

function [V,df] = evalV(fun,gradfun,n,N,eta, w1, w2, X,Z)
V = 0;
df = zeros(n,N);
dff1 = gradfun(1, w1, w2, X, Z);
w = w1; w = w - eta*dff1; % one step descent
V = V + fun(1, w1, w2, X, Z) - fun(1, w, w2, X, Z);
df(:,1) = dff1;

dff2 = gradfun(2, w1, w2, X, Z);
w = w2; w = w - eta*dff2;
V = V + fun(2, w1, w2, X, Z) - fun(2, w1, w, X, Z);
df(:,2) = dff2;
end
