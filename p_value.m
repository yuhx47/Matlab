function p_SNP = p_value(SNP_ID, mci2ad)
for i = 3:8
    if string(mci2ad{i,3})== SNP_ID
        j=i;
    end
end
SNP_0 = 0;
SNP_1 = 0;
SNP_2 = 0;
for i = 6:128
    if mci2ad{j,i} == '0'
        SNP_0 = SNP_0 +1;
    else if mci2ad{j,i} == '1'
            SNP_1 = SNP_1 +1;
        else if mci2ad{j,i} == '2'
                SNP_2 = SNP_2 +1;
            end
        end
    end
end
normal_SNP = 0.5*(2*SNP_0 + SNP_1)/(SNP_0 + SNP_1 + SNP_2);
minor_SNP = 1-normal_SNP;
SNP_0_exp = normal_SNP * normal_SNP*(SNP_0 + SNP_1 + SNP_2);
SNP_1_exp = 2* normal_SNP * minor_SNP*(SNP_0 + SNP_1 + SNP_2);
SNP_2_exp = minor_SNP * minor_SNP*(SNP_0 + SNP_1 + SNP_2);
chisquare_SNP = (SNP_0 - SNP_0_exp)*(SNP_0 - SNP_0_exp)/SNP_0_exp +(SNP_1 - SNP_1_exp)*(SNP_1 - SNP_1_exp)/SNP_1_exp + (SNP_2 - SNP_2_exp)*(SNP_2 - SNP_2_exp)/SNP_2_exp;
p_SNP = chi2cdf(chisquare_SNP, 1);