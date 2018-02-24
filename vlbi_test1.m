load lilacsat2_sync_20180223_slice.mat

lpFilt = designfilt('lowpassfir', 'PassbandFrequency', 0.25,...
             'StopbandFrequency', 0.35, 'PassbandRipple', 0.5, ...
             'StopbandAttenuation', 65, 'DesignMethod', 'kaiserwin');
         
N = length(signal_sync_harbin_slice);

i = 0:(N-1);

s_ddc_harbin = signal_sync_harbin_slice .* exp(1j*2*pi*(62.5/250)*i);         
s_lp_harbin = filter(lpFilt, s_ddc_harbin);

s_ddc_chongqing = signal_sync_chongqing_slice .* exp(1j*2*pi*(62.5/250)*i);         
s_lp_chongqing = filter(lpFilt, s_ddc_chongqing);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
figure
subplot(1,2,1)
fft_waterfall(signal_sync_harbin_slice, 1024, rx_rate)
view([0,0,1])
title('Harbin')
xlabel('Frequency / Hz')
ylabel('Time / s')
subplot(1,2,2)
fft_waterfall(signal_sync_chongqing_slice, 1024, rx_rate)
view([0,0,1])
title('Chongqing')
xlabel('Frequency / Hz')
ylabel('Time / s')

figure
t = (0:(N-1))/rx_rate;
subplot(2,1,1)
plot(t, real(s_lp_harbin), t, imag(s_lp_harbin))
title('Harbin')
axis([0,30,-0.004,0.004])
xlabel('Time / s')
ylabel('S')
subplot(2,1,2)
plot(t, real(s_lp_chongqing), t, imag(s_lp_chongqing))
title('Chongqing')
axis([0,30,-0.004,0.004])
xlabel('Time / s')
ylabel('S')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% s_lp_harbin_slice = s_lp_harbin(375001:625000);
% s_lp_chongqing_slice = s_lp_chongqing(375001:625000);
% 
% close all
% figure
% subplot(1,2,1)
% fft_waterfall(s_lp_harbin_slice, 1024, rx_rate)
% view([0,0,1])
% title('Harbin')
% xlabel('Frequency / Hz')
% ylabel('Time / s')
% subplot(1,2,2)
% fft_waterfall(s_lp_chongqing_slice, 1024, rx_rate)
% view([0,0,1])
% title('Chongqing')
% xlabel('Frequency / Hz')
% ylabel('Time / s')
% 
% figure
% t = (0:(length(s_lp_chongqing_slice)-1))/rx_rate;
% subplot(2,1,1)
% plot(t, real(s_lp_harbin_slice), t, imag(s_lp_harbin_slice))
% title('Harbin')
% axis([0,1,-0.004,0.004])
% xlabel('Time / s')
% ylabel('S')
% subplot(2,1,2)
% plot(t, real(s_lp_chongqing_slice), t, imag(s_lp_chongqing_slice))
% title('Chongqing')
% axis([0,1,-0.004,0.004])
% xlabel('Time / s')
% ylabel('S')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_lp_harbin_slice = s_lp_harbin;
s_lp_chongqing_slice = s_lp_chongqing;