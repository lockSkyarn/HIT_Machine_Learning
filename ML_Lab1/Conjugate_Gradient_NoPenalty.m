n = 100;
sigma = 0.2;
m = 1;
a(1:n,1) = 0;

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

a1 = a(1:2,:);
[a1,c] = Con_Gradient(a1,X1,y);
subplot(2,2,1);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a1,t));
axis([0,2 -2,2]);
title(['m=1, 迭代次数 c=',num2str(c)]);

a2 = a(1:6,:);
[a2,c] = Con_Gradient(a2,X2,y);
subplot(2,2,2);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a2,t));
axis([0,2 -2,2]);
title(['m=5, 迭代次数 c=',num2str(c)]);

a3 = a(1:11,:);
[a3,c] = Con_Gradient(a3,X3,y);
subplot(2,2,3);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a3,t));
axis([0,2 -2,2]);
title(['m=10, 迭代次数 c=',num2str(c)]);

a4 = a(1:21,:);
[a4,c] = Con_Gradient(a4,X4,y);
subplot(2,2,4);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+噪声');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a4,t));
axis([0,2 -2,2]);
title(['m=20, 迭代次数 c=',num2str(c)]);

function [a,c] = Con_Gradient(a,X,y)
B = X'* X;
r = X'* y - B * a;
p = r;
c = 0;

while true
    alpha = (r'* r)/(p'* B * p);
    a = a + alpha * p;
    r_o = r;
    r = r - alpha * B * p;
    if (r<10^(-6))
        break;
    end
    beta = (r'* r)/(r_o' * r_o);
    p = r + beta * p;
    c = c + 1;
end
end