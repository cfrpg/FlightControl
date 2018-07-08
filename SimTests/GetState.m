function out = GetState(x,P)
    nx      = x(1);
    nz      = x(2);
    ny      = x(3);
    alpha   = x(4);
    beta    = x(5);
    
    du       = x(6);
    w       = x(7);
    q       = x(8);
    theta   = x(9);
    v       = x(10);
    p       = x(11);
    r       = x(12);
    phi     = x(13);
    psi     = x(14);
    
    pn      = x(15);
    pe      = x(16);
    pd      = x(17);
    u=P.u0+du;
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
    
    R=roll*pitch*yaw;
    res=R'*[u;v;w];
    pndot = res(1);    
    pedot = res(2); 
    chi=atan2(pedot,pndot);
    
    out=[nx;ny;nz;p;q;r;phi;theta;psi;du;v;w;u;Va;pn;pe;-pd+P.h0;chi];
end