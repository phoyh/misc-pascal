program ghostype;
uses wincrt;
var n,len:integer;
    Text:array[1..10000] of char;
    Time:array[1..10000] of integer;
    Header:array[1..64] of integer;
    Handle:file;
begin
assign(Handle,'Ghost.dat');
reset(Handle);
blockread(Handle,Header,1);
len:=Header[1];
blockread(Handle,Text,Header[2]);
blockread(Handle,Time,Header[3]);
close(Handle);
clrscr;
for n:=1 to len-1
 do begin
  write(Text[n]);
  delay(Time[n]);
 end;
writeln;
end.