function [F, obj] = solve_Y(K,A, F)

fKf = sum(F .* (K * F))';
ff = sum(F).^1;

fAf = sum(F .* (A * F))'; % c * 1
ff=ff';

m_all = vec2ind(F')';
iter = 1;

for j = 1:iter
    for i = 1:size(F, 1)
        m = m_all(i);
        if ff(m) == 1
            % avoid generating empty cluster
            continue;
        end
    
        Y_F = F' * K(:, i);
    
        fKf_s = fKf + 2 * Y_F + K(i, i);
        fKf_s(m) = fKf(m);
        ff_k = ff + 1;
        ff_k(m) = ff(m);

        Y_A = F' * A(:, i);
        
        fAf_s = fAf + 2 * Y_A + A(i, i); % assign i to all clusters and update
        fAf_s(m) = fAf(m); % cluster m keep the same


    
        fKf_0 = fKf;
        fKf_0(m) = fKf(m) - 2 * Y_F(m) + K(i, i);
        ff_0 = ff;
        ff_0(m) = ff(m) - 1;

        fAf_0 = fAf;
        fAf_0(m) = fAf(m) - 2 * Y_A(m) + A(i, i); % remove i from m
       
    
        delta = fKf_s ./ ff_k - fKf_0 ./ ff_0  + fAf_s - fAf_0;
    
        [~, p] = min(delta);
        if p ~= m
            fKf([m, p]) = [fKf_0(m), fKf_s(p)];
            fAf([m, p]) = [fAf_0(m), fAf_s(p)];
            ff([m, p]) = [ff_0(m), ff_k(p)];
    
            F(i, [p, m]) = [1, 0];
            m_all(i) = p;
        end
    end
    obj = sum(fKf ./ ff);
end    
    
    


     

end