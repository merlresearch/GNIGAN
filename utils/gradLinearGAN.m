% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function g = gradDCGAN(player,w1,w2, X, Z)
    if (player == 1)
       w1X = w1'*X; w1X(abs(w1X)<1e-1000)=1e-1000;
       w2Z = (1-w1'*(diag(w2)*Z)); w2Z(abs(w2Z)<1e-1000)=1e-1000;
       g = -mean(bsxfun(@times, X, 1./w1X),2) + mean(bsxfun(@times, diag(w2)*Z, 1./(w2Z)), 2); %+ 2*w1 + 2*w2;
    else
       w1Z = w1'*(diag(w2)*Z); w1Z(abs(w1Z)<1e-1000) = 1e-1000;
       g = -mean(bsxfun(@times, diag(w1)*Z, 1./w1Z),2); % + 2*w1 + 2*w2;
    end
end
