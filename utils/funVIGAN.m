% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function f = funVIGAN(i,x)

if (i == 1)
  f = log(1+exp(2*x(1))) + log(1 + exp(x(1)*x(2)));
else
  f = -log(1 + exp(x(1)*x(2)));
end
