function [xx,yy] = product_data(m,sigma)
%生成(0,2)随机的x
n = m;
xx = cell(1,3);
for i=1:3
    xx{1,i} = sortrows(rand(n,1)*2);
    n = n/2;
end
%生成对应的y值,生成服从正态分布(0,sigma^2)的噪声
yy = cell(1,3);
for i=1:3
    noise = normrnd(0,sigma,n,1);
    yy{1,i} = sin(2*pi*xx{1,i}) + noise;
    n = n/2;
end
end
