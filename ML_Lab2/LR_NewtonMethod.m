%ţ�ٷ�
n = 100;
[r,r2] = drawData(n);
%��b����w
x_0 = ones(100,1);
r = [x_0 r];
r2 = [x_0 r2];
Data = [r;r2];
%���ɾ��߽���
[w,c] = newton(Data);

t = linspace(-5,15);
plot(t,-1/w(3)*(w(1)+w(2)*t));
axis([-10,20 -10,20]);

function [w,c] = newton(Data)
w = ones(3,1);
c = 0;
while true
    h_w = sigmoid(Data,w);
    %���ݶ�
    grad = Data(:,1:3)' * (h_w-Data(:,4));
    %�� Hessian ����
    hessian = h_w' * (1 - h_w)*(Data(:,1:3)'* Data(:,1:3));
    temp = pinv(hessian)*grad;
    %��������
    w = w - temp;
    c = c + 1;
    if ((temp' * temp)<10^-4)
        break
    end
end
end

function [h_d] = sigmoid(Data,w)
  h_d = 1 ./(1+exp(-(Data(:,1:3) * w)));
 end