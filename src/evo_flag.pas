const GoFlag=128;
      BusyFlag=128;
      PaarFlag=1;

      SchwangerFlag=2;
      MannFlag=1;

var Status,Desire,Attribut:array[1..MaxAnzahl] of byte;

function TestMann(a:integer):Boolean;
begin
 if (Attribut[a] and MannFlag)=0 then TestMann:=False
                                 else TestMann:=True;
end;

function TestSchwanger(a:integer):Boolean;
begin
 if (Attribut[a] and SchwangerFlag)=0 then TestSchwanger:=False
                                      else TestSchwanger:=True;
end;

function TestBusy(a:integer):Boolean;
begin
 if (Desire[a] and BusyFlag)=0 then TestBusy:=False
                               else TestBusy:=True;
end;

function TestGo(a:integer):Boolean;
begin
 if (Status[a] and GoFlag)=0 then TestGo:=False
                             else TestGo:=True;
end;

function TestPaar(a:integer):Boolean;
begin
 if (Status[a] and PaarFlag)=0 then TestPaar:=False
                               else TestPaar:=True;
end;

function TestPaarDes(a:integer):Boolean;
begin
 if (Desire[a] and PaarFlag)=0 then TestPaarDes:=False
                               else TestPaarDes:=True;
end;

procedure SetPaarDes(a:integer);
begin
 Desire[a]:=Desire[a] or PaarFlag;
end;

procedure SetPaar(a:integer);
begin
 Status[a]:=Status[a] or PaarFlag;
end;

procedure SetSchwanger(a:integer);
begin
 Attribut[a]:=Attribut[a] or SchwangerFlag;
end;

procedure SetMann(a:integer);
begin
 Attribut[a]:=Attribut[a] or MannFlag;
end;

procedure SetGo(a:integer);
begin
 Status[a]:=Status[a] or GoFlag;
end;

procedure SetBusy(a:integer);
begin
 Desire[a]:=Desire[a] or BusyFlag;
end;

procedure ClrPaarDes(a:integer);
begin
 Desire[a]:=Desire[a] and (255-PaarFlag);
end;

procedure ClrPaar(a:integer);
begin
 Status[a]:=Status[a] and (255-PaarFlag);
end;

procedure ClrSchwanger(a:integer);
begin
 Attribut[a]:=Attribut[a] and (255-SchwangerFlag);
end;

procedure ClrMann(a:integer);
begin
 Attribut[a]:=Attribut[a] and (255-MannFlag);
end;

procedure ClrGo(a:integer);
begin
 Status[a]:=Status[a] and (255-GoFlag);
end;

procedure ClrBusy(a:integer);
begin
 Desire[a]:=Desire[a] and (255-BusyFlag);
end;