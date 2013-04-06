{
******************************************************************************
    Модуль доступа к данным СК-2007
    Версия = 3.00
    Мордовское РДУ
    fvv@rdurm.odusv.so-ups.ru    
******************************************************************************
    Пример использования:
uses
  ck7GetData;
var
  ck: Tck7Data;
  res: TOutCKDataArray;
begin
  ck := Tck7Data.Create('Test');
  ck.SQLServers.Add(Tck7SQLServer.Create('oik07-1-mrdv','login','password'));
  ck.SQLServers.Add(Tck7SQLServer.Create('oik07-2-mrdv','login','password'));
  ck.SQLServers.Add(Tck7SQLServer.Create('oik07-3-mrdv'));  // windows domain authentification   
  try
    if ck.OpenConnection() then
    begin
      res := ck.GetArrayValueTI_Sync(444,ckPV,ckTI48,Date());
      if res <> nil then
        for i:= 0 to Length(res)-1 do
          WriteLn( DtToStr(res[i].TStamp) + ValueToStr(res[i].Value) + PriznToHexStr(res[i].Prizn) );
    end;
  finally
    ck.Free;
  end;
end;
******************************************************************************
}

unit ck7GetData;

interface

uses  DB, ADODB, SysUtils, Classes, Math;

type
  TLengthArrayTI = (       // набор данных
    ckTI24 = 24,           // 24 точки
    ckTI48 = 48            // 48 точек
  );

  TCategoryTI = (          // num   список категорий
    ckTI    =    73,       //  1    I 73 Телеизмерения	ТИ
    ckTS    =    83,       //  2    S 83 Телесигналы	ТС
    ckIIS   =    74,       //  3    J 74 Интегралы и средние	ИС
    ckSV    =    87,       //  4    W 87 СВ-1 (мгновенная,СДВ)	СВ
    ckPL    =    80,       //  5    P 80 Планы	ПЛ
    ckEI    =    85,       //  6    U 85 Ежедневная информация	ЕИ
    ckSP    =    67,       //  7    C 67 Специальные параметры вещественные	СП
    ckPV    =    72,       //  8    H 72 СВ-2 (усредненная)	ПВ
    ckFTI   =    76,       //  9    L 76 Фильтрованные телеизмерения	ФТИ
    ckMSK   =    77,       //  10   M 77 Специальные параметры целочисленные	МСК
    ckTIS   =    65,       //  11   A 65 "Телеизмерения ""сырые"""	ТИС
    ckTSS   =    66,       //  12   B 66 "Телесигналы ""сырые"""	ТСС
    ckPCHAS =    202,      //  13   К 202 Универсальные хранилища 30 мин	ПЧАС
    ckCHAS  =    203,      //  14   Л 203 Универсальные хранилища 1 час	ЧАС
    ckSYT   =    207       //  15   П 207 Универсальные хранилища 1 день	СУТ
  );    
{
почему то не используются (нет флага InRTDB):
O ОТИ Оцененные ТИ 0
Б МИН Универсальные хранилища 1 мин 0
Г ПМИН Универсальные хранилища 5 мин 0
З ДМИН Универсальные хранилища 10 мин 0
И ЧЧАС Универсальные хранилища 15 мин 0
У МЕС Универсальные хранилища 1 месяц 0
Ъ СД Статич.данные для локальных дорасчетов (const) 0
Д ЛД Локальный дорасчет на формах 0
D Д Временная локальная переменная дорасчета 0
R Т Период (временной интервал из таблицы Period) 0
T ЕИТ Текстовая ежедневная информация 0
}
  TTI = record              // телеизмерение
    id:  Integer;
    cat: TCategoryTI;
  end;
  TTIArray = array of TTI;


  TOutCKData = record       // результат запроса
    TStamp: TDateTime;      // дата время
    Value:  Double;          // значение
    Prizn:  Integer;        // признак достоверности
  end;
  TOutCKDataArray = array of TOutCKData;
  TOutCKDataArrayManyTI = array of TOutCKDataArray;

  TStringArray = array of string;
  TDoubleArray = array of Double;

  Tck7SQLServer = class     //сервер SQL
    Server: string;
    WinAuth: Boolean;
    Login: string;
    Pas: string;
  public
    constructor Create(sServer: string); overload;
    constructor Create(Sserver: string; sLogin: string; sPas: string); overload;
  end;

  Tck7SQLServerList = class(TList)   // список серверов  SQL
  private
    function Get(Index: Integer): Tck7SQLServer;
    procedure Put(Index: Integer; const Value: Tck7SQLServer);
  public
    property Items[Index: Integer]: Tck7SQLServer read Get write Put; default;
    procedure Clear; override;
  end;     

  //получение данных
  TCK7Data = class
  private
    sCaption:       string;                    // заголовок задачи
    ADOCon:         TADOConnection;            // соединение с SQL
    sConnected:     Boolean;                   // есть ли связь с СК
    iTimeOut:       Integer;                   // сек на выполнение команды
    sMainSQLServer: string;                    // имя главного SQL сервера OIK
    listSQLServers: Tck7SQLServerList;         // список SQL Server-ов СК-2007
  public
    property      Caption: string read sCaption write sCaption;
    property      Connected: Boolean read sConnected;
    property      TimeOut: Integer read iTimeOut write iTimeOut;
    property      MainSQLServer: string read sMainSQLServer;
    property      SQLServers: Tck7SQLServerList read listSQLServers write listSQLServers;

    constructor   Create(sCapt: string = 'CK2007');
    destructor    Free();
    function      OpenConnection(): Boolean;
    procedure     CloseConnection();

    function      GetArrayValueTI_Sync(ti: Integer; cat: TCategoryTI; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArray; overload;
    function      GetArrayValueTI_Sync(ti: Integer; cat: TCategoryTI; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArray; overload;
    function      GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArrayManyTI; overload;
    function      GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArrayManyTI; overload;
  end;

  function DtToStr(dt: TDateTime; frm: string = 'dd.mm.yyyy hh:nn:ss'): string;
  function PriznToHexStr(prz: Integer): string;
  function PriznToStr(prz: Integer): string;
  function PriznNoData(prz: Integer): Boolean;
  function ValueToStr(val: Double; frm: string = '%f'): string;
  function NumToCat(i: Byte): TCategoryTI;
  function CatToNum(cat: TCategoryTI): Byte;

  function GetMaxAndHour(arr: TOutCKDataArray): string; overload;
  function GetMaxAndHour(arr: TOutCKDataArrayManyTI): TStringArray; overload;
  function GetMinAndHour(arr: TOutCKDataArray): string; overload;
  function GetMinAndHour(arr: TOutCKDataArrayManyTI): TStringArray; overload;
  function GetAvg(arr: TOutCKDataArray): Double; overload;
  function GetAvg(arr: TOutCKDataArrayManyTI): TDoubleArray; overload;
  function GetSum(arr: TOutCKDataArray): Double; overload;
  function GetSum(arr: TOutCKDataArrayManyTI): TDoubleArray; overload;
  procedure RoundArray(var arr: TOutCKDataArray; countsign: Byte); overload;
  procedure RoundArray(var arr: TOutCKDataArrayManyTI; countsign: Byte); overload;

implementation

constructor TCK7Data.Create(sCapt: string = 'CK2007');
begin
  iTimeOut := 30;
  sConnected := false;
  sCaption := sCapt;
  sMainSQLServer:= '';
  listSQLServers := Tck7SQLServerList.Create();
  ADOCon  := TADOConnection.Create(nil);
end;

destructor TCK7Data.Free();
begin
  SQLServers.Free;
  ADOCon.Free;
end;

function TCK7Data.OpenConnection(): Boolean;
var
  i, mainI: Integer;
  ADOConTest: TADOConnection;
  Query: TAdoQuery;
begin
  //определение основного сервера ОИК

  sConnected := false;

  if self.SQLServers.Count < 1 then
  begin
    Result := sConnected;
    Exit;
  end;

  sMainSQLServer := '';
  for i := 0 to self.SQLServers.Count - 1 do
  begin
    ADOConTest := TADOConnection.Create(nil);
    try
      //формирование строки подключения к серверу
      ADOConTest.ConnectionString := Format('Provider=SQLOLEDB.1;Data Source=%s;Initial Catalog=%s;', [self.SQLServers[i].Server, 'OIK']);
      if self.SQLServers[i].WinAuth then
        ADOConTest.ConnectionString := ADOConTest.ConnectionString + 'Integrated Security=SSPI;'
      else
        ADOConTest.ConnectionString := ADOConTest.ConnectionString + Format('User ID=%s;Password=%s;', [self.SQLServers[i].Login, self.SQLServers[i].Pas]);
      ADOConTest.LoginPrompt := false;
      ADOConTest.ConnectionTimeout := self.TimeOut;      

      //подключение к серверу
      try
        ADOConTest.Open;
      except
        sConnected := false;
      end;

      //зарпос на главную базу
      if ADOConTest.Connected then
      begin
        Query := TAdoQuery.Create(nil);
        try
          Query.Connection := ADOConTest;
          Query.SQL.Text := 'exec :ckSrv = [dbo].fn_GetMainOIKServerName';
          Query.Prepared := True;
          Query.CommandTimeout := self.TimeOut;
          try
            Query.ExecSQL;
            sMainSQLServer := Query.Parameters.ParamByName('ckSrv').Value;
          except
            sMainSQLServer := '';
          end;
        finally
          Query.Free
        end;
      end;

    finally
      if ADOConTest.Connected then ADOConTest.Close();
      ADOConTest.Free();
    end;

    //если главный сервер определён то перебирать другие сервера не нужно
    if sMainSQLServer <> '' then Break;

  end;        
  
  if sMainSQLServer = '' then
  begin
    //ниодин из серверов не выдал результата
    sConnected := false;
  end
  else
  begin
    //определить какой из серверов главный
    mainI := 0;
    for i := 0 to self.SQLServers.Count - 1 do
      if self.SQLServers[i].Server = self.MainSQLServer then
        mainI := i;

    //создать подключение на базе ADOCon
    ADOCon.ConnectionString := Format('Provider=SQLOLEDB.1;Data Source=%s;Initial Catalog=%s;', [self.MainSQLServer, 'OIK']);
    if self.SQLServers[mainI].WinAuth then
      ADOCon.ConnectionString := ADOCon.ConnectionString + 'Integrated Security=SSPI;'
    else
      ADOCon.ConnectionString := ADOCon.ConnectionString + Format('User ID=%s;Password=%s;', [self.SQLServers[mainI].Login, self.SQLServers[mainI].Pas]);
    ADOCon.LoginPrompt := false;
    ADOCon.ConnectionTimeout := self.TimeOut;

    //подключение к серверу
    try
      ADOCon.Open;
      sConnected := ADOCon.Connected;
    except
      sConnected := false;
    end;
  end;

  Result := sConnected;

end;

procedure TCK7Data.CloseConnection();
begin
  if ADOCon.Connected then ADOCon.Close;
end;

//______________ Get Data ________________________________________________

function TCK7Data.GetArrayValueTI_Sync(ti: Integer; cat: TCategoryTI; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArray;
begin
  Result := GetArrayValueTI_Sync(ti,cat,lena,date1,date1+1);
end;

function TCK7Data.GetArrayValueTI_Sync(ti: Integer; cat: TCategoryTI; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArray;
var
  step: Integer;
  Query: TADOStoredProc;
  i: Integer;
begin          
  {
    Получение данных за интервал времени с определённым шагом (локальное время)
    exec @i= [OIK].[dbo].StepLt 'H','4581,1015', '20101116 0:00:00',0, '20101116 10:00:00',0,3600,0
    4,6 параметры нудны на момент перехода времени
  }
  Result := nil;

  if lena = ckTI24 then step := 60*60 else step := 60*30;

  if self.Connected then
  begin
    Query := TADOStoredProc.Create(nil);
    try
      Query.Connection := self.ADOCon;
      Query.ProcedureName := 'StepLt';
      Query.Parameters.CreateParameter('@Cat', ftString, pdInput, 2, System.Chr(Byte(cat)));
      Query.Parameters.CreateParameter('@Ids', ftString, pdInput, 300, IntToStr(ti));
      Query.Parameters.CreateParameter('@Start', ftDate, pdInput, 0, date1);
      Query.Parameters.CreateParameter('@StartIsSummer', ftInteger, pdInput, 0, 0);
      Query.Parameters.CreateParameter('@Stop', ftDate, pdInput, 0, date2);
      Query.Parameters.CreateParameter('@StopIsSummer', ftInteger, pdInput, 0, 0);
      Query.Parameters.CreateParameter('@Step', ftInteger, pdInput, 0, step);
      Query.Parameters.CreateParameter('@ShowSystemTime', ftInteger, pdInput, 0, 0);
      Query.Prepared := True;
      Query.CommandTimeout := self.TimeOut;
      try
        Query.Open();

        if Query.RecordCount > 0 then
          SetLength(Result, Query.RecordCount);

        i:=0;
        while (not Query.EOF) do
        begin
          Result[i].TStamp := Query.FieldByName('timeLt').AsDateTime;
          Result[i].Value := Query.FieldByName('value').AsFloat;
          Result[i].Prizn := Query.FieldByName('QC').AsInteger;
          {
          Query.FieldByName('id').AsInteger;
          Query.FieldByName('timeLt').AsDateTime;
          Query.FieldByName('LtType').AsInteger;
          Query.FieldByName('value').AsFloat;
          Query.FieldByName('QC').AsInteger;
          Query.FieldByName('time2Lt').AsDateTime;
          Query.FieldByName('LtType2').AsInteger;
          }
          Query.Next;
          Inc(i);
        end;          

        // убираем полночь следующего дня
        if Length(Result)>1 then
          SetLength(Result,Length(Result)-1);

      except
        Result := nil;
      end;

    finally
      if Query.Active then Query.Close(); 
      Query.Free
    end;
  end;
end;

function TCK7Data.GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArrayManyTI;
begin
  Result := GetArrayValueTI_Sync(ti,lena,date1,date1+1);
end;

function TCK7Data.GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArrayManyTI;
var
  dt:    TDateTime;
  i:     Integer;
begin
  if date1 > date2 then
  begin
    dt := date1;
    date1 := date2;
    date2 := dt;
  end;
  Result := nil;
  if (ti = nil) or (Length(ti)<1) then
    Exit;
  SetLength(Result,Length(ti));
  for i:=0 to Length(ti)-1 do
    Result[i] := GetArrayValueTI_Sync(ti[i].Id, ti[i].Cat, lena, date1, date2);
end;

//________________ TCK7SQLServerList _________________________________________

constructor Tck7SQLServer.Create(sServer: string); 
begin
  Server := sServer;
  WinAuth := true;
end;

constructor Tck7SQLServer.Create(Sserver: string; sLogin: string; sPas: string);
begin
  Server := sServer;
  WinAuth := false;
  Login := sLogin;
  Pas := sPas;
end;

procedure Tck7SQLServerList.Clear();
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Free;
  inherited;
end;

function Tck7SQLServerList.Get(Index: Integer): Tck7SQLServer;
begin
  Result:=Tck7SQLServer(inherited Get(Index));
end;

procedure Tck7SQLServerList.Put(Index: Integer; const Value: Tck7SQLServer);
begin
  inherited Put(Index, Value);
end;

// _________ Output function _________________________________________________


function DtToStr(dt: TDateTime; frm: string = 'dd.mm.yyyy hh:nn:ss'): string;
begin
  Result := FormatDateTime(frm, dt);
end;

function ValueToStr(val: Double; frm: string = '%f'): string;
begin
  Result := Format(frm, [val]);
end;

function PriznToHexStr(prz: Integer): string;
begin
  Result := '0x' + IntToHex(prz, 8);
end;

function PriznToStr(prz: Integer): string;
begin
{
 00 000 001 - недостоверность: дребезг ТС
 00 000 002 - источник: ручной ввод с блокировкой ТМ
 00 000 202 - источник: ручной ввод без блокировки
 00 000 004 - недостоверность: недоверие ТМ
 00 000 008 - недостоверность:  ПНУ
 00 000 010 - источник: расчёт
 00 000 030 - недостоверность: параметры функции
 00 000 040 - источник: внешняя система
 00 000 080 - недостоверность: сбой телеметрии
 00 000 100 - источник: телеметрия
 00 000 200 - недостоверность: необновление
 00 000 400 - недостоверность: сбой расчета
 00 000 800 - недостоверность: по дублю
 00 001 000 - недостоверность: нарушение физ. границ
 00 002 000 - недостоверность: по оценке состояния
 00 008 000 - нет данных
 00 010 000 - нарушение: нижний аварийный
 00 020 000 - нарушение: верхний предупредительный
 00 040 000 - нарушение: нижний предупредительный
 00 080 000 - замена: отчетной информацией
 00 100 000 - замена: дублем
 00 200 000 - нарушение: верхний аварийный
 00 800 000 - недостоверность: скачок
 01 000 000 - замена: принудительная
 04 000 000 - источник: технологическая задача
 08 000 000 - недостоверность: подозрение на скачок
 10 000 000 - источник: данные АСКУЭ
 20 000 000 - источник: обнуление
 40 000 000 - источник: повтор предыдущего значения
}
  if PriznToHexStr(prz) = '0x00000001' then
    Result := 'недостоверность: дребезг ТС'
  else if PriznToHexStr(prz) = '0x00000002' then
    Result := 'источник: ручной ввод с блокировкой ТМ'
  else if PriznToHexStr(prz) = '0x00000202' then
    Result := 'источник: ручной ввод без блокировки'
  else if PriznToHexStr(prz) = '0x00000004' then
    Result := 'недостоверность: недоверие ТМ'
  else if PriznToHexStr(prz) = '0x00000008' then
    Result := 'недостоверность:  ПНУ'
  else if PriznToHexStr(prz) = '0x00000010' then
    Result := 'источник: расчёт'
  else if PriznToHexStr(prz) = '0x00000030' then
    Result := 'недостоверность: параметры функции'
  else if PriznToHexStr(prz) = '0x00000040' then
    Result := 'источник: внешняя система'
  else if PriznToHexStr(prz) = '0x00000080' then
    Result := 'недостоверность: сбой телеметрии'
  else if PriznToHexStr(prz) = '0x00000100' then
    Result := 'источник: телеметрия'
  else if PriznToHexStr(prz) = '0x00000200' then
    Result := 'недостоверность: необновление'
  else if PriznToHexStr(prz) = '0x00000400' then
    Result := 'недостоверность: сбой расчета'
  else if PriznToHexStr(prz) = '0x00000800' then
    Result := 'недостоверность: по дублю'
  else if PriznToHexStr(prz) = '0x00001000' then
    Result := 'недостоверность: нарушение физ. границ'
  else if PriznToHexStr(prz) = '0x00002000' then
    Result := 'недостоверность: по оценке состояния'                 
  else if PriznToHexStr(prz) = '0x00008000' then
    Result := 'нет данных'
  else if PriznToHexStr(prz) = '0x00010000' then
    Result := 'нарушение: нижний аварийный'
  else if PriznToHexStr(prz) = '0x00020000' then
    Result := 'нарушение: верхний предупредительный'
  else if PriznToHexStr(prz) = '0x00040000' then
    Result := 'нарушение: нижний предупредительный'
  else if PriznToHexStr(prz) = '0x00080000' then
    Result := 'замена: отчетной информацией'
  else if PriznToHexStr(prz) = '0x00100000' then
    Result := 'замена: дублем'
  else if PriznToHexStr(prz) = '0x00200000' then
    Result := 'нарушение: верхний аварийный'
  else if PriznToHexStr(prz) = '0x00800000' then
    Result := 'недостоверность: скачок'
  else if PriznToHexStr(prz) = '0x01000000' then
    Result := 'замена: принудительная'
  else if PriznToHexStr(prz) = '0x04000000' then
    Result := 'источник: технологическая задача'
  else if PriznToHexStr(prz) = '0x08000000' then
    Result := 'недостоверность: подозрение на скачок'
  else if PriznToHexStr(prz) = '0x10000000' then
    Result := 'источник: данные АСКУЭ'
  else if PriznToHexStr(prz) = '0x20000000' then
    Result := 'источник: обнуление'
  else if PriznToHexStr(prz) = '0x40000000' then
    Result := 'источник: повтор предыдущего значения'     
  else
    Result := PriznToHexStr(prz);
end;

function PriznNoData(prz: Integer): Boolean;
begin
  Result := PriznToHexStr(prz) = '0x00008000';
end;

function NumToCat(i: Byte): TCategoryTI;
begin
  case i of
     1: Result := ckTI;
     2: Result := ckTS;
     3: Result := ckIIS;
     4: Result := ckSV;
     5: Result := ckPL;
     6: Result := ckEI;
     7: Result := ckSP;
     8: Result := ckPV;
     9: Result := ckFTI;
    10: Result := ckMSK;
    11: Result := ckTIS;
    12: Result := ckTSS;
    13: Result := ckPCHAS;
    14: Result := ckCHAS;
    15: Result := ckSYT;
    else Result := ckTI;
  end;
end;

function CatToNum(cat: TCategoryTI): Byte;
begin
  case cat of
    ckTI: Result := 1;
    ckTS: Result := 2;
    ckIIS: Result := 3;
    ckSV: Result := 4;
    ckPL: Result := 5;
    ckEI: Result := 6;
    ckSP: Result := 7;
    ckPV: Result := 8;
    ckFTI: Result := 9;
    ckMSK: Result := 10;
    ckTIS: Result := 11;
    ckTSS: Result := 12;
    ckPCHAS: Result := 13;
    ckCHAS: Result := 14;
    ckSYT: Result := 15;
    else Result := 1;
  end;
end;

//-------------------------------------------------------------------

function GetMaxAndHour(arr: TOutCKDataArray): string;
var
  ValueMax: Double;
  i: Integer;
begin
  Result:='';
  if Length(arr) >= 1 then
  begin
    ValueMax := arr[0].Value;
    Result := FloatToStr(arr[0].Value) + ' ('+ DtToStr(arr[0].TStamp,'hh:nn') + ')';
    for i:=0 to Length(arr)-1 do
      if (not PriznNoData(arr[i].Prizn)) and ((arr[i].Value > ValueMax) or (ValueMax = MinDouble)) then
      begin
        ValueMax := arr[i].Value;
        Result := FloatToStr(arr[i].Value) + ' ('+ DtToStr(arr[i].TStamp,'hh:nn') + ')';
      end;
  end;
end;

function GetMaxAndHour(arr: TOutCKDataArrayManyTI): TStringArray;
var
  i: Integer;
begin
  Result := nil;
  if Length(arr) >= 1 then
  begin
    SetLength(Result, Length(arr));
    for i:=0 to Length(arr)-1 do
      Result[i] := GetMaxAndHour(arr[i]);
  end;    
end;

function GetMinAndHour(arr: TOutCKDataArray): string;
var
  ValueMin: Double;
  i: Integer;
begin
  Result:='';
  if Length(arr) >= 1 then
  begin
    ValueMin := arr[0].Value;
    Result := FloatToStr(arr[0].Value) + ' ('+ DtToStr(arr[0].TStamp,'hh:nn') + ')';
    for i:=0 to Length(arr)-1 do
      if (not PriznNoData(arr[i].Prizn)) and ((arr[i].Value < ValueMin) or (ValueMin = MaxDouble)) then
      begin
        ValueMin := arr[i].Value;
        Result := FloatToStr(arr[i].Value) + ' ('+ DtToStr(arr[i].TStamp,'hh:nn') + ')';
      end;
  end;
end;

function GetMinAndHour(arr: TOutCKDataArrayManyTI): TStringArray;
var
  i: Integer;
begin
  Result := nil;
  if Length(arr) >= 1 then
  begin
    SetLength(Result, Length(arr));
    for i:=0 to Length(arr)-1 do
      Result[i] := GetMinAndHour(arr[i]);
  end;
end;

function GetAvg(arr: TOutCKDataArray): Double;
var
  count, i: Integer;
begin
  Result := 0;
  count := 0;
  if Length(arr) >= 1 then
    for i:= 0 to Length(arr)-1 do
      if not PriznNoData(arr[i].Prizn) then
      begin
        Result := Result + arr[i].Value;
        Inc(count);
      end;
  if count > 0 then
    Result := Result / count;
end;

function GetAvg(arr: TOutCKDataArrayManyTI): TDoubleArray;
var
  i: Integer; 
begin
  Result := nil;
  if Length(arr) >= 1 then
  begin
    SetLength(Result, Length(arr));
    for i:=0 to Length(arr)-1 do
      Result[i] := GetAvg(arr[i]);
  end;    
end;

function GetSum(arr: TOutCKDataArray): Double;
var
  i: Integer;
begin
  Result := 0;
  if Length(arr) >= 1 then
    for i:=0 to Length(arr)-1 do
      if not PriznNoData(arr[i].Prizn) then
        Result := Result + arr[i].Value;
end;

function GetSum(arr: TOutCKDataArrayManyTI): TDoubleArray;
var
  i: Integer;
begin
  Result := nil;
  if Length(arr) >= 1 then
  begin
    SetLength(Result, Length(arr));
    for i:=0 to Length(arr)-1 do
      Result[i] := GetSum(arr[i]);
  end;    
end;

procedure RoundArray(var arr: TOutCKDataArray; countsign: Byte);
var
  i: Integer;
begin
  if Length(arr) >= 1 then
    for i:=0 to Length(arr)-1 do
      arr[i].Value:=Math.RoundTo(arr[i].Value,-countsign);
end;

procedure RoundArray(var arr: TOutCKDataArrayManyTI; countsign: Byte);
var
  i: Integer;
begin
  if Length(arr) >= 1 then
    for i:=0 to Length(arr)-1 do
      RoundArray(arr[i],countsign);
end;

end.
