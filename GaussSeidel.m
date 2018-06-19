clear all;
clc;
zdata=load('zdata.dat');
Y=Ybus(zdata);

busdata = load('busdata.dat');

V=busdata(:,6);
P=busdata(:,4)-busdata(:,2);
Q=busdata(:,5)-busdata(:,3);
n=size(busdata,1);
for m=1:10
 for i=2:n
    V(i)=(P(i)-j*Q(i))/conj(V(i));
    for k=1:n
        if k==i
            continue;
        end
        V(i)=V(i)-Y(i,k)*V(k);
    end
    V(i)=V(i)/Y(i,i);
 end
end
V
I=V(1)*(Y(1,:));
Slack=V(1)*I;
SlackPower=sum(Slack(:))