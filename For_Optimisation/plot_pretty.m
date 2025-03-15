function plot_pretty(labelx,labely,x,data)
plot(x,data)
xlabel(labelx);
ylabel(labely);
%set(findall(gcf, '-property', 'FontSize'), 'FontSize', 14);
