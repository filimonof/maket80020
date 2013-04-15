unit uUtils;

interface

uses SysUtils, Windows;

function IntToStrLen(i,len: Integer): string;
function GetComputerName: string;
function GetUserName: string;
function ParseStr(s: string): string;
function dayWinterTOSumer(y: Integer): TDateTime;
function daySumerTOWinter(y: Integer): TDateTime;
function DayLightSavingTime(dt: TDateTime): Integer;
function IncludeArray(ar: string; s: string; ar_separator: string=';'): Boolean;
function IsFileMasking(FileName, Mask: string) : Boolean;

implementation

uses DateUtils, Masks;

function IntToStrLen(i,len: Integer): string;
begin
  Result:=IntToStr(i);
  if len > 0 then
  while (Length(Result) < len) do
    Result:='0'+Result;
end;

function GetComputerName: string;
var
  buffer: array[0..255] of Char;
  Size: Cardinal;
begin
  Size := 256;
  try
    if Windows.GetComputerName(@buffer, Size) then
      Result := StrPas(buffer)
    else
      Result := '';
  except    
      Result := '';
  end;
end;

function GetUserName: string;
var
  buffer: array[0..255] of Char;
  Size: Cardinal;
begin
  Size := 256;
  try
    if Windows.GetUserName(@buffer, Size) then
      Result := StrPas(buffer)
    else
      Result := '';
   except
      Result := '';
   end;
end;

function ParseStr(s: string): string;
begin
  Result:=s;
  Result:=StringReplace(Result,'<%date%>',FormatDateTime('dd.mm.yyyy',Date()),[rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result,'<%time%>',FormatDateTime('hh:nn',Now()),[rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result,'<%user%>',GetUserName,[rfReplaceAll, rfIgnoreCase]);
  Result:=StringReplace(Result,'<%computer%>',GetComputerName,[rfReplaceAll, rfIgnoreCase]);
end;


function dayWinterTOSumer(y: Integer): TDateTime;
begin                     
  Result := EncodeDate(y, 3, DaysInAMonth(y, 3));
  while DayOfWeek(Result)<>1 do
    Result := Result - 1;
end;

function daySumerTOWinter(y: Integer): TDateTime;
begin
  Result := EncodeDate(y, 10, DaysInAMonth(y, 10));
  while DayOfWeek(Result)<>1 do
    Result := Result - 1;
end;

function DayLightSavingTime(dt: TDateTime): Integer;
begin
  Result := 1; //всегда летнее
{
  if (dt = daySumerTOWinter(YearOf(dt))) or (dt = dayWinterTOSumer(YearOf(dt))) then
    Result := 2    //сутки с зимнего на летнее и обратно
  else if (dayWinterTOSumer(YearOf(dt)) < dt) and (dt < daySumerTOWinter(YearOf(dt)))  then
    Result := 1    //летнее время
  else
    Result := 0;   //зимнее
}
end;

function IncludeArray(ar: string; s: string; ar_separator: string=';'): Boolean;
var
  ar_1: string;
  i: Integer;
begin
  Result := false;
  if Length(ar)<1 then
    exit;
  if ar[Length(ar)] <> ar_separator then
    ar:=ar+ar_separator;
  ar_1 := '';
  for i:=1 to Length(ar) do
    if ar[i]=ar_separator then
    begin
      if (Length(ar_1)>0) and (Pos(ar_1,s)>0) then
        Result := true;
      ar_1 :='';
    end
    else
    begin
      ar_1 := ar_1 + ar[i];
    end
end;

function IsFileMasking(FileName, Mask: string) : Boolean;
begin
  if (Mask = '') or (Mask = '*.*') then
    Mask:='*';
  with TMask.Create(Mask) do
  try
    Result := Matches(FileName);
  finally
    Free;
  end;
end;





end.
