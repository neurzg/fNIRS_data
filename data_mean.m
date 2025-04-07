clear,clc
path='D:\Desktop\fnirs_data\fNIRS_data_3_preprocess\'
files=dir(strcat(path,'*.mat'))

for i=1:length(files)
    name=files(i).name
    filesname=name(1:findstr(name,'.')-1)
    path1=[path,name]
    load(path1)
    condition_hbo=zeros(3,22)
    condition_hbr=zeros(3,22)
    condition_tot=zeros(3,22)
    for k=1:3
      mark=find(nirsdata.vector_onset==k)
      data_hbo=zeros(1,22)
      data_hbr=zeros(1,22)
      data_tot=zeros(1,22)
      for j=1:length(mark)
          hbo_T=nirsdata.oxyData(mark(j):mark(j)+80,:)
          hbo=mean(hbo_T)
          data_hbo=data_hbo+hbo
          
          hbr_T=nirsdata.dxyData(mark(j):mark(j)+80,:)
          hbr=mean(hbr_T)
          data_hbr=data_hbr+hbr
          
          tot_T=nirsdata.totalData(mark(j):mark(j)+80,:)
          tot=mean(tot_T)
          data_tot=data_tot+tot
      end
      hbo_mean=data_hbo/length(mark)
      hbr_mean=data_hbr/length(mark)
      tot_mean=data_tot/length(mark)

      condition_hbo(k,:)= hbo_mean
      condition_hbr(k,:)= hbr_mean
      condition_tot(k,:)= tot_mean
    end
    resulthbo=['D:\Desktop\fnirs_data\fNIRS_data_4_mean\','hbo_',filesname,'.txt']
    resulthbr=['D:\Desktop\fnirs_data\fNIRS_data_4_mean\','hbr_',filesname,'.txt']
    resulttot=['D:\Desktop\fnirs_data\fNIRS_data_4_mean\','tot_',filesname,'.txt']
    dlmwrite(resulthbo, condition_hbo, 'delimiter', '\t','precision', 8,'newline', 'pc')
    dlmwrite(resulthbr, condition_hbr, 'delimiter', '\t','precision', 8,'newline', 'pc')
    dlmwrite(resulttot, condition_tot, 'delimiter', '\t','precision', 8,'newline', 'pc')
end