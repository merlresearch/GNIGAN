% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function gf = gradfunVIGAN(i,x)

if (i == 1)
  gf = [ 2/(1+exp(-2*x(1))) + x(2)/(1+exp(-x(1)*x(2))) ; x(1)/(1+exp(-x(1)*x(2)))];
else
  gf = [ -x(2)/(1+exp(-x(1)*x(2))) ; -x(1)/(1+exp(-x(1)*x(2)))];
end
