program Evolution;
uses Graph,crt;

const MaxAnzahl=1000;
      RandomSearchRadius=30;
      SichtRadius=30;
      PaarDauer=15;
      AustragenDauer=1000;
      PaarDesireLimit=200;
      ReifeAlter=-4000;
      JungsProzent=50;
      PaarErfolgProzent=60;

var DirX,DirY:array[1..MaxAnzahl] of real;
    x,y,StepsToGo,DestX,DestY:array[1..MaxAnzahl] of integer;
    PaarDesire,BusyRounds:array[1..MaxAnzahl] of integer;
    AnzWesen:integer;
    turn,Sicht1,Sicht2,Abstand,io:integer;

{$I evo_flag}
{$I evo_init}

procedure NewDesire(a:integer);
begin
 if PaarDesire[a]>PaarDesireLimit then SetPaarDes(a)
                                  else ClrPaarDes(a);
end;
procedure InitGo(a:integer);
var u:real;
begin
 DirX[a]:=DestX[a]-x[a];
 DirY[a]:=DestY[a]-y[a];
 u:=sqrt(sqr(DirX[a])+sqr(DirY[a]))*1.4;
 if u=0
 then StepsToGo[a]:=0
 else begin
  SetGo(a);
  DirX[a]:=DirX[a]/u;
  DirY[a]:=DirY[a]/u;
  StepsToGo[a]:=round(u);
 end;
end;
procedure Go(a:integer);
begin
 StepsToGo[a]:=StepsToGo[a]-1;
 putpixel(x[a],y[a],0);
 x[a]:=round(DestX[a]-StepsToGo[a]*DirX[a]);
 y[a]:=round(Desty[a]-StepsToGo[a]*DirY[a]);
 putpixel(x[a],y[a],1+(Attribut[a] and (MannFlag+SchwangerFlag)));
 if StepsToGo[a]=0 then ClrGo(a);
end;
procedure RandomSearch(a:integer);
begin
 Status[a]:=0;
 DestX[a]:=abs(x[a]+trunc(random(RandomSearchRadius*2))-RandomSearchRadius);
 DestY[a]:=abs(y[a]+trunc(random(RandomSearchRadius*2))-RandomSearchRadius);
 if DestX[a]>639 then DestX[a]:=1279-DestX[a];
 if DestY[a]>479 then DestY[a]:=959-DestY[a];
 InitGo(a);
end;
procedure TestAnziehen(a,b:integer);
begin
if not(TestPaar(a) and TestGo(a)) and TestPaarDes(a) and
 (TestMann(a) xor TestMann(b)) and not(TestSchwanger(a)) and
 not(TestSchwanger(b)) then begin
  SetPaar(a);
  DestX[a]:=(x[b]+x[a]) div 2;
  DestY[a]:=(y[b]+y[a]) div 2;
  InitGo(a);
 end;
end;
procedure TestPaarung(a,b:integer);
begin
if TestPaarDes(a) and TestPaarDes(b) and (TestMann(a) xor TestMann(b))
 and not(TestBusy(a)) and not(TestBusy(b)) then begin
  SetBusy(a);SetBusy(b);
  ClrGo(a);ClrGo(b);
  BusyRounds[a]:=PaarDauer;
  BusyRounds[b]:=PaarDauer;
 end;
end;
procedure EndOfBusy(a:integer);
begin
 if TestSchwanger(a) then begin
  ClrSchwanger(a);
  PaarDesire[a]:=0;
  ClrBusy(a);
  NewDesire(a);
  AnzWesen:=AnzWesen+1;
  x[AnzWesen]:=x[a];y[AnzWesen]:=y[a];
  Status[AnzWesen]:=0;
  Attribut[AnzWesen]:=0;
  if random(100)<JungsProzent then SetMann(AnzWesen)
                              else ClrMann(AnzWesen);
  PaarDesire[AnzWesen]:=ReifeAlter;
  NewDesire(AnzWesen);
 end;
 if TestPaarDes(a) then begin
  PaarDesire[a]:=0;
  ClrBusy(a);
  NewDesire(a);
  ClrPaar(a);
  if not(TestMann(a)) and (random(100)<PaarErfolgProzent) then begin
   SetSchwanger(a);
   BusyRounds[a]:=AustragenDauer;
   ClrPaarDes(a);
  end;
 end;
end;
begin
GraphInit;
randomize;
AnzWesen:=2;
for turn:=1 to AnzWesen do begin
 x[turn]:=trunc(random(639));
 y[turn]:=trunc(random(479));
 Status[turn]:=0;
 Desire[turn]:=0;
 Attribut[turn]:=MannFlag*trunc(random(2));
 PaarDesire[turn]:=0;
 NewDesire(turn);
end;
Attribut[1]:=MannFlag;
Attribut[2]:=Attribut[2] and (255-MannFlag);
x[1]:=x[2];y[1]:=y[2];
repeat
 for turn:=1 to AnzWesen do begin
  PaarDesire[turn]:=PaarDesire[turn]+1;
  if BusyRounds[turn]>0 then begin
   BusyRounds[turn]:=BusyRounds[turn]-1;
   if BusyRounds[turn]=0 then EndOfBusy(turn);
  end;
  if not(TestBusy(turn)) then begin
   if Status[turn]=0 then begin
    NewDesire(turn);RandomSearch(turn);
   end;
   if TestGo(turn) then begin
    Go(turn);
    for io:=10 to trunc(8000/AnzWesen) do nosound;
   end;
  end;
 end;
 for Sicht1:=1 to AnzWesen-1 do begin
  for Sicht2:=Sicht1+1 to AnzWesen do begin
   Abstand:=abs(x[Sicht1]-x[Sicht2])+abs(y[Sicht1]-y[Sicht2]);
   if Abstand=0 then begin
    TestPaarung(Sicht1,Sicht2);
   end;
   if (Abstand<SichtRadius) and not(TestBusy(Sicht1)) then begin
    TestAnziehen(Sicht1,Sicht2);
   end;
   if (Abstand<SichtRadius) and not(TestBusy(Sicht2)) then begin
    TestAnziehen(Sicht2,Sicht1);
   end;
  end;
 end;
until keypressed;
CloseGraph;
end.