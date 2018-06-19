function[Ybus]=Ybus(zdata)
nl=zdata(:,1);
nr=zdata(:,2);
R=zdata(:,3);
X=zdata(:,4);
shunt=zdata(:,5);
shunt=shunt./2;
nbr=length(zdata(:,1));
nbus=max(max(nl),max(nr));
Z=R + j*X;
y=ones(nbr,1)./Z;
Ybus=zeros(nbus,nbus);
for k=1:nbr
    if nl(k)>0 & nr(k)>0
        Ybus(nl(k),nr(k))=Ybus(nl (k),nr(k))-y(k);
        Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
    end
end

for n=1:nbus
    for k=1:nbr
        if nl(k)==n | nr(k)==n
            Ybus(n,n)=Ybus(n,n)+y(k)+j*shunt(k);
        end
    end
end