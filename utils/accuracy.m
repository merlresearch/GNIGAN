% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function [acc_disc, acc_gen] = accuracy(w1, w2, X, Z)
    acc_disc = (nnz(w1'*X>0.8) + nnz((w1'*diag(w2)*Z)<0.2))/(size(X,2)+size(Z,2));
    acc_gen = norm(mean(X,2) - mean(diag(w2)*Z,2));
end
