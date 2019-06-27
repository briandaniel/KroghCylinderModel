%%
% Brian Hong 6-19-19
%
% File solves the Krogh cylinder model of oxygen
% transport used in Mcguire, Secomb (2001)
%
close all
clear all


% Pull params
run KroghParams.m;

% Run model solution
[r,z,Psltn] = KroghModelSimple(prm);



%%
close all

figure('outerposition',[1000,500,500,500])

hold on
colors = parula(size(Psltn,2));
lin = plot(r*1e4,Psltn)
set(lin,{'color'},num2cell(colors,2))
xlabel('r [\mu m]')
ylabel('P [torr]')
set(gca,'xlim',[0,prm.Rt*1e4])
set(gca,'ylim',[0,100])



figure('outerposition',[1498         458         984         751])
set(gcf, 'Renderer', 'opengl');
hold on
surf(z*1e1,r*1e4,Psltn,repmat(z*1e1,size(Psltn,1),1),'facealpha',1)
view(130,30)
ylabel('r [\mu m]')
xlabel('z [mm]')
zlabel('P [torr]')
