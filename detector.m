function qrs = detector(filename, m)
    S = load(filename);
    x = S.val(1,1:1500);
    sigLen = size(x, 2);
    y = zeros(1, sigLen);
    
    plot(x)
    
    % HPF Stage
    for i=m+1:sigLen
        y(i) = x(i-(m+1)/2) - 1/m * sum(x(i-m:i));
    end
    
    
    % LPF Stage
    y_squared = y.^2;
    
    sumWindow = 24;
    
    for i=sumWindow:sigLen
        y(i) = y(i) + sum(y_squared(i-(sumWindow-1):i));
    end
    
    % Decision making stage
    alpha = 0.05;
    gamma = 0.17;
    step = 180;
    threshold = max(y(1:step));
    
    for i=1:sigLen
        [peak, peakIndex] = max(y(1:min(i+step,sigLen)));
        
        if peak > threshold
            % - infinity is peak
            y(peakIndex + 1) = - Inf;
            threshold = alpha * gamma * peak +(1 - alpha) * threshold;
        end
    end
    
    
    % Find all peaks - Infinites
    qrs = find(y == - Inf);
end