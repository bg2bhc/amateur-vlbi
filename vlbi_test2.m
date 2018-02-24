% load('lilacsat2_sync_20180223_321500ms.mat')

len_corr = 2048;

corr_max_freq = zeros([1, 4001]);
corr_max_phi = zeros([1, 4001]);
corr_max_amp = zeros([1, 4001]);
corr_max_snr = zeros([1, 4001]);
index = zeros([1, (length(s_lp_harbin_slice)/10000-1)]);
amp = zeros([1, (length(s_lp_harbin_slice)/10000-1)]);
freq = zeros([1, (length(s_lp_harbin_slice)/10000-1)]);
for j=1:(length(s_lp_harbin_slice)/10000-1)
    corr_start = 3000+j*10000;

    s_lp_harbin_corr = s_lp_harbin_slice(corr_start:(corr_start+len_corr-1));

%     index_exp = round(472.4202898550725-0.376811594202899*j);    
%     for i=(index_exp-10):(index_exp+10)
    for i=0:500
        [corr_max_freq(i+2001), corr_max_phi(i+2001), corr_max_amp(i+2001), corr_max_snr(i+2001)] = freq_est(conj(s_lp_harbin_corr).* s_lp_chongqing_slice((corr_start+i):(corr_start+i+len_corr-1)));
    end

    [amp(j), index(j)]=max(corr_max_amp);
    freq(j) = corr_max_freq(index(j));
end

t=(3000+(1:(length(s_lp_harbin_slice)/10000-1))*10000-1)/250000;

figure
subplot(3,1,1)
plot(t, amp)
xlabel('Time / s')
ylabel('Correlation Amplitude')
subplot(3,1,2)
plot(t, (index-2001)/250000*3e5)
xlabel('Time / s')
ylabel('¦¤r / km')
subplot(3,1,3)
plot(t, freq/2/pi*250)
xlabel('Time / s')
ylabel('¦¤f / kHz')
axis([0,30,16,17])