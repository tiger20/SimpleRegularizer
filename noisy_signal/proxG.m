function pr = proxG(u,lambda, z, x)

pr = zeros(length(u), 1);

for i = 1:length(u)
    xi_zi = x(i)-z(i);
    pr_i = 0;
    if xi_zi > lambda
        pr_i = xi_zi - lambda;
    elseif xi_zi < -lambda
        pr_i = xi_zi + lambda;
    else
        pr_i = 0;
    end
    pr(i) = pr_i + z(i);
end
    