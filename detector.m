function qrs = detector(filename, M, sumWindow, alpha, gamma, step)
    S = load(filename);
    x = S.val(1,1:1300);
    xLen = size(x, 2);
    
    y = zeros(1, xLen);
    
    p1 = plot(x, 'color', 'b');
    hold on;
    
    % HPF Stage
    for i=M:xLen
        if i >= M
            y(i) = x(i-((M+1)/2)) - (1/M) * sum(x(i-(M-1):i));
        else
            y(i) = 0;
        end
    end
    
    p2 = plot(y, 'color', 'r');
    hold on;
    
    
    % LPF Stage
    for i=1:(xLen - sumWindow - 1)
        y(i) = sum(y(i:i+sumWindow).^2);
    end
    
    % p3 = plot(y, 'color' ,'cyan');
    % hold on;
    
    % Decision making stage
    threshold = max(y(1:step));
    
    for i=1:step:(xLen - step)
        [peak, peakIndex] = max(y(i:i+step));
        
        if peak >= threshold
            % nan to know where the peaks are
            y(i + peakIndex) = nan;
            threshold = alpha * gamma * peak + (1 - alpha) * threshold;
        end
    end
    
    legend([p1, p2], {'original signal', 'after HPF'});
    hold off;
    
    % Find all peaks
    qrs = find(isnan(y));
end