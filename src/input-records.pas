program Iput;
uses crt;
procedure input(var zw:string);
begin
 writeln(zw);
 zw:='Ha!';
end;
type macro=record name:string;
                  vorn:string;
                  alter:integer;
                  end;
var RelPos,Ordnung:integer;
    Zei:char;
    satz:array[1..3] of macro;
begin
with satz
 do begin
  for Ordnung:=1 to 3
   do begin
    Name[Ordnung]:='';
    Vorn[Ordnung]:='';
    Alter[Ordnung]:=0;
   end;
 end;
Ordnung:=0;
repeat
 clrscr;
 with satz do
 begin
  writeln('Name:   ',Name[RelPos]);
  writeln('Vorname:',Vorn[RelPos]);
  writeln('Alter:  ',alter[RelPos]);
  repeat;until keypressed;
  Zei:=readkey;
  Ordnung:=ord(Zei);
 end;
until Ordnung=27;
end.