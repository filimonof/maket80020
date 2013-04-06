unit uAdoUtils;

interface

uses ADODB, Db, ADOInt, Dialogs, SysUtils, Controls, windows, ComObj, Variants, uVar, DateUtils;

function DateToAccssSQLStr(ADate: TDateTime): string;
procedure AdoCancel(DS: TCustomADODataSet);
procedure AdoRequery(DS: TCustomADODataSet);
procedure AdoReopen(DS: TCustomADODataSet; dis: Boolean=true);
procedure AdoResync(DS: TCustomADODataSet);
procedure AdoPostCancelClose(DS: TCustomADODataSet);
function SaveInformation(DS: TCustomADODataSet; AWhere: string): boolean;
function RecordPresent(DS: TCustomADODataSet): boolean;
function ExecQuery(ADC: TADOConnection; AQuery: string; Params: array of variant): integer;
function ExecQuerySimple(ADC: TADOConnection; AQuery: string): integer;
function SelectQuery(ADC: TADOConnection; AQuery: string; Params: array of variant): TAdoQuery;
function SelectQuerySimple(ADC: TADOConnection; AQuery: string): TAdoQuery;

function GetSQLDateTimeFormat(ADC: TADOConnection): string;
function DateTimeToSQLDateTimeString(format: string; dtDate: TDateTime; bOnlyDate: Boolean = True): string;

implementation

function DateToAccssSQLStr(ADate: TDateTime): string;
begin
  Result := FormatDateTime('"#"mm"/"dd"/"yy"#"',ADate);
end;

function SelectQuery(ADC: TADOConnection; AQuery: string; Params: array of variant): TAdoQuery;
var
  i: integer;
begin
  Result := TAdoQuery.Create(nil);
  try
    Result.Connection := ADC;
    Result.SQL.Text := AQuery;
    Result.Prepared := True;
    for i := 0 to Result.Parameters.Count - 1 do begin
      Result.Parameters[i].Value := Params[i];
    end;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

function SelectQuerySimple(ADC: TADOConnection; AQuery: string): TAdoQuery;
begin
  Result := TAdoQuery.Create(nil);
  try
    Result.Connection := ADC;
    Result.SQL.Text := AQuery;
    Result.Prepared := True;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

function ExecQuery(ADC: TADOConnection; AQuery: string; Params: array of variant): integer;
var
  Query: TADOQuery;
  i: integer;
begin
  Query := TAdoQuery.Create(nil);
  try
    Query.Connection := ADC;
    Query.SQL.Text := AQuery;
    Query.Prepared := True;
    for i := 0 to Query.Parameters.Count - 1 do begin
      Query.Parameters[i].Value := Params[i];
    end;
    Result := Query.ExecSQL;
  finally
    Query.Free
  end;

end;

function ExecQuerySimple(ADC: TADOConnection; AQuery: string): integer;
var
  Query: TADOQuery;
begin
  Query := TAdoQuery.Create(nil);
  try
    Query.Connection := ADC;
    Query.SQL.Text := AQuery;
    Query.Prepared := True;
    Result := Query.ExecSQL;
  finally
    Query.Free
  end;

end;


function SaveInformation(DS: TCustomADODataSet; AWhere: string): boolean;
var
  b1, b2: boolean;
begin
  Result := True;
  if not (DS.State in [dsEdit, dsInsert]) then Exit;
  DS.UpdateRecord;
  b1 := (DS.State in [dsEdit]) and DS.Modified;
  b2 := DS.State in [dsInsert];
  if b1 or b2 then
    Result := (MessageDlg(Format('Сохранить информацию о %s в базе?', [AWhere]), mtConfirmation, [mbYes, mbNo], 0) = mrYes);
    if Result and (b1 or b2) then begin
      DS.Post;
      DS.Edit;
    end;
end;

procedure AdoCancel(DS: TCustomADODataSet);
begin
  if DS.State = dsInsert then begin
    DS.CursorPosChanged;
    DS.UpdateCursorPos;
//    DS.Recordset.CancelUpdate;
    DS.Cancel;
  end else
  if DS.State = dsEdit then begin
    DS.CursorPosChanged;
    DS.UpdateCursorPos;
    DS.Recordset.CancelUpdate;
    DS.Cancel;
  end
end;

procedure ResyncCurrent(DS: TCustomADODataSet);
begin
	DS.UpdateCursorPos;
//  DS.RecordSet.Resync(adAffectCurrent, adResyncAll);
 	DS.Resync([]);
end;

procedure AdoRequery(DS: TCustomADODataSet);
var
  b: TBookmark;
  N: integer;
begin
  with DS do begin
    DisableControls;
    b := GetBookmark;
    N := RecNo;
    try
      Requery;
      try
        GotoBookmark(b);
      except
        if N >= RecordCount then
          Last
        else
          RecNo := N;
      end;
    finally
      FreeBookmark(b);
      EnableControls;
    end
  end;
end;

procedure AdoReopen(DS: TCustomADODataSet; dis: Boolean=true);
var
  b: TBookmark;
begin
  with DS do begin
    if not dis then DisableControls;
    b := GetBookmark;
    try
      if DS.Active then DS.Close;
      DS.Open;
      try
        GotoBookmark(b);
      except end;
    finally
      FreeBookmark(b);
      if not dis then EnableControls;
    end
  end;
end;

procedure AdoResync(DS: TCustomADODataSet);
begin
//обновить с сервера текущую запись, работает только если установлен первичный ключ в таблице на сервере!
  DS.UpdateCursorPos;
  DS.RecordSet.Resync(adAffectCurrent, adResyncAllValues);
  DS.Resync([rmCenter]);
end;

function RecordPresent(DS: TCustomADODataSet): boolean;
begin
  Result := not DS.FieldByName('ID').IsNull;
end;

procedure AdoPostCancelClose(DS: TCustomADODataSet);
begin
  if DS.Active then
  begin
    if DS.State in [dsEdit, dsInsert] then
    try
      try
        DS.Post;
      except
        DS.Cancel;
      end;
    finally
      DS.Close;
    end;
  end;
end;

function GetSQLDateTimeFormat(ADC: TADOConnection): string;
var
  aq: TADOQuery;
begin
  aq:=SelectQuerySimple(ADC,' sp_helplanguage @@LANGUAGE ');
  try
    if aq.RecordCount>0 then
      Result := aq.FieldByName('dateformat').AsString;
  finally
    aq.Free;
  end;
end;

function DateTimeToSQLDateTimeString(format: string; dtDate: TDateTime;
  bOnlyDate: Boolean = True): string;
var
  y, m, d, h, mm, s, ms: Word;
begin
  DecodeDate(dtDate, y, m, d);
  DecodeTime(dtDate, h, mm, s, ms);
  if format = 'dmy' then
    Result := IntToStr(d) + '-' + IntToStr(m) + '-' + IntToStr(y)
  else if format = 'ymd' then
    Result := IntToStr(y) + '-' + IntToStr(m) + '-' + IntToStr(d)
  else if format = 'ydm' then
    Result := IntToStr(y) + '-' + IntToStr(d) + '-' + IntToStr(m)
  else if format = 'myd' then
    Result := IntToStr(m) + '-' + IntToStr(y) + '-' + IntToStr(d)
  else if format = 'dym' then
    Result := IntToStr(d) + '-' + IntToStr(y) + '-' + IntToStr(m)
  else  //mdy  US
    Result := IntToStr(m) + '-' + IntToStr(d) + '-' + IntToStr(y); ;
  if not bOnlyDate then
    Result := Result + ' ' + IntToStr(h) + ':' + IntToStr(mm) + ':' + IntToStr(s);
end;




end.
