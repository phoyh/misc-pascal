program list;
uses crt;
type str=record Name:string[20];
                Alter:integer;
                Gesch:boolean;
                end;
     filetype=file of str;
var n,anz,swap:integer;
    ende,found:boolean;
    Wahl3,Wahl2,Wahl:char;
    secfile,filename:string[20];
    Handle,Handle2:filetype;
    satz,satz2:str;
procedure Schablon(x:integer);
 begin
  clrscr;
  writeln(x,'. Teilnehmer:');
  writeln;
  writeln('Name:');
  writeln('Alter:');
  writeln('Geschlecht(M/W):');
 end;
procedure Edit(DateiName:string);
 begin
  assign(Handle,DateiName);
  rewrite(Handle);
  clrscr;
  write('Wie viele Teilnehmer? ');readln(anz);
  for n:=1 to anz do
   begin
    Schablon(n);
    gotoxy(20,3);readln(Satz.Name);
    gotoxy(20,4);readln(Satz.Alter);
    gotoxy(20,5);Wahl:=upcase(readkey);
    if Wahl='W' then Satz.Gesch:=true
                else Satz.Gesch:=false;
    write(Handle,satz);
   end;
  close(Handle);
 end;
procedure SmartCop(DateiName:string);
var DestName:string[20];
 begin
  clrscr;
  write('Destination: ');readln(DestName);
  DestName:=DestName+'.dat';
  assign(Handle,DateiName);
  assign(Handle2,DestName);
  reset(Handle);
  rewrite(Handle2);
  while not(eof(Handle)) do
   begin
    read(Handle,Satz);
    if Satz.Gesch then write(Handle2,Satz);
   end;
  close(Handle);
  close(Handle2);
 end;
procedure Change(DateiName:string);
 var check:string[20];
 begin
  clrscr;
  write('Zu Ñndernder/lîschender Name: ');readln(check);
  assign(Handle,DateiName);
  assign(Handle2,'rag');
  reset(Handle);
  rewrite(Handle2);
  while not(eof(Handle)) do
   begin
    read(Handle,Satz);
    if Satz.Name<>check then write(Handle2,Satz)
                        else begin
                         if Wahl3='A' then
                          begin
                           Schablon(filepos(Handle));
                           gotoxy(20,3);writeln(Satz.Name);
                           gotoxy(20,4);readln(Satz.Alter);
                           gotoxy(20,5);Wahl2:=upcase(readkey);
                           if Wahl2='W' then Satz.Gesch:=true
                                        else Satz.Gesch:=false;
                           write(Handle2,Satz);
                          end;
                        end;
   end;
  close(Handle);
  close(Handle2);
  erase(Handle);
  rename(Handle2,DateiName);
 end;
procedure Show(DateiName:string);
 begin
  clrscr;
  writeln('Name                Alter     Geschlecht');
  writeln('----------------------------------------');
  assign(Handle,DateiName);
  reset(Handle);
  while not(eof(Handle)) do
   begin
    read(Handle,Satz);
    with Satz do
     begin
      writeln(Name);
      gotoxy(21,filepos(Handle)+2);
      writeln(Alter);
      gotoxy(30,filepos(Handle)+2);
      if Gesch then writeln('Weiblich')
               else writeln('MÑnnlich');
     end;
   end;
  close(Handle);
  readln;
 end;
procedure Sort(DateiName:string);
var comp:array[1..100] of str;
 begin
  assign(Handle,DateiName);
  assign(Handle2,'rag');
  reset(Handle);
  rewrite(Handle2);
  anz:=filesize(Handle);
  for n:=1 to anz do read(Handle,comp[n]);
  for n:=1 to anz-1 do
   begin
    if comp[n].Alter<comp[n+1].Alter then
     begin
      swap:=comp[n].Alter;secfile:=comp[n].Name;found:=comp[n].Gesch;
      comp[n].Alter:=comp[n+1].Alter;comp[n].Name:=comp[n+1].Name;comp[n].Gesch:=comp[n+1].Gesch;
      comp[n+1].Alter:=swap;comp[n+1].Name:=secfile;comp[n+1].Gesch:=found;
      n:=n-1;if n>0 then n:=n-1;
     end;
   end;
  for n:=1 to anz do write(Handle2,comp[n]);
  close(Handle);
  close(Handle2);
  erase(Handle);
  rename(Handle2,DateiName);
 end;
procedure Einf(DateiName:string);
 begin
  assign(Handle,DateiName);
  reset(Handle);
  seek(Handle,filesize(Handle));
  clrscr;
  write('Anzahl der Neuen: ');readln(anz);
  for n:=1 to anz do
   begin
    Schablon(n);
    gotoxy(20,3);readln(Satz.Name);
    gotoxy(20,4);readln(Satz.Alter);
    gotoxy(20,5);Wahl:=upcase(readkey);
    if Wahl='W' then Satz.Gesch:=true
                else Satz.Gesch:=false;
    write(Handle,Satz);
   end;
  close(Handle);
 end;
begin
ende:=false;
repeat
 clrscr;
 writeln(' N = Neue Datei erstellen');
 writeln(' A = Namen Ñndern');
 writeln(' L = Namen lîschen');
 writeln(' S = Datei sortieren');
 writeln(' Z = Datei zeigen');
 writeln(' I = Namen einfÅgen');
 writeln(' W = Weibliche Teilnehmer');
 writeln(' E = Ende');
 write('Ihre Wahl: ');Wahl3:=upcase(readkey);
 writeln(Wahl3);
 if Wahl3='E' then ende:=true
              else begin
               write('Dateiname der zu bearbeitenden Datei: ');readln(filename);
               filename:=filename+'.dat';
               case Wahl3 of
                'N':Edit(filename);
                'L':Change(filename);
                'A':Change(filename);
                'S':Sort(filename);
                'Z':Show(filename);
                'W':SmartCop(filename);
                'I':Einf(filename);
                end;
              end;
until ende;
end.