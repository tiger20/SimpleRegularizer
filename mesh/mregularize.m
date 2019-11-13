function [X, Y, Z] = mregularize(xx, yy, idepths)

x = idepths;
x_bar = x;
x_old = x;

sigma = 25;
tau = 0.01;
theta = 0.5;
yLeft = zeros(length(yy), length(xx));
yUp = yLeft;

niters = 50;

for it = 1:niters
    for r = 2:length(yy)
        for c = 2:length(xx)
            de_xi_xj = x_bar(r,c) - x_bar(r-1, c);
            yUp(r,c) = proxFConj(yUp(r,c)+sigma*de_xi_xj);
            de_xi_xj = x_bar(r,c) - x_bar(r, c-1);
            yLeft(r,c) = proxFConj(yLeft(r,c)+sigma*de_xi_xj);
        end
    end

    for r = 2:length(yy)
        for c = 2:length(xx)
            x_old(r,c) = x(r,c);
            x_old(r-1,c) = x(r-1,c);
            x_old(r, c-1) = x(r,c-1);
            x(r,c) = x(r,c) - yUp(r,c)*tau;
            x(r,c) = x(r,c) - yLeft(r,c)*tau;
            x(r-1,c) = x(r-1,c) + yUp(r,c)*tau;
            x(r,c-1) = x(r,c-1) + yLeft(r,c)*tau;
        end
    end

    for r = 1:length(yy)
        for c = 1:length(xx)
            x_bar(r,c) = x(r,c) + theta*(x(r,c) - x_old(r,c));
        end
    end
end
w = 640;
h = 640;

ratio = 540.0/640.0;
fx = ratio*w;
fy = ratio*h;
cx = w/2.0;
cy = h/2.0;

K = zeros(3,3);
K(1,1) = fx;
K(1,3) = cx;
K(2,2) = fy;
K(2,3) = cy;
K(3,3) = 1.0;

X = [];
Y = [];
Z = [];

for ii = 1:length(xx)
    for jj = 1:length(yy)
        xyz = uv2xyz(xx(ii), yy(jj), x_bar(jj,ii), K);
        X = [X;xyz(1)];
        Y = [Y;xyz(2)];
        Z = [Z;xyz(3)];
    end
end
end
