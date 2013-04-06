unit Utime;

interface

uses
  Windows, SysUtils;

type
  PFileTime = ^TFileTime;
  PCardinal = ^Cardinal;

function UnixToDateTime(uT: Cardinal): TDateTime;
function DateTimeToUnix(dT: TDateTime): Cardinal;
function UnixToSystemDateTime(ut: Cardinal): TDateTime;
function SystemDateTimeToUnix(dt: TDateTime): Cardinal;
function DateTimeToUnixSecZ(Date: TDateTime; Time: TDateTime): Cardinal;
function UnixToDelphiStr(Car: Cardinal; Low: integer): string;
function GetToday(CurTm: Cardinal): Cardinal;  //��������� �������: �������, 0 �����, 0 �����
function SecondCountToStr(count: Single): string;
procedure AlignTime(Hour: Boolean; var ut: Cardinal);
function MergeUnixDateAndTime(SrcDate, SrcTime: Cardinal): Cardinal;
function TimeValue(Fmt: string; Val: Cardinal): string;

implementation

procedure UnixToSystemTime(pInt:pCardinal; pST:PSystemTime);   stdcall; external 'Rtdbcon.dll';
procedure UnixToLocalTime(pInt:pCardinal; pST:PSystemTime);    stdcall; external 'Rtdbcon.dll';
procedure LocalTimeToUnix(pST :PSystemTime; pInt: pCardinal);  stdcall; external 'Rtdbcon.dll';
function  SystemTimeToUnixTime(pST :PSystemTime): Cardinal;    stdcall; external 'Rtdbcon.dll';
function  LocalTimeToUnixTime(pST: PSystemTime): Cardinal;     stdcall; external 'Rtdbcon.dll';

function UnixToDateTime(uT: Cardinal): TDateTime;
var
  SysTime : TSystemTime;
begin
  UnixToLocalTime(@uT, @SysTime);
  Result:=SystemTimeToDateTime(SysTime);
end;

function UnixToSystemDateTime(ut: Cardinal): TDateTime;
var
  SysTime : TSystemTime;
begin
  UnixToSystemTime(@uT, @SysTime);
  Result:=SystemTimeToDateTime(SysTime);
end;

function SystemDateTimeToUnix(dt: TDateTime): Cardinal;
var
  SysTime: TSystemTime;
begin
  DateTimeToSystemTime(dt, SysTime);
  Result:=SystemTimeToUnixTime(@SysTime);
end;

function DateTimeToUnix(dT: TDateTime): Cardinal;
var
  SysTime : TSystemTime;
begin
  DateTimeToSystemTime(dT,SysTime);
  LocalTimeToUnix(@SysTime, @Result);
end;

function DateTimeToUnixSecZ(Date: TDateTime; Time: TDateTime): Cardinal;
var
  STime:  TSystemTime;
  Hour, Min, Sec, MSec, Year, Month, Day:  Word;
begin
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Time, Hour, Min, Sec, MSec);
  STime.wYear:= Year;
  STime.wMonth:=Month;
  STime.wDay:=Day;
  STime.wHour:=Hour;
  STime.wMinute:=Min;
  STime.wSecond:=0; //�������� �������
  STime.wMilliseconds:=0;
  Result:=LocalTimeToUnixTime( @STime );
end;

function UnixToDelphiStr(Car: Cardinal; Low: integer): string;
var
  DTime: TDateTime;
begin
  DTime:=UnixToDateTime(Car);
  case Low of
     0: Result:=FormatDateTime('h', DTime);                    // ����
     1: Result:=FormatDateTime('h:nn', DTime);                 // ����,������
     2: Result:=FormatDateTime('dd/mm  h:nn', DTime);          // ����,����,������
     3: Result:=FormatDateTime('dd/mm  h', DTime);             // ����,����
     4: Result:=FormatDateTime('dd/mm/yyyy', DTime);           // ����, �����, ���
     5: Result:=FormatDateTime('dd/mm h:nn:ss', DTime);        // ����,����,������, �������
    10: Result:=FormatDateTime('dd/mm/yyyy hh:nn:ss', DTime);  // ������ ������
  else
        Result:='';
  end;
end;

function GetToday(CurTm: Cardinal): Cardinal;
var
  st: TSystemTime;
begin
  // ��������� ������ ��������� �����
  if CurTm=0 then
    GetLocalTime(st)
  else
    UnixToLocalTime(@CurTM, @st);

  st.wHour:=0;
  st.wMinute:=0;
  st.wSecond:=0;
  st.wMilliseconds:=0;
  Result:=LocalTimeToUnixTime(@st);
end;

function SecondCountToStr(count: Single): string;
var
  minus: Boolean;
begin
  minus:=Count<0;
  count:=Int(Abs(count));

  Result:=Format('%.2d', [Trunc(count-Int(count/60)*60)]);
  count:=Int(count/60);
  Result:=Format('%.2d', [Trunc(count-Int(count/60)*60)])+':'+Result;
  count:=Int(count/60);
  if count>0 then
    Result:=IntToStr(Trunc(count))+':'+Result;
  if minus then
    Result:='-'+Result;
end;

procedure AlignTime(Hour: Boolean; var ut: Cardinal);
begin
  if Hour then
    ut:=(ut div 3600)*3600
  else
    ut:=(ut div 1800)*1800;
end;

function MergeUnixDateandTime(SrcDate, SrcTime: Cardinal): Cardinal;
var
  SD, ST, ResSTime:  TSystemTime;
begin
  UnixToLocalTime(@SrcDate, @SD);
  UnixToLocalTime(@SrcTime, @ST);
  ResSTime.wYear:=SD.wYear;
  ResSTime.wMonth:=SD.wMonth;
  ResSTime.wDayOfWeek:=SD.wDayOfWeek;
  ResSTime.wDay:=SD.wDay;
  ResSTime.wHour:=ST.wHour;
  ResSTime.wMinute:=ST.wMinute;
  ResSTime.wSecond:=ST.wSecond;
  ResSTime.wMilliseconds:=0;
  Result:=LocalTimeToUnixTime(@ResSTime);
end;

function TimeValue(Fmt: string; Val: Cardinal): string;
var
  i: Integer;
  c: Char;
begin
  for i:=1 to Length(fmt) do begin
    case fmt[i] of
      '�': c:='d';
      '�': c:='m';
      '�': c:='y';
      '�': c:='h';
      '�': c:='n';
      '�': c:='s';
    else
          c:=fmt[i];
    end;
    fmt[i]:=c;
  end;

  Result:=FormatDateTime(Fmt, UnixToDateTime(Round(Val)));
end;

end.
