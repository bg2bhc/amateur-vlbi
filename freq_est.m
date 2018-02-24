% function [freq, phi, amp, snr] = freq_est(a)
% 
%     N_fft = length(a);
% 
%     n = 0:(N_fft-1);
% 
%     f = (-(N_fft/2):(N_fft/2-1))./N_fft.*2*pi;
% 
%     fft_s = fftshift((fft(a)));
%     amp_s = abs(fft_s);
%     pwr_s = amp_s.^2;
% 
%     [amp, index] = max(amp_s);
%     
%     if index==1
%         amp_n1 = amp_s(N_fft);
%     else
%         amp_n1 = amp_s(index-1);
%     end
%     
%     if index==N_fft
%         amp_p1 = amp_s(1);
%     else
%         amp_p1 = amp_s(index+1);
%     end
% 
%     phi_est = angle(fft_s(index));
% 
% 
%     if amp_n1>=amp_p1
%         freq = f(index) - amp_n1./(amp_n1+amp)./N_fft.*2*pi;
%         amp = (amp^2+amp_n1^2)^0.5;
% %         phi = (angle(fft_s(index))*amp+angle(fft_s(index-1))*amp_n1)/(amp+amp_n1);
% %         phi = angle(fft_s(index)+fft_s(index-1));
%     else
%         freq = f(index) + amp_p1./(amp_p1+amp)./N_fft.*2*pi;
%         amp = (amp^2+amp_p1^2)^0.5;
% %         phi = (angle(fft_s(index))*amp+angle(fft_s(index-1))*amp_p1)/(amp+amp_p1);
% %         phi = angle(fft_s(index)+fft_s(index+1));
%     end
% %     phi = angle(sum(fft_s((index-100):(index+100))));
%     phi = angle(sum(a.*exp(-1j*freq*n)));
%     
%     snr = amp^2/(sum(amp_s.^2)-amp^2);
%     
% %     plot(n, real(fft_s), n, imag(fft_s))
% end


function [freq, phi, amp, snr] = freq_est(a)

    N_fft = length(a);

    n = 0:(N_fft-1);

    f = (-(N_fft/2):(N_fft/2-1))./N_fft.*2*pi;

    fft_s = fftshift((fft(a)));
    amp_s = abs(fft_s);
    pwr_s = amp_s.^2;
    
    pwr_s1 = [pwr_s(2:(length(amp_s))), pwr_s(1)];

    [pwr, index] = max(pwr_s+pwr_s1);

    if index==N_fft
        amp_p1 = amp_s(1);
    else
        amp_p1 = amp_s(index+1);
    end

    freq = f(index) + amp_p1./(amp_p1+amp_s(index))./N_fft.*2*pi;
    phi = angle(sum(a.*exp(-1j*freq*n)));   
    amp = pwr^0.5;
    snr = amp^2/(sum(amp_s.^2)-amp^2);
end
