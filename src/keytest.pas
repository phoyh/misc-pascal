program TestKey;
uses crt;
var b:integer;
    a:char;
begin
 a:='A';
 while ord(a)<>13 do begin
  a:=readkey;
  writeln(ord(a));
 end;
end.
