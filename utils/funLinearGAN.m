% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

% w1 and w2 are player weights to be learned. X is dxn1 matrix of real data
% Z is dxn2 of fake data, where d is the dimensionality and n is the
% number of points.

function f = funDCGAN(player,w1,w2, X, Z)
if (player == 1)
   f = -mean(mylog(w1'*X)) - mean(mylog(1-w1'*(diag(w2)*Z))); % + norm(w1)^2 + norm(w2)^2;
else
   f = -mean(mylog(w2'*(diag(w1)*Z))); % + norm(w1)^2 + norm(w2)^2;
end
end

function x=mylog(x)
   if x<=0
       x=-100000;
   else
       x = real(log(x));
   end
end
