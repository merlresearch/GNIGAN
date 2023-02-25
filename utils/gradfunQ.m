% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function df = gradfunQ(i,x)

global Q q;

df =  Q{i}*x+q{i};
