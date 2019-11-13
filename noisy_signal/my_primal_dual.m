clc,clear

N = 300;

z = randn(N,1)*0.3;
z(1:N/2) = z(1:N/2) + 4;

x = z;
x_old = x;
x_bar = x;
y = zeros(N,1);

plot(z)

niters = 50;

sigma = 25;
tau = 0.01;
theta = 0.5;

for i = 1:niters
   for j = 2:N
       de_xi_xj = x_bar(j) - x_bar(j-1);
       y(j) = proxFConj(y(j)+sigma*de_xi_xj);
   end
   
   for j = 2:N
       x_old(j) = x(j);
       x_old(j-1) = x(j-1);
       x(j) = x(j) - y(j)*tau;
       x(j-1) = x(j-1) + y(j)*tau;
   end
   
   for j = 1:N
       x_bar(j) = x(j) + theta*(x(j) - x_old(j));
   end
end

hold on
plot(x_bar)
