n = 100;   
sigma = 0.7;   
m = 1;

%����(0,2)�����x
xx = cell(1,3);
for i=1:3
    xx{1,i} = sortrows(rand(n,1)*2);
    n = n/2;
end
%���ɶ�Ӧ��yֵ,���ɷ�����̬�ֲ�(0,sigma^2)������
yy = cell(1,3);
n = 100;
for i=1:3
    noise = normrnd(0,sigma,n,1);
    yy{1,i} = sin(2*pi*xx{1,i}) + noise;
    n = n/2;
end

%�ø߽׶���ʽ y=a +a1*x+a2*x^2+...+an*x^n�������,��������ߵĴ��������Ĵ���Ϊm
X = vander(xx{1,1});
X1 = vander(xx{1,2});
X2 = vander(xx{1,3});
%ȡ��m+1��
n = 100;
XZ = cell(1,6);
XZ{1,1} = X(:,n-m:n);
XZ{1,2} = X(:,n-m-4:n);
XZ{1,3} = X(:,n-m-9:n);
XZ{1,4} = X(:,n-m-19:n);
XZ{1,5} = X1(:,50-m-19:50);
XZ{1,6} = X2(:,25-m-19:25);

%ʹ�ý�����
A = cell(1,6);
for i=1:4
    A{1,i} = pinv(XZ{1,i}'*XZ{1,i})*XZ{1,i}'*yy{1,1};
end
A{1,5} = pinv(XZ{1,5}'*XZ{1,5})*XZ{1,5}'* yy{1,2};
A{1,6} = pinv(XZ{1,6}'*XZ{1,6})*XZ{1,6}'*yy{1,3};
M = [1;5;10;20];

%������ͼ��
t = linspace(0,2);

for i=1:4
    subplot(2,3,i);
    draw(xx{1,1},yy{1,1},A{1,i},t);
    title(['m=',num2str(M(i))]);
end
suptitle('n=100,u=0.7');
for i=5:6
    subplot(2,3,i);
    draw(xx{1,i-3},yy{1,i-3},A{1,i},t);
    title(['m=20, n=',num2str(n/(2^(i-4)))])
end