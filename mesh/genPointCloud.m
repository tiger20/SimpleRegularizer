function [X,Y,Z] = genPointCloud(xx,yy,idepths)
w = 640;
h = 640;

X = [];
Y = [];
Z = [];
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

xyz = [];

for row = 1:length(yy)
    for col = 1:length(xx)
        xyz_ = uv2xyz(xx(col), yy(row), idepths(row,col),K);
%         xyz = [xyz;xyz_];
        X = [X;xyz_(1)];
        Y = [Y;xyz_(2)];
        Z = [Z;xyz_(3)];
    end
end
end