for num = [205, 208, 209, 213, 216, 251, 260, 301, 302, 331, 356, 363, 364, 220]
    disp (num);
    a = int2str(num);
    file_path = ['C:\Users\yu\Desktop\WebLogo_gn\', a, '\'];
   %disp (file_path);
   %file_path='/home/yu/Desktop/7/';  %directory pathway
    img_path_list=dir(strcat(file_path,'*.png'));%?????????png?????,????????data,name???
    img_num=length(img_path_list);%get the number of the figures
    if img_num > 0 %if the number of figures > 0
        for j=1:img_num  %read figures oneby one
            image_name=img_path_list(j).name;%name of figures
            %image = imread(strcat(file_path,image_name));%?????
            fprintf('%d %s\n',j,strcat(file_path,image_name));%??????????
        end
    end
    A1 = img_path_list(1).name;
    A2 = img_path_list(2).name;
    A3 = img_path_list(3).name;
    A4 = img_path_list(4).name;
    A5 = img_path_list(5).name;
    A6 = img_path_list(6).name;
    A7 = img_path_list(7).name;
    A8 = img_path_list(8).name;
   % A9 = img_path_list(9).name;
  %  A10 = img_path_list(10).name;
 %   A11 = img_path_list(11).name;
   % A12 = img_path_list(12).name;
    B1 = imread(strcat(file_path,A1));
    B2 = imread(strcat(file_path,A2));
    B3 = imread(strcat(file_path,A3));
    B4 = imread(strcat(file_path,A4));
    B5 = imread(strcat(file_path,A5));
    B6 = imread(strcat(file_path,A6));
    B7 = imread(strcat(file_path,A7));
    B8 = imread(strcat(file_path,A8));
   % B9 = imread(strcat(file_path,A9));
    %B10 = imread(strcat(file_path,A10));
   % B11 = imread(strcat(file_path,A11));
  %  B12 = imread(strcat(file_path,A12));
    B = [B1; B2; B3; B4; B5; B6; B7; B8];
    C = [a,'.png'];
    imwrite(B, C);
end
