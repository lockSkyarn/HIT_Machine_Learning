n = 100;
sigma = 0.7;
m = 1;
a(1:n,1) = 1;
mu = 1;

%����(0,2)�����x
x = rand(n,1)*2;
x = sortrows(x);
%���ɶ�Ӧ��yֵ
y = sin(2*pi*x);
%���ɷ�����̬�ֲ�(0,sigma^2)������
noise = normrnd(0,sigma,n,1);
y = y + noise;

%�ø߽׶���ʽ y=a +a1*x+a2*x^2+...+an*x^n�������,��������ߵĴ��������Ĵ���Ϊm
X = vander(x);
%ȡ��m+1��
X1 = X(:,n-m:n);
X2 = X(:,n-m-4:n);
X3 = X(:,n-m-9:n);
X4 = X(:,n-m-19:n);

%������ͼ��
t = linspace(0,2);

lambda1 = 0.000001;
a1 = a(1:2,:);
[a1,c]= gradient(a1,lambda1,X1,y,mu);
subplot(2,3,1)
draw(x,y,a1,t);
title(['m=1, ѧϰ�ʦ�1=',num2str(lambda1),'  �������� c=',num2str(c)]);

lambda2 = 0.000001; 
a2 = a(1:6,:);
[a2,c]= gradient(a2,lambda2,X2,y,mu);
subplot(2,3,2)
draw(x,y,a2,t);
title(['m=5, ѧϰ�ʦ�2=',num2str(lambda2),'  �������� c=',num2str(c)]);

lambda3 = 0.000002;
a3 = a(1:11,:);
[a3,c]= gradient(a3,lambda3,X3,y,mu);
subplot(2,3,4)
draw(x,y,a3,t);
title(['m=10, ѧϰ�ʦ�4=',num2str(lambda3),'  �������� c=',num2str(c),' mu=',num2str(mu)]);

lambda4 = 0.0000000000001;
a4 = a(1:21,:);
[a4,c]= gradient(a4,lambda4,X4,y,mu);
subplot(2,3,3)
draw(x,y,a4,t);
title(['m=20, ѧϰ�ʦ�3=',num2str(lambda4),'  �������� c=',num2str(c)]);

lambda5 = 0.000002;
a3 = a(1:11,:);
mu1 = 2;
[a3,c]= gradient(a3,lambda5,X3,y,mu1);
subplot(2,3,5)
draw(x,y,a3,t);
title(['m=10, ѧϰ�ʦ�5=',num2str(lambda5),'  �������� c=',num2str(c),'  mu1=',num2str(mu1)]);

lambda6 = 0.000002;
a3 = a(1:11,:);
mu2 = 4;
[a3,c]= gradient(a3,lambda6,X3,y,mu2);
subplot(2,3,6)
draw(x,y,a3,t);
title(['m=10, ѧϰ�ʦ�6=',num2str(lambda6),'  �������� c=',num2str(c),'  mu2=',num2str(mu2)]);

function [a,c] = gradient(a,lambda,X,y,mu)
c = 0;
while true
    a_o = a;
    a = a - lambda / 100 * X'*(X*a - y)-mu / 100 *a;
    c = c + 1;
    if ( (max(a_o - a) )< 10^(-3))
        break;
    end
end
end