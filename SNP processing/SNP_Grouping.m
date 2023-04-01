%%% Download all file in 'VCF 파일 추출 정보' folder on Google Teamdrive - ADNI Gene.
%%% Download DXSUM_PDXCONV_ADNIALL.csv in 'ADNI 원본데이터' folder on Google Teamdrive - ADNI Gene

%%% Read the VCF information
header = importfile('header.txt');
rs17090219 = importfile('rs17090219.txt');
rs192470679 = importfile('rs192470679.txt');
rs56378310 = importfile('rs56378310.txt');
rs2484 = importfile('rs2484.txt');
rs3936289 = importfile('rs3936289.txt');
rs11121365 = importfile('rs11121365.txt');
SNP_WGS = vertcat(header, rs17090219, rs192470679, rs56378310, rs2484, rs3936289, rs11121365);
SNP_WGS_Group = SNP_WGS;
SNP_WGS_Group(:,6:9) = [];
for j = 2:7
    for i = 10:817
        if strncmp(SNP_WGS(j,i),"0/0",3)
            SNP_WGS_Group(j,i-4) = 0;
        else if strncmp(SNP_WGS(j,i),"0/1",3)
               SNP_WGS_Group(j,i-4) = 1;
            else if strncmp(SNP_WGS(j,i),"1/1",3)
                   SNP_WGS_Group(j,i-4) = 2;
                end
            end
        end
    end
end

%%% Read the patients' diagnositc summary file who have the whole genome info.

dxsum = readtable('DXSUM_PDXCONV_ADNIALL.csv');
dxsum_dxchange = sortrows(dxsum(:,{'RID','DXCHANGE'}));
dxchange_notempty = ~(string(dxsum_dxchange{:,2})=="");
dxsum_dxchange = dxsum_dxchange(dxchange_notempty,:);
dxsum_dxchange = unique(dxsum_dxchange);
%%% To match RID and Patient ID
for i=1:height(dxsum_dxchange)
if strlength(string(dxsum_dxchange{i,1}))==1
    a = insertBefore(string(dxsum_dxchange{i,1}),1,'000');
    b(i,1) = a;
else if strlength(string(dxsum_dxchange{i,1}))==2
        a = insertBefore(string(dxsum_dxchange{i,1}),1,'00');
        b(i,1) = a;
    else if strlength(string(dxsum_dxchange{i,1}))==3
            a = insertBefore(string(dxsum_dxchange{i,1}),1,'0');
        b(i,1) = a;
        else if strlength(string(dxsum_dxchange{i,1}))==4
                a=string(dxsum_dxchange{i,1});
                b(i,1) = a;
            end
        end
    end
end
end
b = cellstr(b);
dxsum_dxchange(:,1) = b;
SNP_WGS_Group(9,1) = {'Diagnostic Summary'};
for i= 10:817
    SNP_WGS_Group(9,i-4) = strjoin(dxsum_dxchange{extractAfter(string(header{1,i}),"_S_")==table2array(dxsum_dxchange(:,1)),2});
end

%%%%% Grouping the Patients. In this code, we select the patients who have
%%%%% ever been converted from MCI to AD

mci2ad = strfind(SNP_WGS_Group(9,:), '5'); 
mci2ad(2:9,1:5) = cellstr(SNP_WGS_Group(1:8,1:5));
for i=6:813
    if isempty(mci2ad{1,i})==0
        mci2ad(2:9,i) = cellstr(SNP_WGS_Group(1:8, i));
    else
        c(1,i) = 1;
    end
end
c=logical(c);
mci2ad(:,c)=[];

%%% Get p-value of each snps
p_rs17090219 = p_value('rs17090219', mci2ad);
p_rs192470679 = p_value('rs192470679', mci2ad);
p_rs56378310 = p_value('rs56378310', mci2ad);
p_rs3936289 = p_value('rs3936289',mci2ad);
p_rs2484 = p_value('rs2484', mci2ad);
p_rs11121365 = p_value('rs11121365', mci2ad);

%%% Write data in csv file.
m(1:6,2:3) = cellstr(SNP_WGS(2:7,1:2));
m(1:6,1) = cellstr(SNP_WGS(2:7,3));
m(1:6,4) = [cellstr(num2str(p_rs17090219));cellstr(num2str(p_rs192470679));cellstr(num2str(p_rs56378310));cellstr(num2str(p_rs2484));cellstr(num2str(p_rs3936289));cellstr(num2str(p_rs11121365))];
m = cell2table(m,'VariableNames',{'SNP' 'CHR' 'BP' 'P'});
writetable(m, 'pvalue.csv');