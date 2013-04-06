unit uLog;

interface

uses SysUtils, Classes;

procedure Log_Error(s: string);
procedure Log_Info(s: string);

var
  sErrorLog: string = 'm80020.log';

implementation

procedure PutLog(s: string; tp: string);
var
  F: TFileStream;
  PStr: PChar;
  LengthLogS: integer;
begin

  s := DateTimeToStr(Now()) + ' ' + tp + ' ' + s + #13#10;

  if not FileExists(sErrorLog) then
    s := '  Log-файл для программы "Макет 80020"' + #10#13#10#13 + s;

  LengthLogS := Length(s);
  PStr := StrAlloc(LengthLogS);
  StrPCopy(PStr, s);

  if FileExists(sErrorLog) then
    F := TFileStream.Create(sErrorLog, fmOpenWrite)
  else
    F := TFileStream.Create(sErrorLog, fmCreate);
  try
  F.Position := F.Size;
  F.Write(PStr^, LengthLogS);
  StrDispose(PStr);
  finally
    F.Free;
  end;
end;

procedure Log_Error(s: string);
begin
  PutLog(s,'ERR');
end;

procedure Log_Info(s: string);
begin
  PutLog(s,'INF');
end;

initialization
  sErrorLog := ExtractFilePath(ParamStr(0)) + sErrorLog;
end.
