program fd;
uses wincrt;
var n,m,t:longint;
    step:array[1..48] of byte;
    k:integer;
procedure Check;
begin
 while n mod t=0 do
  begin
   n:=n div t;
   write(t,'*');
  end;
end;
begin
// distance between adjacent prime pairs starting with 11 & 13
step[1]:=2;step[2]:=4;step[3]:=2;step[4]:=4;step[5]:=6;step[6]:=2;
step[7]:=6;step[8]:=4;step[9]:=2;step[10]:=4;step[11]:=6;step[12]:=6;
step[13]:=2;step[14]:=6;step[15]:=4;step[16]:=2;step[17]:=6;step[18]:=4;
step[19]:=6;step[20]:=8;step[21]:=4;step[22]:=2;step[23]:=4;step[24]:=2;
step[25]:=4;step[26]:=8;step[27]:=6;step[28]:=4;step[29]:=6;step[30]:=2;
step[31]:=4;step[32]:=6;step[33]:=2;step[34]:=6;step[35]:=6;step[36]:=4;
step[37]:=2;step[38]:=4;step[39]:=6;step[40]:=2;step[41]:=6;step[42]:=4;
step[43]:=2;step[44]:=4;step[45]:=2;step[46]:=10;step[47]:=2;step[48]:=10;
repeat
 write('Zahl:');readln(n);
 m:=n;
 if n>0 then begin
 t:=2;Check;
 t:=3;Check;
 t:=5;Check;
 t:=7;Check;
 t:=11;
 repeat
  Check;
  k:=k+1;
  if k=49 then k:=1;
  t:=t+step[k];
 until t>sqrt(n);
 if n<>1 then begin
  if n<>m then write(n,' ')
          else writeln('Primzahl!');
 end;
 if n<>m then writeln(chr(8),'=');
 end;
until n=0;
end.