function [xx,yy] = product_data(m,sigma)
%����(0,2)�����x
n = m;
xx = cell(1,3);
for i=1:3
    xx{1,i} = sortrows(rand(n,1)*2);
    n = n/2;
end
%���ɶ�Ӧ��yֵ,���ɷ�����̬�ֲ�(0,sigma^2)������
yy = cell(1,3);
for i=1:3
    noise = normrnd(0,sigma,n,1);
    yy{1,i} = sin(2*pi*xx{1,i}) + noise;
    n = n/2;
end
end
