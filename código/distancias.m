function val_x=distancias(r)
global anchoP anchoG anchoM anchoH;

r1=(anchoP+anchoG+anchoM+anchoH);
r2=(anchoG+anchoM+anchoH);
r3=(anchoM+anchoH);
r4=(anchoH);
y=abs(r(1, 2));

if r1>y && y>r2
    val_x=circulo1(r);
elseif r2>y && y>r3
    val_x=circulo2([r, r2]);
elseif r3>y && y>r4
    val_x=circulo3([r, r2, r3]);
elseif y<r4
    val_x=circulo4([r, r2, r3, r4]);
else
    val_x=zeros(1,7);
end 
end

function d=circulo1(pos)
d=zeros(1, 7);
x1=pos(1,1);
d(1,1)=abs(-2*x1);
end

function d=circulo2(pos)
d=zeros(1, 7);
y=pos(1,2);
r=pos(1,4);
x1=pos(1,1);
x4=-x1;
x2=-sqrt(r^2-y^2);
x3=-x2;
d(1,1)=abs(x1-x2);
d(1,2)=abs(x2-x3);
d(1,7)=abs(x3-x4);
end

function d=circulo3(pos)
d=zeros(1, 7);
y=pos(1,2);
r1=pos(1,4);
r2=pos(1,5);
x1=pos(1,1);
x6=-x1;
x2=-sqrt(r1^2-y^2);
x5=-x2;
x3=-sqrt(r2^2-y^2);
x4=-x3;
d(1,1)=abs(x1-x2);
d(1,2)=abs(x2-x3);
d(1,3)=abs(x3-x4);
d(1,6)=abs(x4-x5);
d(1,7)=abs(x5-x6);
end

function d=circulo4(pos)
d=zeros(1, 7);
y=pos(1,2);
r1=pos(1,4);
r2=pos(1,5);
r3=pos(1,6);
x1=pos(1,1);
x8=-x1;
x2=-sqrt(r1^2-y^2);
x7=-x2;
x3=-sqrt(r2^2-y^2);
x6=-x3;
x4=-sqrt(r3^2-y^2);
x5=-x4;
d(1,1)=abs(x1-x2);
d(1,2)=abs(x2-x3);
d(1,3)=abs(x3-x4);
d(1,4)=abs(x4-x5);
d(1,5)=abs(x5-x6);
d(1,6)=abs(x6-x7);
d(1,7)=abs(x7-x8);
end
