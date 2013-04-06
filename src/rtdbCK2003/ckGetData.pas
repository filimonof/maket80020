{
******************************************************************************
    ������ ������� � ������ ��-2003 (���� + MsSQL)
    ������ = 2.00
    ���������� ���
******************************************************************************
    ���������� (��� ��������) ��� ��������, �������������  � ������� � CK2003.
    ������� �������:
    rtdb.pas
    CatField.pas
    CatParam.pas
    CatParamList.pas
    ��� ����������� ���� ������ ����� ����� ����:
    CKUtils_TLB.pas
    ADODB_TLB.pas
    MSXML_TLB.pas
******************************************************************************
    ������ �������������:
uses
  ckGetData;
var
  ck: TCKData;
  res: TOutCKDataArray;
begin
  ck := TCKData.Create('����������� �����������');
  try
    if ck.OpenConnection(5,2,true) then
    begin
      res := ck.GetArrayValueTI_Sync(444,ckPV,ckTI48,Date());
      if res <> nil then
        for i:= 0 to Length(res)-1 do
          WriteLn( ck.DtToStr(res[i].TStamp) + ck.ValueToStr(res[i].Value) + ck.PriznToHexStr(res[i].Prizn) );
    end;
  finally
    ck.Free;
  end;
end;

    ������� �����������:
// ����������� � ��������� �������
ck.OpenConnection();
// ����������� � ������� ���������� ���\ckMain\OIK1
ck.OpenConnection('���������� ���\ckMain\OIK1');
// 5 ������� � ���������� 2 �������  � ��������� �������, true - ���� ��������� �� ������ �� ������ ����� �������
ck.OpenConnection(5, 2, true);
// ������ �� ������ ����� �������
ck.OpenConnection(0, 0, true);

******************************************************************************
}

unit ckGetData;

interface

uses  ADODB, SysUtils, Classes, Forms,
  rtdb, CatParam, CatParamList, Utime, CKUtils_TLB;

type
  TLengthArrayTI = (       // ����� ������
    ckTI24 = 24,           // 24 �����
    ckTI48 = 48            // 48 �����
  );

  TCategoryTI = (          // num   ������ ���������
    ckTI    =    73,       //  1    I 73 �������������	��
    ckTS    =    83,       //  2    S 83 �����������	��
    ckIIS   =    74,       //  3    J 74 ��������� � �������	��
    ckSV    =    87,       //  4    W 87 ��-1 (����������,���)	��
    ckPL    =    80,       //  5    P 80 �����	��
    ckEI    =    85,       //  6    U 85 ���������� ����������	��
    ckSP    =    67,       //  7    C 67 ����������� ��������� ������������	��
    ckPV    =    72,       //  8    H 72 ��-2 (�����������)	��
    ckFTI   =    76,       //  9    L 76 ������������� �������������	���
    ckMSK   =    77,       //  10   M 77 ����������� ��������� �������������	���
    ckTIS   =    65,       //  11   A 65 "������������� ""�����"""	���
    ckTSS   =    66,       //  12   B 66 "����������� ""�����"""	���
    ckPCHAS =    202,      //  13   � 202 ������������� ��������� 30 ���	����
    ckCHAS  =    203,      //  14   � 203 ������������� ��������� 1 ���	���
    ckSYT   =    207       //  15   � 207 ������������� ��������� 1 ����	���
  );    
{
������ �� �� ������������ (��� ����� InRTDB):
O ��� ��������� �� 0
� ��� ������������� ��������� 1 ��� 0
� ���� ������������� ��������� 5 ��� 0
� ���� ������������� ��������� 10 ��� 0
� ���� ������������� ��������� 15 ��� 0
� ��� ������������� ��������� 1 ����� 0
� �� ������.������ ��� ��������� ���������� (const) 0
� �� ��������� �������� �� ������ 0
D � ��������� ��������� ���������� ��������� 0
R � ������ (��������� �������� �� ������� Period) 0
T ��� ��������� ���������� ���������� 0
}
  TTI = record              // �������������
    id:  Cardinal;
    cat: TCategoryTI;
  end;
  TTIArray = array of TTI;


  TOutCKData = record       // ��������� �������
    TStamp: Cardinal;       // ���� �����
    Value:  Double;         // ��������
    Prizn:  Cardinal;       // ������� �������������
  end;
  TOutCKDataArray = array of TOutCKData;
  TOutCKDataArrayManyTI = array of TOutCKDataArray;

  TCKData = class
    Caption:      string;           // ��������� ������
    Connected:    Boolean;          // ���� �� ����������� � ����
  private
    CatStr:       string;           // ������ ��������� (����� ���������)
    CatList:      TCatParamList;    // �������� ������ ��������� �� � �� ����������������
    ADOCon:       TADOConnection;   // ���������� � SQL
    RTDBCon:      Word;             // ���������� � ����
    function      OIKPassword(Kernel: string): string;
    function      ConnectToSQL(Server: string; DataBase: string): Boolean;
  public
    constructor   Create(sCaption: string = 'CK2003');
    destructor    Free();
    function      OpenConnection(): Boolean; overload;
    function      OpenConnection(sOICAlias: string): Boolean; overload;
    function      OpenConnection(countR: Word; sec: Integer; isDlg: Boolean): Boolean; overload;
    procedure     CloseConnection();
    function      GetArrayValueTI_Sync(ti: Cardinal; cat: TCategoryTI; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArray; overload;
    function      GetArrayValueTI_Sync(ti: Cardinal; cat: TCategoryTI; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArray; overload;
    function      GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArrayManyTI; overload;
    function      GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArrayManyTI; overload;
    function      GetAlias(): string;
    function      DtToStr(dt: Cardinal; frm: string = 'dd.mm.yyyy hh:nn:ss'): string;
    function      PriznToHexStr(prz: Cardinal): string;
    function      PriznToStr(prz: Cardinal): string;    
    function      ValueToStr(val: Double; frm: string = '%f'): string;
    function      NumToCat(i: Byte): TCategoryTI;
    function      CatToNum(cat: TCategoryTI): Byte;        
  end;

implementation

constructor TCKData.Create(sCaption: string = 'CK2003');
begin
  CatStr  := '';
  Connected := false;
  Caption := sCaption;
  ADOCon  := TADOConnection.Create(nil);
  CatList := TCatParamList.Create;
end;

destructor TCKData.Free();
begin
  ADOCon.Free;
  CatList.Free;
end;

function TCKData.OpenConnection(): Boolean;
begin
  try try
    CloseConnection();  
    RTDBCon := CreateNewRTDBConnection;  // ������������ � ��������� ����
    Connected := false;
    if SetDefOIKEx(RTDBCon) = 1 then
      if ConnectToSQL(GetDefNSQLEx(RTDBCon), GetOIKBDEx(RTDBCon)) then
      begin
        OIKSetPasswordEx(RTDBCon, PChar(OIKPassword(GetOIKKrnlEx(RTDBCon))));
        if RTDBOpenEx(RTDBCon, PChar(Caption)) then
          Connected := true;
      end;
  except
    on E: Exception do raise Exception.Create('<-OpenConnection :' + E.Message);
  end;
  finally
    Result := Connected;
  end;
end;

function TCKData.OpenConnection(sOICAlias: string): Boolean;
begin
  try try
    CloseConnection();
    Connected := false;    
    RTDBCon := CreateNewRTDBConnection;  // ������������ � ��������� ����
    if SetOIKEx(RTDBCon, PChar(sOICAlias)) = 1 then
      if ConnectToSQL(GetDefNSQLEx(RTDBCon), GetOIKBDEx(RTDBCon)) then
      begin
        OIKSetPasswordEx(RTDBCon, PChar(OIKPassword(GetOIKKrnlEx(RTDBCon))));
        if RTDBOpenEx(RTDBCon, PChar(Caption)) then
          Connected := true;
      end;
  except
    on E: Exception do raise Exception.Create('<-OpenConnection :'+E.Message);
  end;
  finally
    Result := Connected;
  end;
end;

function TCKData.OpenConnection(countR: Word; sec: Integer; isDlg: Boolean): Boolean;  
var
  i:     Word;
  dlg:   IRTDBDialogs;
  alias: string;
begin
  Result := false;

  try
  
    if countR > 0 then
    begin
      for i:=1 to countR do
      begin
        if OpenConnection() then
        begin
          Result := true;
          Exit;
        end
        else
        begin
          Application.ProcessMessages;
          Sleep(sec*1000);
        end;
      end;
    end;
    // ���� �� ������� ����������� �� ����� �������

    if isDlg then
    begin
      dlg:=CoRTDBDialogs.Create;
      dlg.AppHandle:=Application.Handle;
      alias:=dlg.SelectRTDB;
      if alias = '' then
        Exit;
      alias:=Copy(alias, 1, Pos(';', alias)-1);
      Application.ProcessMessages;

      if countR > 0 then
      begin
        for i:=1 to countR do
        begin
          if OpenConnection(alias) then
          begin
            Result := true;
            Exit;
          end
          else
          begin
            Application.ProcessMessages;
            Sleep(sec*1000);
          end;
        end
      end
      else // countR = 0
        if OpenConnection(alias) then
        begin
          Result := true;
          Exit;
        end

    end;//dlg

    Result := false;
  except
    on E: Exception do raise Exception.Create('<-OpenConnection :'+E.Message);
  end;
end;

procedure TCKData.CloseConnection();
begin
  RTDBCloseEx(RTDBCon);
  DestroyRTDBConnection(RTDBCon);
end;

function TCKData.GetAlias: string;
begin
  Result := GetDomainEx(RTDBCon)+'\'+GetGroupEx(RTDBCon)+'\'+GetRTDBAbrEx(RTDBCon);
end;

function TCKData.OIKPassword(Kernel: string): string;
begin
  with TAdoQuery.Create(nil) do
  try
  try
    Connection := ADOCon;
    SQL.Text := 'exec '+Kernel+'..sp_localstyle';
    Prepared := True;
    Open;
    Result:=Fields[0].AsString;
  except
    on E: Exception do
    begin
      Result:='';
      raise Exception.Create('<-OIKPassword :'+E.Message);
    end;
  end;
  finally
    Free;
  end;
end;

function TCKData.ConnectToSQL(Server: string; DataBase: string): Boolean;
var
  i: Integer;
begin
  try
  try
    if ADOCon.Connected then
      ADOCon.Close;
    ADOCon.ConnectionString :=
      'Provider=SQLOLEDB.1;' +
      'Integrated Security=SSPI;' +
      'Persist Security Info=False;' +
      'Initial Catalog=' + DataBase + ';' +
      'Data Source=' + Server;
    ADOCon.LoginPrompt := false;  
    ADOCon.Open;

    CatList.Fill(ADOCon);
    // ���������� ����� ���������, ������ ������� �������� � ���� (����� �������)
    CatStr := '';
    for i:=0 to CatList.Count-1 do
      if CatList[i].InRTDB and not (CatList[i].Letter = 'E') then
        CatStr := CatStr + CatList[i].Letter;

  except
    on E: Exception do
    begin
      ADOCon.Close;
      raise Exception.Create('<-ConnectToSQL :'+E.Message);
    end;
  end;
  finally
    Result:=ADOCon.Connected;
  end;  
end;

//______________ Get Data ________________________________________________

function TCKData.GetArrayValueTI_Sync(ti: Cardinal; cat: TCategoryTI; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArray;
begin
  Result := GetArrayValueTI_Sync(ti,cat,lena,date1,date1+1);
end;

function TCKData.GetArrayValueTI_Sync(ti: Cardinal; cat: TCategoryTI; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArray;
var
  arr:    array of Cardinal;
  SQ:     SyncQuery;
  DS:     PData_Size;
  ofs:    Cardinal;
  TStamp: Cardinal;
  Prizn:  Cardinal;
  Value:  Double;
  cp:     TCatParam;
  dt:     TDateTime;
begin
  Result := nil;

  if date1 > date2 then
  begin
    dt := date1;
    date1 := date2;
    date2 := dt;
  end;

  if (ti = 0) then
    Exit;

  SetLength(arr, 1);
  arr[0] := ti;      

  // ��������� ��������� �������� ����������� �������
  FillChar(SQ, SizeOf(SQ), 0);
  SQ.typ := 5;
  SQ.oicat := Char(cat);
  SQ.query_size := Length(arr) * SizeOf(OI_Tstamp_Id);
  SQ.query_buf := Pointer(arr);
  // �����, � �������� ������������� �����
  SQ.TStart := Utime.DateTimeToUnix( Int(date1) + Frac(date1) );
  // �����, �� ������� ������������� �����
  SQ.TStop := Utime.DateTimeToUnix( Int(date2) + Frac(date2) );
  // ��� �������
  if lena = ckTI24 then
    SQ.step :=  60 * 60 // ����� ������
  else // ckTI48
    SQ.step :=  60 * 30; // ����� ������
  SQ.query_size := Length(arr) * SizeOf(Cardinal);
  SQ.query_buf := Pointer(arr);

  DS := RTDBQueryEx(RTDBCon, @SQ);
  // ���������� ������ ���������� ������ �� ��������� Data_Size, �
  // ������� ���������� ��������� �� ����� � ������, ��� ���������
  // ���������� ������� � ��� ������
  if DS <> nil then
  begin
    if DS.Ptr <> nil then
    begin
      Ofs := 0;
      // ��������� ���������� ������
      while Ofs < DS.Size do
      begin
        TStamp := PCardinal(Cardinal(DS.Ptr) + Ofs)^;
        Ofs := Ofs + SizeOf(Cardinal);

        Ofs := Ofs + SizeOf(Cardinal);

        cp := CatList.FindCat(Char(cat));
        cp.GetValFromBuf(DS.Ptr, Ofs, Value, Prizn);

        SetLength(Result,Length(Result)+1);
        Result[Length(Result)-1].TStamp := TStamp;
        Result[Length(Result)-1].Value := Value;
        Result[Length(Result)-1].Prizn := Prizn;

      end;
      // ������� ������� ���������� ���
      if Length(Result)>1 then
        SetLength(Result,Length(Result)-1);
    end;
    // ����������� ������
    RTDBDeleteDataEx(RTDBCon, DS);
  end;
end;

function TCKData.GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1: TDateTime): TOutCKDataArrayManyTI;
begin
  Result := GetArrayValueTI_Sync(ti,lena,date1,date1+1);
end;

function TCKData.GetArrayValueTI_Sync(ti: TTIArray; lena: TLengthArrayTI; date1, date2: TDateTime): TOutCKDataArrayManyTI;
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

// _________ Output function _________________________________________________

function TCKData.DtToStr(dt: Cardinal; frm: string = 'dd.mm.yyyy hh:nn:ss'): string;
begin
  Result := FormatDateTime(frm, UnixToDateTime(dt));
end;

function TCKData.ValueToStr(val: Double; frm: string = '%f'): string;
begin
  Result := Format(frm, [val]);
end;

function TCKData.PriznToHexStr(prz: Cardinal): string;
begin
  Result := '0x' + IntToHex(prz, 8);
end;

function TCKData.PriznToStr(prz: Cardinal): string;
begin
{
 00 000 001 - ���������������: ������� ��
 00 000 002 - ��������: ������ ���� � ����������� ��
 00 000 202 - ��������: ������ ���� ��� ����������
 00 000 004 - ���������������: ��������� ��
 00 000 008 - ���������������:  ���
 00 000 010 - ��������: ������
 00 000 030 - ���������������: ��������� �������
 00 000 040 - ��������: ������� �������
 00 000 080 - ���������������: ���� ����������
 00 000 100 - ��������: ����������
 00 000 200 - ���������������: ������������
 00 000 400 - ���������������: ���� �������
 00 000 800 - ���������������: �� �����
 00 001 000 - ���������������: ��������� ���. ������
 00 002 000 - ���������������: �� ������ ���������
 00 008 000 - ��� ������
 00 010 000 - ���������: ������ ���������
 00 020 000 - ���������: ������� �����������������
 00 040 000 - ���������: ������ �����������������
 00 080 000 - ������: �������� �����������
 00 100 000 - ������: ������
 00 200 000 - ���������: ������� ���������
 00 800 000 - ���������������: ������
 01 000 000 - ������: ��������������
 04 000 000 - ��������: ��������������� ������
 08 000 000 - ���������������: ���������� �� ������
 10 000 000 - ��������: ������ �����
 20 000 000 - ��������: ���������
 40 000 000 - ��������: ������ ����������� ��������
}
  if PriznToHexStr(prz) = '0x00000001' then
    Result := '���������������: ������� ��'
  else if PriznToHexStr(prz) = '0x00000002' then
    Result := '��������: ������ ���� � ����������� ��'
  else if PriznToHexStr(prz) = '0x00000202' then
    Result := '��������: ������ ���� ��� ����������'
  else if PriznToHexStr(prz) = '0x00000004' then
    Result := '���������������: ��������� ��'
  else if PriznToHexStr(prz) = '0x00000008' then
    Result := '���������������:  ���'
  else if PriznToHexStr(prz) = '0x00000010' then
    Result := '��������: ������'
  else if PriznToHexStr(prz) = '0x00000030' then
    Result := '���������������: ��������� �������'
  else if PriznToHexStr(prz) = '0x00000040' then
    Result := '��������: ������� �������'
  else if PriznToHexStr(prz) = '0x00000080' then
    Result := '���������������: ���� ����������'
  else if PriznToHexStr(prz) = '0x00000100' then
    Result := '��������: ����������'
  else if PriznToHexStr(prz) = '0x00000200' then
    Result := '���������������: ������������'
  else if PriznToHexStr(prz) = '0x00000400' then
    Result := '���������������: ���� �������'
  else if PriznToHexStr(prz) = '0x00000800' then
    Result := '���������������: �� �����'
  else if PriznToHexStr(prz) = '0x00001000' then
    Result := '���������������: ��������� ���. ������'
  else if PriznToHexStr(prz) = '0x00002000' then
    Result := '���������������: �� ������ ���������'                 
  else if PriznToHexStr(prz) = '0x00008000' then
    Result := '��� ������'
  else if PriznToHexStr(prz) = '0x00010000' then
    Result := '���������: ������ ���������'
  else if PriznToHexStr(prz) = '0x00020000' then
    Result := '���������: ������� �����������������'
  else if PriznToHexStr(prz) = '0x00040000' then
    Result := '���������: ������ �����������������'
  else if PriznToHexStr(prz) = '0x00080000' then
    Result := '������: �������� �����������'
  else if PriznToHexStr(prz) = '0x00100000' then
    Result := '������: ������'
  else if PriznToHexStr(prz) = '0x00200000' then
    Result := '���������: ������� ���������'
  else if PriznToHexStr(prz) = '0x00800000' then
    Result := '���������������: ������'
  else if PriznToHexStr(prz) = '0x01000000' then
    Result := '������: ��������������'
  else if PriznToHexStr(prz) = '0x04000000' then
    Result := '��������: ��������������� ������'
  else if PriznToHexStr(prz) = '0x08000000' then
    Result := '���������������: ���������� �� ������'
  else if PriznToHexStr(prz) = '0x10000000' then
    Result := '��������: ������ �����'
  else if PriznToHexStr(prz) = '0x20000000' then
    Result := '��������: ���������'
  else if PriznToHexStr(prz) = '0x40000000' then
    Result := '��������: ������ ����������� ��������'     
  else
    Result := PriznToHexStr(prz);
end;

function TCKData.NumToCat(i: Byte): TCategoryTI;
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

function TCKData.CatToNum(cat: TCategoryTI): Byte;
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

end.
