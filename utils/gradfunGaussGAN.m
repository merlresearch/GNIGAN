% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function gf = gradfunGaussGAN(i,x)

a = x(1); b = x(2); w1 = x(3); w2 = x(4);
sigma = 1;
if (i == 1)
  gf = [ -2*a*w2 ; -2*b*w2-w1 ; -b ; sigma^2-a^2-b^2 ];
else
  gf = [ 2*a*w2 ; 2*b*w2+w1 ; b ; -sigma^2+a^2+b^2 ];
end
