program raten;
uses wincrt;
var zahl,a,b,c,d,rat:integer;
begin
clrscr;
randomize;
write('Bereich angeben(1-?):');readln(c);
zahl:=random(c)+1;
write('Maximale Anzahl der Versuche:');readln(a);
for b:=1 to a do
 begin
  rat:=c+1;
  while rat>c do
   begin
    write(b,'.Versuch:');readln(rat);
   end;
  if rat=zahl then
   begin
    writeln('Richtig');b:=a;
   end
   else begin
    if rat>zahl then
     begin
     d:=trunc((rat-zahl)/5);
     case d of
      0:writeln('ein biﬂchen zu groﬂ');
      1:writeln('zu groﬂ');
      2:writeln('viel zu groﬂ')
      else writeln('groﬂer Witz');
     end;
     end
     else begin
     d:=trunc((zahl-rat)/5);
     case d of
      0:writeln('ein biﬂchen zu klein');
      1:writeln('zu klein');
      2:writeln('viel zu klein')
      else writeln('kleiner Witz');
     end;
    end;
   if a=b then writeln('Die Zahl war ',zahl);
   end;
  end;
while not(keypressed) do;
end.