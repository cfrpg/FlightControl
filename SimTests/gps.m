function [sys,X0,str,ts,simStateCompliance] = gps(t,x,u,flag,P)
    switch flag
        case 0 %initialize
            [sys,X0,str,ts,simStateCompliance]=mdlInitializeSizes(P);
        case 1 %derivatives
            sys=mdlDerivatives(t,x,u,P.mass,P.Jx,P.Jy,P.Jz,P.Jxz);
        case 2 %update
            sys=mdlUpdate(t,x,u);
        case 3 %output
            sys=mdlOutputs(t,x,u);
        case 4 %get time of next var hit
            sys=mdlGetTimeOfNextVarHit(t,x,u);
        case 9 %terminate
            sys=mdlTerminate(t,x,u);
        otherwise
            DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));     
    end
end

function [sys,X0,str,ts,simStateCompliance]=mdlInitializeSizes(P)
    sizes = simsizes;

    sizes.NumContStates  = 3;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 3;
    sizes.NumInputs      = 9;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;   % at least one sample time is needed

    sys = simsizes(sizes);    
    X0  = P.x0;
    str = [];

    ts  = [0 0];

    simStateCompliance = 'UnknownSimState';
end

function sys=mdlDerivatives(t,x,uu)

    sys = [pndot; pedot; pddot];
end

function sys=mdlUpdate(t,x,u)
    sys=[];
end

function sys=mdlOutputs(t,x,u)
    sys=x;
end

function sys=mdlGetTimeOfNextVarHit(t,x,u)
    sampleTime=1;
    sys=t+sampleTime;
end

function sys=mdlTerminate(t,x,u)
    sys=[];
end
