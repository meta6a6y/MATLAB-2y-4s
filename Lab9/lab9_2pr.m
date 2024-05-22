%����� 2-�� �����������
% ��� �����
h=0.2;
 
x=0:h:pi;
n=length(x);
 
syms f(m);
f(m) = cos(m)*exp(m^2);
%������������� ������� cos(x)*exp(x^2)
%������ ����������� 2*x*exp(x^2)*cos(x) - exp(x^2)*sin(x)
d2y= 2.*x.*exp(x.^2).*cos(x) - exp(x.^2).*sin(x);
 
%��������� ������ ����������� �� ������� (8)
for i=2:(n-1)
    d2y1(i)=(f(x(i+1))-f(x(i))+f(x(i-1)))/h^2;
    err1(i)=abs(d2y(i)-d2y1(i));
end
 
%��������� ������ ����������� �� ������� (10)
for i=3:(n-2)
    d2y2(i)=(f(x(i+2))+16*f(x(i+1))-30*f(x(i))+...
                    16*f(x(i-1))-f(x(i-2)))/(12*h^2);
    err2(i)=abs(d2y(i)-d2y2(i));
end
 
%������ ���������� ������ �� ����� �������
plot(x([2:(n-1)]),err1([2:(n-1)]),'-*r',...
     x([3:(n-2)]),err2([3:(n-2)]),'-pb');
 
title('����������� ����������� 2-� �������');
legend('II ������� ��������', 'IV ������� ��������');
grid on;
