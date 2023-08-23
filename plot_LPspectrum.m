function[lpspec] = plot_LPspectrum(speech1,speech2,lporder)

% USAGE : function[lpspec] = plot_LPspectrum(speechframe,lporder)
figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:80:length(speech1)-320
tspeech160=diff(speech1(i:i+319));

tlpcs=lpc(tspeech160.*hamming(length(tspeech160)),lporder);

tlpspec=10*log10(abs(freqz(1,tlpcs)));

lpspec1=tlpspec;

%%%

tspeech160=diff(speech2(i:i+319));

tlpcs=lpc(tspeech160.*hamming(length(tspeech160)),lporder);

tlpspec=10*log10(abs(freqz(1,tlpcs)));

lpspec2=tlpspec;

%%%
subplot(2,1,1);plot(lpspec1(i,:));title('LP spectrum 1');grid;
subplot(2,1,2);plot(lpspec2(i,:),'m');title('LP spectrum 2');grid;
pause;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

