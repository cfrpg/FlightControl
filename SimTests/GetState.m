function out = GetState(x,P)
    nx      = x(1)
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
    
    Va=norm([u+P.u0,v,w]);
    
    out=[nx;ny;nz;p;q;r;phi;theta;psi;du;v;w;u;Va;pn;pe;pd];
end