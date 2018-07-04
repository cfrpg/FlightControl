function drawplane(ps)
    pn      = ps(1);       % inertial North position     
    pe      = ps(2);       % inertial East position
    pd      = ps(3); 
    phi     = ps(4);       % roll angle         
    theta   = ps(5);       % pitch angle     
    psi     = ps(6);       % yaw angle     
   t=ps(7);
    
    persistent hplane;
    persistent hcontrol;
    scale=2000;  %plane scale
    field=1000;  %field scale
    [Vplane,Fplane,Cplane]=planemodel;
    Vplane=Vplane*scale;   
    Vplane=transform(Vplane',phi,theta,psi,pn,pe,pd);
   
    R=[        
        0 1 0;
        1 0 0;
        0 0 -1;
        ];
    Vplane=R*Vplane; %NED -> XYZ
    
    
    if t<0.1
        figure(1),clf
        hplane=patch('Vertices',Vplane','Faces',Fplane,'FaceVertexCData',Cplane,'FaceColor','flat');
      
        %hplane=plot3(Vplane(1,:),Vplane(2,:),Vplane(3,:));
        xlabel('East')
        ylabel('North')
        zlabel('-Down')
        view(45,45)  % set the vieew angle for figure
        %axis([-100,100,-100,100,-100,100]);
        %axis([-10,10,-10,10,-10,10]*scale*field);
        axis([-10,10,-10,10,-10,10]*field);
        grid on
        hold on
    else
        set(hplane,'Vertices',Vplane');        
    end
    
    
end

function V=transform(V,phi,the,psi,pn,pe,pd)
    roll=[
        1 0 0;
        0 cos(phi) -sin(phi);
        0 sin(phi) cos(phi)];
    pitch=[
        cos(the), 0, sin(the);
        0, 1, 0;
        -sin(the), 0, cos(the)];
    yaw=[
        cos(psi), -sin(psi), 0;
        sin(psi), cos(psi), 0;
        0, 0, 1];
    R=yaw*pitch*roll;
    V=R*V;
    V=V+repmat([pn;pe;pd],1,size(V,2));
end
