function plot_pretty(labelx,labely,data)
plot(data)
xlabel(labelx);
ylabel(labely);
%set(findall(gcf, '-property', 'FontSize'), 'FontSize', 14);
