program Schlussel;
uses crt;
var Wahl:byte;
function BitBefehl(pos:byte):byte;
var a:byte;
begin
 a:=1;
 while pos>0 do
  begin
   a:=a*2;
   pos:=pos-1;
  end;
 BitBefehl:=a;
end;
function btst(zwi,pos:byte):boolean;
begin
 if (BitBefehl(pos) and zwi)<>0 then btst:=true
                                else btst:=false;
end;
function bset(zwi,pos:byte):byte;
begin
 bset:=BitBefehl(pos) or zwi;
end;
function bclr(zwi,pos:byte):byte;
begin
 bclr:=(255-BitBefehl(pos)) and zwi;
end;
function bchg(zwi,pos:byte):byte;
begin
 if btst(zwi,pos) then bchg:=bclr(zwi,pos)
                  else bchg:=bset(zwi,pos);
end;
function eor(a,b:byte):byte;
var z:byte;
begin
 for z:=0 to 7 do
  begin
   if btst(b,z) then a:=bchg(a,z);
  end;
 eor:=a;
end;
function turn(a:byte):byte;
var b,c,d:byte;
begin
 for b:=0 to 7 do
  begin
   c:=7-b;
   if btst(a,b) then d:=bset(d,c)
                else d:=bclr(d,c);
  end;
 turn:=d;
end;
procedure Coding;
var SHand,DHand:file;
    SourName,DestName:string[30];
    WorkLen,WorkPos,Zahler,LenC,CodePos:integer;
    Puffer:array[0..1023] of byte;
    Supreme:byte;
    CoBy:array[1..30] of byte;
    charact:char;
    BytePos:real;
begin
 write('Source-Name: ');readln(SourName);
 write('Destination-Name: ');readln(DestName);
 write('Codierungswort: ');
 LenC:=0;
 repeat;
  charact:=readkey;
  LenC:=LenC+1;
  if ord(charact)<>13 then CoBy[LenC]:=ord(charact);
  write(charact);
 until ord(charact)=13;
 if LenC mod 2<>0 then
  begin
   LenC:=LenC+1;
   CoBy[LenC]:=65;
  end;
 writeln;
 assign(SHand,SourName);
 assign(DHand,DestName);
 reset(SHand);
 rewrite(DHand);
 rewrite(DHand);
 LenC:=LenC div 2;
 for Zahler:=1 to LenC do CoBy[Zahler]:=eor(CoBy[Zahler*2-1],turn(CoBy[Zahler*2]));
 CodePos:=0;
 clrscr;
 writeln('Stelle       %');
 WorkPos:=0;
 repeat
  BytePos:=WorkPos/filesize(SHand)*100;
  gotoxy(8,1);writeln(BytePos:5:2);
  WorkLen:=filesize(SHand)-WorkPos;
  WorkPos:=WorkPos+8;
  if WorkLen>8 then WorkLen:=8;
  blockread(SHand,Puffer,WorkLen);
  for Zahler:=0 to 128*WorkLen-1 do
   begin
    CodePos:=CodePos+1;
    if CodePos>LenC then CodePos:=1;
    Puffer[Zahler]:=eor(Puffer[Zahler],CoBy[CodePos]);
   end;
  blockwrite(DHand,Puffer,WorkLen);
 until filesize(SHand)<=WorkPos;
 close(SHand);
 close(DHand);
end;
begin
repeat
 clrscr;
 writeln('Ihre Wahl:');
 writeln;
 writeln(' 1 = Codieren');
 writeln(' 2 = Decodieren');
 writeln(' 3 = Ende');
 writeln;
 write('8=) ');readln(Wahl);
 case Wahl of
  1 : Coding;
  2 : Coding;
  end;
until Wahl=3;
end.