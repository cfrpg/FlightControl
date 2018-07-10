function res=Autopilot(x,P)
    res=D(x,P);
    %res=E(x,P);
end

function res=D(x,P)
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
            res=[8000;120*pi/180;0.8*P.a;state];
            if abs(hdg-90*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 5
            res=[8000;180*pi/180;0.8*P.a;state];
            if abs(hdg-res(2))<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 6
            res=[8000;180*pi/180;0.8*P.a;state];
            if dist-lastDist>15000
                state=state+1;
                lastDist=dist;
            end
        case 7
            res=[8000;180*pi/180;0.8*P.a;state];
    end
end

function res=E(x,P)
    alt=x(1);
    dist=x(4);
    spd=x(2);
    hdg=x(3);

    persistent state;
    persistent lastDist;
    if hdg<-0*pi
        hdg=hdg+2*pi;
    end
    if dist<1
        state=1;
        lastDist=dist;
    end
    res=[5000;0;0.6*P.a;state];
    switch state
        case 1
            res=[3000;0;0.6*P.a;state];
            if alt>3000
                state=state+1;
                lastDist=dist;
            end
        case 2
            res=[3000;0;0.6*P.a;state];
            if dist-lastDist>15000
                state=state+1;
                lastDist=dist;
            end
        case 3
            res=[3000;0;0.7*P.a;state];
            if abs(res(3)-spd)<5
                state=state+1;
                lastDist=dist;
            end
        case 4
            res=[3000;120*pi/180;0.7*P.a;state];
            if abs(hdg-90*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 5
            res=[3000;240*pi/180;0.7*P.a;state];
            if abs(hdg-180*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 6
            res=[3000;300*pi/180;0.7*P.a;state];
            if abs(hdg-270*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 7
            res=[3000;45*pi/180;0.7*P.a;state];
            if abs(hdg-1*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 8
            res=[3000;120*pi/180;0.7*P.a;state];
            if abs(hdg-90*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 9
            res=[3000;240*pi/180;0.7*P.a;state];
            if abs(hdg-180*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 10
            res=[3000;300*pi/180;0.7*P.a;state];
            if abs(hdg-270*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 11
            res=[3000;45*pi/180;0.7*P.a;state];
            if abs(hdg-1*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 12
            res=[3000;90*pi/180;0.7*P.a;state];
            if abs(hdg-90*pi/180)<0.5*pi/180
                state=state+1;
                lastDist=dist;
            end
        case 13
            res=[3000;90*pi/180;0.7*P.a;state];
            if dist-lastDist>15000
                state=state+1;
                lastDist=dist;
            end
        case 14
            res=[300;90*pi/180;61.1;state];
            if abs(alt-res(1))<5 && abs(spd-res(3))<2
                state=state+1;
                lastDist=dist;
            end
        case 15
            res=[300;90*pi/180;61.1;state];
            if dist-lastDist>10000
                state=state+1;
                lastDist=dist;
            end
        case 16
            res=[300;90*pi/180;61.1;state];
    end
end