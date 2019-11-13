function xyz = uv2xyz(u,v,idepth,K)
xyz = zeros(1,3);
xyz(1) = (u-K(1,3))/(K(1,1)*idepth);
xyz(2) = (v-K(2,3))/(K(2,2)*idepth);
xyz(3) = 1.0/idepth;
end