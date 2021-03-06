function out=GetPosition(x,P)
    phi=x(1);
    theta=x(2);
    psi=x(3);
    Du=x(4);
    v=x(5);
    w=x(6);
    
    u=Du+P.u0;
    Va=norm([u,v,w]);
    roll=[
        1 0 0;
        0 cos(phi) sin(phi);
        0 -sin(phi) cos(phi)];
    pitch=[
        cos(theta), 0, -sin(theta);
        0, 1, 0;
        sin(theta), 0, cos(theta)];
    yaw=[
        cos(psi), sin(psi), 0;
        -sin(psi), cos(psi), 0;
        0, 0, 1];
    R=[cos(theta)*cos(psi),sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi),sin(phi)*sin(psi)+cos(phi)*sin(theta)*cos(psi);
        cos(theta)*sin(psi),sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi),cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi);
        -sin(theta),sin(phi)*cos(theta),cos(phi)*cos(theta)];
    %R=roll*pitch*yaw;
    res=R*[u;v;w];
    pndot = res(1);    
    pedot = res(2); 
    pddot = res(3);
    chi=atan2(pedot,pndot);
%     if chi<-0.1*pi
%         chi=chi+2*pi;
%     end
    Vg=norm([pndot;pedot]);
    out=[pndot;pedot;pddot;Va;chi;Vg];    
end