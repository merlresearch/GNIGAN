% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function f = funGaussGAN(i,x)
    a = x(1); b = x(2); w1 = x(3); w2 = x(4);
    sigma = 1;
    if (i == 1)
      f =  w2*sigma^2 - w2*(a^2+b^2) - w1*b;
    else
      f =  - w2*sigma^2 + w2*(a^2+b^2) + w1*b;
    end
