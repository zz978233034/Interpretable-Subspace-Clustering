function Z = norm_data(Z,method)

if strcmp('l2_norm',method)
    Z = double(Z);
    Z = normc(Z);
  
end

if strcmp('trig_normalize',method)
    X_min = min(Z, [], 2);  
    X_max = max(Z, [], 2);  
    
    mode = 'sin';
    range = X_max - X_min;
    range(range == 0) = 1;  
    X_scaled = (Z - X_min) ./ range * pi;  

    if strcmpi(mode, 'sin')
        X_normalized = sin(X_scaled);
    elseif strcmpi(mode, 'cos')
        X_normalized = cos(X_scaled);
    else
        error(' "sin" or "cos"');
    end
    Z = X_normalized;
end