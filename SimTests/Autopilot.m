function res=Autopilot(x,P)
    alt=x(1);
    dist=x(4);
    spd=x(2);
    hdg=x(3);

    persistent state;
    persistent lastDist;
    
    if dist<1
        state=1;
        lastDist=dist;
    end
    res=[5000;0;0.6*P.a;state];
    switch state
        case 1
            res=[5000;0;0.6*P.a;state];
            if dist-lastDist>10000
                state=state+1;
                lastDist=dist;
            end
        case 2
            res=[8000;0;0.6*P.a;state];
            if alt>8000
                state=state+1;
                lastDist=dist;
            end
        case 3
            res=[8000;0;0.8*P.a;state];
            if dist-lastDist>15000
                state=state+1;
                lastDist=dist;
            end
        case 4
            res=[8000;180*pi/180;0.8*P.a;state];
            if abs(hdg-res(2))<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 5
            res=[8000;180*pi/180;0.8*P.a;state];
            if dist-lastDist>15000
                state=state+1;
                lastDist=dist;
            end
        case 6
            res=[8000;180*pi/180;0.8*P.a;state];
    end
end