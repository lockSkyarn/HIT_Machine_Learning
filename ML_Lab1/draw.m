function []= draw(x,y,a,t)
scatter(x,y,'k.')
xlabel('x');
ylabel('y=sin(x)+ÔëÉù');
hold on;
plot(t,sin(2*pi*t));
plot(t,polyval(a,t));
axis([0,2 -3,3])
end