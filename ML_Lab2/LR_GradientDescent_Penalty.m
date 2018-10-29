%梯度下降法，有惩罚项
n = 100;
[r,r2] = drawData(n);
%把b加入w
x_0 = ones(100,1);
r = [x_0 r];
r2 = [x_0 r2];
Data = [r;r2];
w(1:3,1) = 1;
%生成决策界限
alpha = 0.001;

mu = 0.001;
[w,c] = gradient(Data,w,alpha,mu);

t = linspace(-5,15);
plot(t,-1/w(3)*(w(1)+w(2)*t));
axis([-10,20 -10,20]);

function [w,c] = gradient(Data,w,alpha,mu)
  c = 0;
  while true
    w_0 = w;
    w = w - alpha / 200 * Data(:,1:3)'*(sigmoid(Data,w)-Data(:,4)) -  mu / 200 * w;
    c = c + 1;
    if ( (max(w_0 - w) )< 10^(-6))
        break;
    end
  end
end

function [h_d] = sigmoid(Data,w)
  h_d = 1 ./(1+exp(-(Data(:,[1:3]) * w)));
 end