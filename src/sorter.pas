program ordner;
uses crt;
var a:array[1..20] of integer;
    z:array[1..20] of string;
    b,c:integer;
    d:string;
    num:integer;
begin
clrscr;
write('Anzahl der Namen:');readln(num);
TextMode(1);
writeln('         Name                 Wert');
for b:=1 to num do begin
c:=b+2;gotoxy(1,c);
readln(z[b]);
gotoxy(31,c);
readln(a[b]);
end;
// phoyh-sort (abbreviated bubble sort)
for b:=1 to num-1 do begin
 if a[b]<a[b+1] then begin
  c:=a[b];a[b]:=a[b+1];a[b+1]:=c;
  d:=z[b];z[b]:=z[b+1];z[b+1]:=d;
  b:=b-1;
  if b>0 then b:=b-1;
 end;
end;
clrscr;
writeln('         Name                 Wert');
for b:=1 to num do begin
c:=b+2;gotoxy(1,c);
writeln(z[b]);
gotoxy(31,c);
writeln(a[b]);
end;
repeat;until KeyPressed;
end.