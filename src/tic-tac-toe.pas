program Kreuz;
uses wincrt;
var a:array[1..9] of boolean;
    b:array[1..9] of boolean;
    c,d,f,g,h:integer;
    e:char;
begin
gotoxy(10,10);
write(' * *');
gotoxy(10,11);
write('*****');
gotoxy(10,12);
write(' * *');
gotoxy(10,13);
write('*****');
gotoxy(10,14);
write(' * *');
for c:=1 to 5 do begin
 for d:=1 to 2 do begin
  if ((c<5) or (d=1)) then begin
   gotoxy(1,1);
   writeln('Spieler ',d);
   repeat
   e:=ReadKey;
   f:=ord(e)-48;
   if b[f] then e:='t';
   until e<>'t';
   b[f]:=true;
   if d=1 then a[f]:=false
          else a[f]:=true;
   g:=10+2*((f-1) mod 3);
   h:=14-2*((f-1) div 3);
   gotoxy(g,h);
   if d=1 then write('O')
          else write('X');
  end;
 end;
end;
repeat;until KeyPressed;
end.