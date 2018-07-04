function [V F C]=controlmodel(de,da,dr,dt,vtol)
   %length  chord   hinge-mid-pos
    eb=3;   ec=0.3; ex=-4.5;ey=0;ez=-0.5;
    ab=1;   ac=0.2; ax=-0.8;ay=2.5;az=0;
    rb=1.5; rc=0.3; rx=-4.5;ry=0;rz=-0.5;
    vh=1.5; vw=1.5; vr=0.3; vx=-0.5;    vy=0;   vz=0;
    
    mtilt=pi/4;
    epts=[
        0   eb/2    0;
        -ec eb/2    0;
        -ec -eb/2   0;
        0   -eb/2   0;
    ];
    epts=transform(epts',0,de,0,ex,ey,ez);
    
    apts=[
        0   ab/2    0;
        -ac ab/2    0;
        -ac -ab/2   0;
        0   -ab/2   0;   
    ];
    ar=transform(apts',0,-da,0,ax,ay,az);
    al=transform(apts',0,da,0,ax,-ay,az);
    
    rpts=[
        0   0   0;
        0   0   -rb;
        -rc 0   -rb;
        -rc 0   -rc;
    ];
    rpts=transform(rpts',0,0,dr,rx,ry,rz);
    
    vtolpts=[
        vr -vr 0;
        vr vr 0;
        -vr vr 0;
        -vr -vr 0;
    ];
%     vtolpts=(vtolpts'+repmat([vx;vy;vz],1,size(vtolpts',2)))';
%     vt3=vtolpts'+repmat([vh;-vw;0],1,size(vtolpts',2));
%     vt1=vtolpts'+repmat([vh;vw;0],1,size(vtolpts',2));
%     vt4=vtolpts'+repmat([-vh;vw;0],1,size(vtolpts',2));
%     vt2=vtolpts'+repmat([-vh;-vw;0],1,size(vtolpts',2));
    vt1=transform(vtolpts',mtilt,0,0,vx+vh,vy+vw,vz);
    vt2=transform(vtolpts',-mtilt,0,0,vx-vh,vy-vw,vz);
    vt3=transform(vtolpts',-mtilt,0,0,vx+vh,vy-vw,vz);
    vt4=transform(vtolpts',mtilt,0,0,vx-vh,vy+vw,vz);
    V=[
        epts';
        ar';
        al';
        rpts';
        vt1'
        vt2';
        vt3';
        vt4';
    ];

    F=[
        1 2 3 4;
        5 6 7 8;
        9 10 11 12;
        13 14 15 16;
        17 18 19 20;
        21 22 23 24;
        25 26 27 28;
        29 30 31 32;
    ];

    C=[
        [1 0 0];
        [1 0 0];
        [1 0 0];
        [1 0 0];
        [1 0 0];
        [1 0 0];
        [1 0 0];
        [1 0 0];
    ];
    
end

function V=transform(V,r,p,y,px,py,pz)
    roll=[
        1 0 0;
        0 cos(r) -sin(r);
        0 sin(r) cos(r)];
    pitch=[
        cos(p), 0, sin(p);
        0, 1, 0;
        -sin(p), 0, cos(p)];
    yaw=[
        cos(y), -sin(y), 0;
        sin(y), cos(y), 0;
        0, 0, 1];
    R=yaw*pitch*roll;
    V=R*V;
    V=V+repmat([px;py;pz],1,size(V,2));
end