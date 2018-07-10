pns=nedData.signals(1).values;
pes=nedData.signals(2).values;
pds=nedData.signals(3).values;
vas=VaData.signals(2).values;

n=size(pns);
pns(n)=NaN;

patch(pes,pns,pds,vas./P.a,'edgecolor','interp','facecolor','none');
patch(pes,pns,zeros(n),vas./P.a,'edgecolor','interp','facecolor','none');
colormap jet;
xlabel('East/m')
ylabel('North/m')
zlabel('Altitude/m')
colorbar
h = colorbar; 
set(get(h,'label'),'string','Ma');
axis([-2,4,-0,6,0,1.0]*10000);
view(45,45)
grid on
