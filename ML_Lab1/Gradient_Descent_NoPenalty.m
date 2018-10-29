n = 100;
sigma = 0.7;
m = 1;
a(1:n,1) = 1;

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

t = linspace(0,2);

lambda1 = 0.00001;
a1 = a(1:2,:);
[a1,c]= gradient(a1,lambda1,X1,y);
subplot(2,2,1)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a1,t));
axis([0, 2, -2, 2]);
title(['m=1, ѧϰ�ʦ�1=',num2str(lambda1),'  �������� c=',num2str(c)]);

lambda2 = 0.000001; 
a2 = a(1:6,:);
[a2,c]= gradient(a2,lambda2,X2,y);
subplot(2,2,2)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a2,t));
axis([0, 2, -2, 2]);
title(['m=5, ѧϰ�ʦ�2=',num2str(lambda2),'  �������� c=',num2str(c)]);

lambda3 = 0.000002;
a3 = a(1:11,:);
[a3,c]= gradient(a3,lambda3,X3,y);
subplot(2,2,3)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a3,t));
axis([0, 2, -2, 2]);
title(['m=10, ѧϰ�ʦ�3=',num2str(lambda3),'  �������� c=',num2str(c)]);

lambda4 = 0.0000000000000000000000000000000001;
a4 = a(1:21,:);
[a4,c]= gradient(a4,lambda4,X4,y);
subplot(2,2,4)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a4,t));
axis([0, 2, -2, 2]);
title(['m=20, ѧϰ�ʦ�4=',num2str(lambda4),'  �������� c=',num2str(c)]);

function [a,c] = gradient(a,lambda,X,y)
c = 0;
while true
    a_o = a;
    a = a - lambda /100 * X'*(X*a - y);
    c = c + 1;
    if ( (max(a_o - a) )< 10^(-6))
        break;
    end
end
end