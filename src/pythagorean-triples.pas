program PyTupel;
uses wincrt;
var a,b,c,i,j:integer;
    z:real;
const Grenze=50;
begin
clrscr;
i:=2;
TextMode(0);
TextColor(2);
TextBackground(0);
// squares are DOS-encoded
writeln('   aý   +   bý   =   cý');
writeln;
TextColor(1);
for c:=1 to Grenze do begin
 for b:=1 to Grenze do begin
  if b=c then b:=Grenze
  else begin
   z:=sqrt(sqr(c)-sqr(b));
   a:=trunc(z);
   if sqr(a)=sqr(z) then begin
    if a>b then begin
     j:=a;a:=b;b:=j;
     end;
    i:=i+1;
    j:=5-trunc(ln(a)/ln(10));
    gotoxy(j,i);
    write(a);
    j:=14-trunc(ln(b)/ln(10));
    gotoxy(j,i);
    write(b);
    j:=23-trunc(ln(c)/ln(10));
    gotoxy(j,i);
    writeln(c);
    b:=Grenze;
   end;
  if i=25 then i:=24
  end;
 end;
end;
repeat
until KeyPressed;
end.