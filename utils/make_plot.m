% Copyright (c) 2019, 2023 Mitsubishi Electric Research Laboratories (MERL).
%
% SPDX-License-Identifier: AGPL-3.0-or-later

function make_plot(obj_type, res)
    plot_convergence_grad_quad(obj_type+1, res);
end

function plot_convergence_grad_quad(obj_type, res)
type={'Non-convex-QP', 'Convex-QP', 'Strictly-Convex-QP', 'Bilinear', 'GAN'};
figno=1;
xtext = 'iteration'; ytext='||\nabla f||^2';
set_fig_dims(figno);hold on;
plot(1:size(res,1), res(:,2),'LineWidth',5, 'color','r'); %[0 V0 0.5*norm(df0)^2, x0(1), x0(2)]
legends = {'grad NI (ours)'};

h = xlabel(xtext); set(h,'fontsize', 24);
h = ylabel(ytext); set(h,'fontsize', 24);

set(gca, 'fontsize', 24);
if ~isempty(legends)
    h=legend(legends); set(h,'fontsize', 20); grid on;
end
grid on; title(type{obj_type});
end

function set_fig_dims(figno)
    hfig = figure(figno);
    set(gcf, 'PaperPositionMode','auto');
    clf(figno);
    set(hfig, 'position', [0,0,800,600]);
end
%%
