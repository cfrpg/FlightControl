w_sp_stab=6;
z_sp_stab=0.707;
w_p_stab=wp;
z_p_stab=zp;

r_sp=z_sp_stab*w_sp_stab;
s_sp=sqrt(w_sp_stab^2-r_sp^2);
r_p=z_p_stab*w_p_stab;
s_p=sqrt(w_p_stab^2-r_p^2);
R_stab=[0;0;0;0];
if norm(R_lon(1))<(R_lon(4))
    R_stab=[
        -r_p+s_p*1i;
        -r_p-s_p*1i;
        -r_sp+s_sp*1i;
        -r_sp-s_sp*1i];
else
    R_stab=[        
        -r_sp+s_sp*1i;
        -r_sp-s_sp*1i;
        -r_p+s_p*1i;
        -r_p-s_p*1i];
end
B_stab=B_lon(:,1);
gain=place(A_lon,B_stab,R_stab);
A_lon_stab=A_lon-B_stab*gain;
A_stab=[A_lon_stab,zeros(4,5);zeros(5,4),A_lat];

[nums,dens]=ss2tf(A_lon,B_lon,eye(4),zeros(4,2),1);
tf1=tf(nums(4,:),dens);
[nums,dens]=ss2tf(A_lon_stab,B_lon,eye(4),zeros(4,2),1);
tf2=tf(nums(4,:),dens);

%plot tf1 & tf2
figure(1);
sgrid on;
rlocus(tf1); %before stablization
figure(2);
sgrid on;
rlocus(tf2); %after stablization

