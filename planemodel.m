function [V F C]=planemodel
    %body
    H=1;L1=1;L2=2;L=6;LE=1.5;
    %wing
    wc=1;wb=6;al=1;ac=0.2;
    %tail
    vtb=1.5;vtcr=0.7;vtct=0.4;vtp=3.8;
    htb=3;htcr=0.7;htct=0.4;htp=3.8;
    V=[
        bodypoints(H,L1,L2,L,LE);
        wingpoints(wc,wb,al,ac);
        vtailpoints(H,vtb,vtcr,vtct,vtp);
        htailpoints(H,htb,htcr,htct,htp);
        ];
    F=[
        1 2 3 4 5 5 5 5;%body
        6 7 8 9 10 11 12 13;%wing
        14 15 16 17 17 17 17 17;%vtail
        18 19 20 21 22 22 22 22;%htail
        ];
    C=[
        [0 0 1];%body blue
        [0 1 0];%wing green
        [0 1 0];%vtail
        [0 1 0];%htail
        ];
end

function points=bodypoints(H,L1,L2,L,LE)
    points=[
        LE          0	0;
        LE-L1       0	-H/2;
        LE-L        0	-H/2;
        LE-L1-L2	0	H/2;
        LE-L1       0	H/2;
    ];
end

function points=wingpoints(c,b,al,ac)
    points=[
        0       b/2     0;
        ac-c	b/2     0;
        ac-c	b/2-al	0;
        -c      b/2-al	0;
        -c      al-b/2	0;
        ac-c	al-b/2	0;
        ac-c	-b/2    0;
        0       -b/2    0;
    ];
end

function points=vtailpoints(h,b,cr,ct,p)
    points=[
        -p       0	-h/2
        -p-cr+ct	0	-h/2-b
        -p-cr	0	-h/2-b
        -p-cr	0	-h/2
    ];
end

function points=htailpoints(h,b,cr,ct,p)
    points=[
        -p       0	-h/2
        -p-cr+ct b/2	-h/2
        -p-cr	b/2	-h/2
        -p-cr	-b/2	-h/2
        -p-cr+ct	-b/2	-h/2

    ];
end