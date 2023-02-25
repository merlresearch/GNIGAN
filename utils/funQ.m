% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function f = funQ(i,x)

global Q q;

f =  0.5*x'*Q{i}*x+q{i}'*x;
