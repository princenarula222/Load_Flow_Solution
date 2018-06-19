clear all;
clc;
zdata=load('zdata.dat');
Y=Ybus(zdata);

data=load('busdata.dat');

V=data(:,6);
P=data(:,4)-data(:,2);
Q=data(:,5)-data(:,3);
n=size(data,1);
spec1=P;
spec2=Q;


for i=1:n
    t=0;
    for m=1:n
        t=t+conj(V(i))*V(m)*Y(i,m);
    end
        P(i)=real(t);
        Q(i)=-1*imag(t);
end

G=real(Y);
B=imag(Y);

for s=1:10
 calc=zeros(2*(n-1),1);
 e=real(V);
 f=imag(V);
 for i=2:n
    for m=2:n
        if i~=m
            abm=(G(i,m)+j*B(i,m))*(e(m)+j*f(m));
            H(i-1,m-1)=real(abm)*f(i)-imag(abm)*e(i);
            L(i-1,m-1)=H(i-1,m-1);
            N(i-1,m-1)=real(abm)*e(i)+imag(abm)*f(i);
            J(i-1,m-1)=-N(i-1,m-1);
        end
    end
    H(i-1,i-1)=-Q(i)-B(i,i)*(abs(V(i))^2);
    N(i-1,i-1)=P(i)+G(i,i)*(abs(V(i))^2);        
    J(i-1,i-1)=P(i)-G(i,i)*(abs(V(i))^2);
    L(i-1,i-1)=Q(i)-B(i,i)*(abs(V(i))^2);
 end

 for i=2:n
    calc(i-1)=angle(V(i));
 end
 for i=2:n
    calc(n+i-2)=abs(V(i));
 end

 res1=spec1-P;
 res2=spec2-Q;
 jacob=[H , N; J, L];
 prev=[res1(2:n) ; res2(2:n)];
 pv=[];
 for i=2:n
    if spec2(i)==1j
        pv=[pv i];
        calc(n+i-2)=[];
        prev(n+i-2)=[];
        jacob(n+i-2,:)=[];
        jacob(:,n+i-2)=[];
    end
 end


 del=pinv(jacob)*prev;
 calc=calc+del;

 for i=2:n
    k=find(pv==i);
    if isempty(k)
        V(i)=calc(n+i-2)*exp(j*calc(i-1));
    else
        V(i)=abs(V(i))*exp(j*calc(i-1));
    end
 end
 
 for i=1:n
    t=0;
    for m=1:n
        t=t+conj(V(i))*V(m)*Y(i,m);
    end
        P(i)=real(t);
        Q(i)=-1*imag(t);
 end

end
BusVoltagesPolarForm=[abs(V) angle(V)];
Y
V
BusVoltagesPolarForm
P
Q
S=P+j*Q