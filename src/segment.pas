program Segment;
uses crt;
var a,b,c,d:boolean;
    e,f:integer;
begin
e:=0;
repeat
TextMode(1);
gotoxy(28,18);
write('+++++');
e:=0;
for e:=1 to 5 do begin
f:=e+18;
gotoxy(28,f);
write('+   +');
end;
gotoxy(28,24);
write('+++++');
gotoxy(1,1);
a:=false;b:=false;c:=false;d:=false;
write('Bin„rdarstellung:');readln(e);
if e<10000 then begin
if e>999
 then begin
  e:=e-1000;a:=true;
 end;
if e>99
 then begin
  e:=e-100;b:=true;
 end;
if e>9
 then begin
  e:=e-10;c:=true;
 end;
if e=1 then d:=true;
if (((not a) and c) or ((not d) and (a or (not b))) or (b and c) or (a and (not b) and (not c)) or ((not a) and b and d))
 then begin
 gotoxy(30,19);write('*');
 end;
if ((a and c and d) or ((not c) and ((a and (not b)) or ((not a) and b))) or ((not d) and (a or b or (not c))))
 then begin
 gotoxy(29,20);write('*');
 end;
repeat;until KeyPressed;
end;
until e>=10000;
end.