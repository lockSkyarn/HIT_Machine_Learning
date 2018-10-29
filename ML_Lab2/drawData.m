%生成数据，并绘图
function [r,r2] = drawData(n)
mu = [2 3];
SIGMA = [5 0; 0 5];
r = mvnrnd(mu,SIGMA,n);
y = zeros(n,1);
plot(r(:,1),r(:,2),'r+');
hold on;
r = [r,y];

mu = [7 8];
SIGMA = [ 5 0; 0 5];
r2 = mvnrnd(mu,SIGMA,n);
y2 = ones(n,1);
plot(r2(:,1),r2(:,2),'*');
r2 = [r2,y2];
end