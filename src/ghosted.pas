program ghosted;
uses wincrt;
var buch,len,timer:integer;
    Text:array[1..10000] of char;
    Time:array[1..10000] of integer;
    Header:array[1..64] of integer;
    Handle:file;
    Charact:char;
begin
len:=0;
clrscr;
repeat;
 timer:=0;
 buch:=0;
 repeat;
  timer:=timer+1;
  if keypressed then
   begin
    Charact:=readkey;
    buch:=ord(Charact);
   end;
 until buch<>0;
 if buch<>27 then write(Charact);
 len:=len+1;
 Time[len]:=timer div 14;
 Text[len]:=Charact;
 repeat;until not(keypressed);
until buch=27;
Text[len]:=chr(13);
assign(Handle,'Ghost.dat');
rewrite(Handle);
Header[1]:=len;
Header[2]:=(len+127) div 128;
Header[3]:=(len+63) div 64;
blockwrite(Handle,Header,1);
blockwrite(Handle,Text,Header[2]);
blockwrite(Handle,Time,Header[3]);
close(Handle);
end.