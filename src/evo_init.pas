procedure GraphInit;
var grDriver,grMode:Integer;
begin
 grDriver:=Detect;
 InitGraph(grDriver, grMode,'c:\progra~1\italiano\');
 SetRGBPalette(1,255,255,255);
 SetRGBPalette(3,255,100,100);
 for io:=1 to 32000 do begin;nosound;nosound;end;
end;
