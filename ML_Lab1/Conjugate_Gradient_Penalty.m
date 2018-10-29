n = 100;
sigma = 0.2;
m = 1;
a(1:n,1) = 0;

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

lambda1 = 1;
lambda2 = 1;
lambda3 = 1;
lambda4 = 1;
lambda5 = 20;
lambda6 = 0.2;


t = linspace(0,2);

a1 = a(1:2,:);
[a1,c] = Con_Gradient(a1,X1,y,lambda1,2);
subplot(2,3,1);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a1,t));
axis([0,2 -2,2]);
title(['m=1, �������� c=',num2str(c)]);

a2 = a(1:6,:);
[a2,c] = Con_Gradient(a2,X2,y,lambda2,6);
subplot(2,3,2);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a2,t));
axis([0,2 -2,2]);
title(['m=5, �������� c=',num2str(c)]);

a3 = a(1:11,:);
[a3,c] = Con_Gradient(a3,X3,y,lambda3,11);
subplot(2,3,3);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a3,t));
axis([0,2 -2,2]);
title(['m=10, �������� c=',num2str(c)]);

a4 = a(1:21,:);
[a4,c] = Con_Gradient(a4,X4,y,lambda4,21);
subplot(2,3,4);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a4,t));
axis([0,2 -2,2]);
title(['m=20, �������� c=',num2str(c),', �ͷ��� lambda=', num2str(lambda4)]);

a5 = a(1:21,:);
[a5,c] = Con_Gradient(a5,X4,y,lambda5,21);
subplot(2,3,5);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a5,t));
axis([0,2 -2,2]);
title(['m=20, �������� c=',num2str(c), ', �ͷ��� lambda=', num2str(lambda5)]);

a6 = a(1:21,:);
[a6,c] = Con_Gradient(a6,X4,y,lambda6,21);
subplot(2,3,6);
scatter(x,y,'k.');
xlabel('x');
ylabel('y=sin(x)+����');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a6,t));
axis([0,2 -2,2]);
title(['m=20, �������� c=',num2str(c),', �ͷ��� lambda=', num2str(lambda6)]);

function [a,c] = Con_Gradient(a,X,y,lambda,num)
B = X'* X + lambda * eye(num);
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