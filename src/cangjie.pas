program Cangjie;

procedure GiveCangJieCode(hanzi:string;var cangjie:string);
 var cangfile:text;
     strzwi:string;
 begin
  assign(cangfile,'g:\langues\cangjie.tit');
  reset(cangfile);
  cangjie:='';
  while (not(eof(cangfile)) and (cangjie='')) do begin
   readln(cangfile,strzwi);
   if hanzi=copy(strzwi,length(strzwi)-1,2) then
    cangjie:=copy(strzwi,1,length(strzwi)-3);
  end;
  close(cangfile);
 end;

procedure SplitLine(line:String;var zuo,you:String);
 var m:integer;
 begin
  m:=0;
  while ((copy(line,m+1,1)<>chr(9)) and (m<length(line))) do m:=m+1;
  zuo:=copy(line,1,m);
  you:=copy(line,m+2,length(line)-m-1);
 end;

var biao,pinyin:text;
    hanzwi,hanline,cangcode,py,pycode,linezwi:string;
    k,l,m:integer;

begin
 assign(pinyin,'g:\langues\pyb5.tit');
 assign(biao,'g:\langues\cangbiao.b5');
 reset(pinyin);
 rewrite(biao);
 py:='';
 hanline:='';
 while not(eof(pinyin)) do begin
  while ((hanline='') and not(eof(pinyin))) do begin
   readln(pinyin,linezwi);
   SplitLine(linezwi,pycode,hanline);
   for k:=1 to length(pycode) do pycode[k]:=upcase(pycode[k]);
  end;
  if hanline<>'' then begin
   if (pycode<>py) then begin
    m:=length(py)-1;
    l:=length(pycode)-1;
    if copy(pycode,1,l)<>copy(py,1,m) then writeln(biao,'');
    writeln(biao,'**'+pycode+'**');
    py:=pycode;
    writeln(py);
   end;
   hanzwi:=copy(hanline,1,2);
   delete(hanline,1,2);
   GiveCangJieCode(hanzwi,cangcode);
   if cangcode<>'' then begin
    writeln(biao,hanzwi,' '+cangcode);
   end;
  end;
 end;
 close(pinyin);
 close(biao);
end.
