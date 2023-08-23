lporder=8;

wlpccs=load('Features/WLPCC/test/normal/normal_divyaI_F_24_Test5.wlpcc');

[x y]=size(wlpccs);
for i=1:y
    lpcc(:,i)=wlpccs(:,i)/i;
end
[r,c] = size(lpcc);
z = zeros(r,256-c);
lpcc256 = [lpcc z];
fliplpcc256 = fliplr(lpcc256);
lpcc512 = [lpcc256(:,1:255) fliplpcc256];
lpcc512T = lpcc512';
logspecT = fft(lpcc512T);
logspec = logspecT';
ac=ifft(exp(logspec));
for i=1:r
    lpc(i,:)=levinson(ac(i,1:lporder+1));
end
wlpccs_lom=load('Features/WLPCC/test/lombard_warp/lombard_divyaI_F_24_Test5_Warpalone.wlpcc');

[x y]=size(wlpccs_lom);
for i=1:y
    lpcc_lom(:,i)=wlpccs_lom(:,i)/i;
end
[r_lom,c_lom] = size(lpcc_lom);
z_lom = zeros(r_lom,256-c_lom);
lpcc256_lom = [lpcc_lom z_lom];
fliplpcc256_lom = fliplr(lpcc256_lom);
lpcc512_lom = [lpcc256_lom(:,1:255) fliplpcc256_lom];
lpcc512T_lom = lpcc512_lom';
logspecT_lom = fft(lpcc512T_lom);
logspec_lom = logspecT_lom';
ac=ifft(exp(logspec_lom));
for i=1:r_lom
    lpc_lom(i,:)=levinson(ac(i,1:lporder+1));
end



wlpccs_der=load('estimated/est_warp/lombard_divyaI_F_24_Test5_Warpalone.wlpcc_derived');
[x y]=size(wlpccs_der);
for i=1:y
    lpcc_der(:,i)=(wlpccs_der(:,i))/i;
end
[r_der,c_der] = size(lpcc_der);
z_der = zeros(r_der,256-c_der);
lpcc256_der = [lpcc_der z_der];
fliplpcc256_der = fliplr(lpcc256_der);
lpcc512_der = [lpcc256_der(:,1:255) fliplpcc256_der];
lpcc512T_der = lpcc512_der';
logspecT_der = fft(lpcc512T_der);  
logspec_der = logspecT_der';
ac=ifft(exp(logspec_der));
for i=1:r_der
    lpc_der(i,:)=levinson(ac(i,1:lporder+1));
end
for i=1:r
    d_l(i)= distitar(lpc(i,:),lpc_lom(i,:));
    d_n(i)= distitar(lpc(i,:),lpc_der(i,:));
  
end
figure

d_l2=enframe(d_l,80);
d_n2=enframe(d_n,80);
[r2 c]=size(d_l2);
for i=1:r2
    
 plot((1:80),abs(d_l2(i,:)),':',(1:80),abs(d_n2(i,:)),'-');
 
set(0,'DefaultAxesColorOrder',[0 0 0;0 0 1]);
xlabel('Frame index');
ylabel('Itakura distance');
legend('Distance between normal and Lombard spectra','Distance between normal and estimated spectra')
grid ;
pause;
end

% % % 
% % % for i=1:r
% % %     lpspec=10*log10(abs(freqz(1,lpc(i,:))));
% % %     lpspec_der=10*log10(abs(freqz(1,lpc_der(i,:))));
% % %     lpspec_lom=10*log10(abs(freqz(1,lpc_lom(i,:))));
% % %     d1=distitar(lpspec_lom,lpspec);
% % %     d2=distitar(lpspec_der,lpspec);
% % %     d_l(i)=mean(d1);
% % %     d_n(i)=mean(d2);
% % % 
% % % end
% % % figure
% % % 
% % % d_l2=enframe(d_l,350);
% % % d_n2=enframe(d_n,350);
% % % [r2 c]=size(d_l2);
% % % for i=1:r2
% % % plot((1:350),d_l2(i,:),'blue',(1:350),d_n2(i,:),'green');grid;
% % % pause;
% % % end
