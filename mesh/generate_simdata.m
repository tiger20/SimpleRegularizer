function [xx,yy,idepths] = generate_simdata(w,h)
% X = [];
% Y = [];
% Z = [];
% xyzs = [];
% idepths = [];
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

delta = 20.0;
xx = delta:delta:w;
yy = delta:delta:h;

% zz = zeros(length(xx), length(yy));
% mesh(xx,yy,zz)

idepths = zeros(length(yy),length(xx));

for xi = 1:length(xx)
    for yi = 1:length(yy)
        idepth = 0;
        if(xx(xi) > w/2)
            idepth = 0.4 + randn(1,1)*0.01;
        else
            idepth = 0.8 + randn(1,1)*0.03;
        end
        if idepth < 0.2
            idepth = 0.2;
        end
        if idepth > 1.0
            idepth = 1.0;
        end
        xyz = uv2xyz(xx(xi),yy(yi),idepth,K);
%         X = [X;xyz(1)];
%         Y = [Y;xyz(2)];
%         Z = [Z;xyz(3)];
        idepths(yi,xi) = idepth;
%         xyzs = [xyzs;xyz];
    end
end
end





