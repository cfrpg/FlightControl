w_des=6;
z_des=0.6;
r=z_des*w_des;
s=sqrt(w_des^2-r^2);
R_dsr=[
    -r+s*1i;
    -r-s*1i;
    R_lon(3);
    R_lon(4)];
B_stab=B_lon(:,1);
gain=place(A_lon,B_stab,R_dsr);
gain(1)=0;
A_lon_stab=A_lon-B_stab*gain;
A_stab=[A_lon_stab,zeros(4,5);zeros(5,4),A_lat];
[~,R_lon_stab]=eig(A_lon_stab);
R_lon_stab=diag(R_lon_stab);