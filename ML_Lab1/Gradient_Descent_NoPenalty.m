n = 100;
sigma = 0.7;
m = 1;
a(1:n,1) = 1;

%生成(0,2)随机的x
x = rand(n,1)*2;
x = sortrows(x);
%生成对应的y值
y = sin(2*pi*x);
%生成服从正态分布(0,sigma^2)的噪声
noise = normrnd(0,sigma,n,1);
y = y + noise;

%用高阶多项式 y=a +a1*x+a2*x^2+...+an*x^n拟合曲线,设拟合曲线的次数最高项的次数为m
X = vander(x);
%取后m+1项
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
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a1,t));
axis([0, 2, -2, 2]);
title(['m=1, 学习率λ1=',num2str(lambda1),'  截至步长 c=',num2str(c)]);

lambda2 = 0.000001; 
a2 = a(1:6,:);
[a2,c]= gradient(a2,lambda2,X2,y);
subplot(2,2,2)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a2,t));
axis([0, 2, -2, 2]);
title(['m=5, 学习率λ2=',num2str(lambda2),'  截至步长 c=',num2str(c)]);

lambda3 = 0.000002;
a3 = a(1:11,:);
[a3,c]= gradient(a3,lambda3,X3,y);
subplot(2,2,3)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a3,t));
axis([0, 2, -2, 2]);
title(['m=10, 学习率λ3=',num2str(lambda3),'  截至步长 c=',num2str(c)]);

lambda4 = 0.0000000000000000000000000000000001;
a4 = a(1:21,:);
[a4,c]= gradient(a4,lambda4,X4,y);
subplot(2,2,4)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a4,t));
axis([0, 2, -2, 2]);
title(['m=20, 学习率λ4=',num2str(lambda4),'  截至步长 c=',num2str(c)]);

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