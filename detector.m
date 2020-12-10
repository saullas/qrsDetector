function qrs = detector(filename, M, sumWindow, alpha, gamma, step)
    S = load(filename);
    x = S.val(1,:);
    xLen = size(x, 2);
    
    y = zeros(1, xLen);
    
    % HPF Stage
    for i=M:xLen
        if i >= M
            y(i) = x(i-((M+1)/2)) - (1/M) * sum(x(i-(M-1):i));
        else
            y(i) = 0;
        end
    end
    
    
    
    
    % LPF Stage
    for i=1:(xLen - sumWindow - 1)
        y(i) = sum(y(i:i+sumWindow).^2);
    end
    
    
    % Decision making stage
    threshold = max(y(1:step));
    
    for i=1:step:(xLen - step)
        [peak, peakIndex] = max(y(i:i+step));
        
        if peak > threshold
            % nan to know where the peaks are
            y(peakIndex + i) = nan;
            threshold = alpha * gamma * peak + (1 - alpha) * threshold;
        end
    end
    
    
    % Find all peaks - Infinites
    qrs = find(isnan(y));
end