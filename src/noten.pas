program GradeCheck;
function head(s:String):String;
 var k:integer;
 begin
  k:=2;
  while copy(s,k,1)<=' ' do k:=k+1;
  head:=copy(s,1,k-1);
 end;
function tail(s:String):String;
 var k:integer;
 begin
  k:=length(s);
  while ord(s[k])>32 do k:=k-1;
  tail:=copy(s,k+1,length(s)-k);
 end;
var num:array[1..11] of integer;
    n:integer;
procedure regist(s:String);
 var i:integer;
     j:integer;
     r:real;
 begin
  if length(s)>1 then s[2]:='.';
  val(s,r,j);
  i:=round(r*3-2);
  if i>10 then i:=11;
  num[i]:=num[i]+1;
  n:=n+1;
 end;
var tabelle,out:text;
    zwi:String;
    i,j,m:integer;
begin
 n:=0;
 assign(tabelle,'g:\langues\swt.txt');
 reset(tabelle);
 while not(eof(tabelle)) do begin
  readln(tabelle,zwi);
  regist(tail(zwi));
 end;
 close(tabelle);
 assign(out,'g:\langues\swt-bil.txt');
 rewrite(out);
 m:=0;
 for i:=1 to 11 do begin
  if i=11 then zwi:='5.0'
   else begin
    j:=(i+2) div 3;
    zwi:=chr(j+48);
    j:=i+2-j*3;
    if j=0 then zwi:=zwi+'.0';
    if j=1 then zwi:=zwi+'.3';
    if j=2 then zwi:=zwi+'.7';
   end;
  m:=m+num[i];
  writeln(out,zwi,'   ',(100*m) div n,'  ',num[i]);
 end;
 close(out);
end.
