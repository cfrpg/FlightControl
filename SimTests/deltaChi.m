function res=deltaChi(x)
    chi_c=x(1);
    chi=x(2);
    if chi_c<-0.1*pi
        chi_c=chi_c+2*pi;
    end
    if chi<-0.1*pi
        chi=chi+2*pi;
    end
%      if chi_c>=chi
%         chi_c2=chi_c-2*pi;
%     else
%         chi_c2=chi_c+2*pi;
%     end
%     if(abs(chi_c-chi)<abs(chi_c2-chi))
%         res = chi_c - chi;
%     else
%         res = chi_c2 - chi;
%     end
    res = chi_c - chi;
end