{$DEFINE TEST_AUTO}
{$UNDEF TEST_AUTO}


unit dmData_u;

interface

uses
  SysUtils, Classes, DB, ADODB, SakSMTP, SakMsg, uVar, Forms, SakPOP3, Dialogs,
  Graphics, ck7GetData, MidasLib;

type
  TdmData = class(TDataModule)
    SakSMTP1: TSakSMTP;
    SakMsg1: TSakMsg;
    SakPOP1: TSakPOP;
    SakMsgList1: TSakMsgList;
    adc80020: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    ck2007: Tck7Data;
    function ConnectDB(isDial: Boolean = true): Boolean;
    procedure TestAfterConnect;
    procedure RefreshStatusBar;  
    procedure DisconnectDB;
    procedure GetIni;
    procedure PutIni;
    function Crypt(s: string): string;
    function DeCrypt(s: string): string;
    function  SendMailSMTP(mail :recSMTPSendMail; filesatt: array of string; countatt:Integer): Boolean;
    function GetParam(name: string): string;
    function SetParam(name,value: string): Boolean;
    procedure Get80020sendmail(var mail: recSMTPSendMail);
    procedure Get80020getmail(var mail: recPOPGetMail);
    procedure Get80020subscribe(var mail: recSubscribe);
    procedure AutoLoad();
    procedure AutoTestPost();
    procedure AutoLoadSubscribePost();    
    function StatusIsCommerce(val: TOutCKData): string;    
    function VarToStrDefIsNull(val: TOutCKData; koef: Integer; def: string): string;          
  end;

var
  dmData: TdmData;

implementation

uses uUtils, uAdoUtils, dlgProcess_u, IniFiles, dlgInputSQLPas_u, frmMain_u, uLog,
  Math;

{$R *.dfm}

procedure TdmData.DataModuleCreate(Sender: TObject);
begin
  ck2007 := Tck7Data.Create('Макет 80020');
  mServersCK[1].Pclass := ck2007;

  if not ( (ParamCount > 0) and ( ParamStr(1) = 'auto') ) then
  begin
    // обычная работа прораммы, оконный режим

    ShowProcessCancel(Application.MainForm,'Чтение настроек баз данных...');
    try
      GetIni;
      DisconnectDB;
    finally
      HideProcessCancel;
    end;

    ConnectDB;
    TestAfterConnect;
    RefreshStatusBar;

    ShowProcessCancel(Application.MainForm,'Чтение настроек макета...');
    try
      Get80020sendmail(m80020sendmail);
      Get80020getmail(m80020getmail);
      Get80020subscribe(m80020subscribe);
    finally
      HideProcessCancel;
    end;

  end
  else
  try
    // автоматическая отправка , без диалоговых окон
    Application.ShowMainForm := false;
    GetIni;
    ConnectDB(false);

    Get80020sendmail(m80020sendmail);
    Get80020getmail(m80020getmail);
    Get80020subscribe(m80020subscribe);

    //автоматическая загрузка макетов
    AutoLoadSubscribePost();
    //автоматическая отправка макета
    AutoLoad();
    // автоматическое получение ответов , без диалоговых окон
    AutoTestPost();

  finally
    Application.Terminate;
  end;
end;

procedure TdmData.TestAfterConnect;
begin
  frmMain.aLogList.Enabled := true;
  frmMain.aTestPost.Enabled := true;
  frmMain.aSendMaket.Enabled := true;
  frmMain.aOptionsMaket.Enabled := true;
  frmMain.aPreview.Enabled := true;
  frmMain.aLoadMaketToDisk.Enabled := true;


  if mServersSQL[1].Active = false then
  begin
    MessageDlg('Основная база данных не подключена.'#10#13'Зайдите в настройки баз данных и укажите правильные параметры.',mtInformation,[mbOk],0);
    frmMain.aLogList.Enabled := false;
    frmMain.aTestPost.Enabled := false;
    frmMain.aSendMaket.Enabled := false;
    frmMain.aOptionsMaket.Enabled := false;
    frmMain.aPreview.Enabled := false;
    frmMain.aLoadMaketToDisk.Enabled := false;
  end;

  if mServersCK[1].Active = false then
  begin
    MessageDlg('База данных СК-2003 не подключена.'#10#13'Вы не сможете сформировать макет 80020.'#10#13'Зайдите в настройки баз данных и укажите правильные параметры.',mtInformation,[mbOk],0);
    frmMain.aSendMaket.Enabled := false;
    frmMain.aPreview.Enabled := false;    
  end;  
end;

procedure TdmData.RefreshStatusBar;
begin
  frmMain.dxStatusBar1.Panels[0].Text := ParseStr('comp:user = <%computer%>:<%user%>');

  frmMain.dxStatusBar1.Panels[1].Text := mServersSQL[1].Name;
  if mServersSQL[1].Active then
    frmMain.dxStatusBar1.Panels[1].PanelStyle.Font.Color := clGreen
  else
    frmMain.dxStatusBar1.Panels[1].PanelStyle.Font.Color := clMaroon;

  frmMain.dxStatusBar1.Panels[2].Text := mServersCK[1].Name;
  if mServersCK[1].Active then
    frmMain.dxStatusBar1.Panels[2].PanelStyle.Font.Color := clGreen
  else
    frmMain.dxStatusBar1.Panels[2].PanelStyle.Font.Color := clMaroon;
end;

function TdmData.ConnectDB(isDial: Boolean = true): Boolean;
var
  scon: string;
  i: Integer;
  adc: TADOConnection;
begin
  Result:=false;
  try
    if isDial then ShowProcessCancel(self,'Подключение к базам данных...');
    DisconnectDB;
{
   if COUNT_SERVERS_ACCESS > 0 then
    for i:=1 to COUNT_SERVERS_ACCESS do
      if mServersAccess[i].Active then
      try
        adc := TADOConnection(FindComponent( mServersAccess[i].NameComponents));
        adc.DefaultDatabase := '';
        adc.CommandTimeout := mServersAccess[i].TimeOut;
        adc.ConnectionTimeout := mServersAccess[i].TimeOut;
        sCon := Format('Provider=MSDASQL.1;Password=;'
          +'Persist Security Info=True;User ID=;Mode=ReadWrite;'
          +'Extended Properties="DBQ=%s;'
          +'Driver={Driver do Microsoft Access (*.mdb)}{;MaxBufferSize=2048;'
          +'MaxScanRows=8;PageTimeout=5;SafeTransactions=0;Threads=3;'
          +'UID=admin;UserCommitSync=Yes;"'
          , [mServersAccess[i].NameDB]);
        adc.ConnectionString := sCon;
        adc.LoginPrompt:=false;
        adc.Connected:=true;
      except
        on E : Exception do
        begin
          mServersAccess[i].Active:= false;
          if isDial then
            MessageDlg(Format('Ошибка при подключении к базе данных %s :'#10#13' %s', [mServersAccess[i].Name,E.Message]),mtError,[mbOk],0)
          else
            Log_Error(Format('Ошибка при подключении к базе данных %s : %s', [mServersAccess[i].Name,E.Message]));
        end;
      end;
}

   if COUNT_SERVERS_SQL > 0 then
    for i:=1 to COUNT_SERVERS_SQL do
    begin
      if mServersSQL[i].Active then
      try
        adc := TADOConnection(FindComponent( mServersSQL[i].NameComponent));
        adc.DefaultDatabase := '';
        adc.CommandTimeout := mServersSQL[i].TimeOut;
        adc.ConnectionTimeout := mServersSQL[i].TimeOut;
        sCon := Format('Provider=SQLOLEDB.1;Data Source=%s;Initial Catalog=%s;',
          [mServersSQL[i].ServerIP, mServersSQL[i].NameDB]);
        if mServersSQL[i].WinNTAuth then
        begin
          sCon := sCon + 'Integrated Security=SSPI';
        end
        else
        begin
          sCon := sCon + 'User ID='+mServersSQL[i].Login+';';
          sCon := sCon + 'Password='+mServersSQL[i].Password;
        end;
        adc.ConnectionString := sCon;
        adc.LoginPrompt:=false;
        adc.Connected:=true;
        sSQLDateTimeFormat[i] := GetSQLDateTimeFormat(adc);        
      except
        on E : Exception do
        begin
          mServersSQL[i].Active:= false;
          if isDial then
            MessageDlg(Format('Ошибка при подключении к базе данных %s :'#10#13' %s', [mServersSQL[i].Name,E.Message]),mtError,[mbOk],0)
          else
            Log_Error(Format('Ошибка при подключении к базе данных %s : %s', [mServersSQL[i].Name,E.Message]));
        end;
      end;
    end;


   if COUNT_SERVERS_CK > 0 then
    for i:=1 to COUNT_SERVERS_CK do
      if mServersCK[i].Active then
      try
        mServersCK[i].Pclass.SQLServers.Clear();
        if mServersCK[i].WinAuth_1 then
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_1))
        else
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_1, mServersCK[i].Login_1, mServersCK[i].Pas_1));
        if mServersCK[i].WinAuth_2 then
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_2))
        else
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_2, mServersCK[i].Login_2, mServersCK[i].Pas_2));
        if mServersCK[i].WinAuth_3 then
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_3))
        else
          mServersCK[i].Pclass.SQLServers.Add(Tck7SQLServer.Create(mServersCK[i].Server_3, mServersCK[i].Login_3, mServersCK[i].Pas_3));
        mServersCK[i].Pclass.TimeOut := mServersCK[i].TimeOut;
        mServersCK[i].Active := mServersCK[i].Pclass.OpenConnection();

        if not mServersCK[i].Active then
        begin
          if isDial then
            MessageDlg(Format('Не удалось подключиться к базе данных %s .', [mServersCK[i].Name]),mtError,[mbOk],0)
          else
            Log_Error(Format('Не удалось подключиться к базе данных %s .', [mServersCK[i].Name]));
        end;
      except
        on E : Exception do
        begin
          mServersCK[i].Active:= false;
          if isDial then
            MessageDlg(Format('Ошибка при подключении к базе данных %s :'#10#13' %s', [mServersCK[i].Name,E.Message]),mtError,[mbOk],0)
          else
            Log_Error(Format('Ошибка при подключении к базе данных %s : %s', [mServersCK[i].Name,E.Message]));
        end;
      end;
  finally
    if isDial then
      HideProcessCancel;
  end;       
end;

procedure TdmData.DisconnectDB;
var
  i: Integer;
begin
  if COUNT_SERVERS_CK > 0 then
    for i:=1 to COUNT_SERVERS_CK do
      mServersCK[i].Pclass.CloseConnection();
  if COUNT_SERVERS_SQL > 0 then
    for i:=1 to COUNT_SERVERS_SQL do
      TADOConnection(FindComponent(mServersSQL[i].NameComponent)).Connected := false;
{
  if COUNT_SERVERS_ACCESS > 0 then
    for i:=1 to COUNT_SERVERS_ACCESS do
      TADOConnection(FindComponent(mServersAccess[i].NameComponents)).Connected := false;
}      
end;

procedure TdmData.GetIni;
var
  i: Integer;
  s: string;
begin
  with TIniFile.Create(sPath + INI_FILE) do
  try
  {
    for i:=1 to COUNT_SERVERS_ACCESS do
    begin
      mServersAccess[i].Active  := ReadBool('DBA'+IntToStr(i),'Active',mServersAccess[i].Active);
      mServersAccess[i].Name    := ReadString('DBA'+IntToStr(i), 'Name',mServersAccess[i].Name);
      mServersAccess[i].TimeOut := ReadInteger('DBA'+IntToStr(i), 'TimeOut',mServersAccess[i].TimeOut);
      mServersAccess[i].NameDB  := ReadString('DBA'+IntToStr(i), 'Database', mServersAccess[i].NameDB);
    end;
   }
   
    for i:=1 to COUNT_SERVERS_SQL do
    begin
      mServersSQL[i].Active  := ReadBool('DB'+IntToStr(i),'Active',mServersSQL[i].Active);
      mServersSQL[i].Name    := ReadString('DB'+IntToStr(i), 'Name',mServersSQL[i].Name);
      mServersSQL[i].TimeOut := ReadInteger('DB'+IntToStr(i), 'TimeOut',mServersSQL[i].TimeOut);
      mServersSQL[i].ServerIP  := ReadString('DB'+IntToStr(i), 'Server', mServersSQL[i].ServerIP);
      mServersSQL[i].NameDB  := ReadString('DB'+IntToStr(i), 'Database', mServersSQL[i].NameDB);
      mServersSQL[i].Login  := ReadString('DB'+IntToStr(i), 'Login', mServersSQL[i].Login);
      mServersSQL[i].Password  := DeCrypt(ReadString('DB'+IntToStr(i), 'Password', mServersSQL[i].Password));
      mServersSQL[i].WinNTAuth  := ReadBool('DB'+IntToStr(i),'WinNT',mServersSQL[i].WinNTAuth);
   end;

    for i:=1 to COUNT_SERVERS_CK do
    begin
      mServersCK[i].Active := ReadBool('DBCK'+IntToStr(i),'Active',mServersCK[i].Active);
      mServersCK[i].Name := ReadString('DBCK'+IntToStr(i), 'Name',mServersCK[i].Name);
      mServersCK[i].Server_1 := ReadString('DBCK'+IntToStr(i), 'Server_1',mServersCK[i].Server_1);
      mServersCK[i].WinAuth_1 := ReadBool('DBCK'+IntToStr(i),'WinAuth_1',mServersCK[i].WinAuth_1);
      mServersCK[i].Login_1 := ReadString('DBCK'+IntToStr(i), 'Login_1',mServersCK[i].Login_1);
      mServersCK[i].Pas_1 := DeCrypt(ReadString('DBCK'+IntToStr(i), 'Pas_1',mServersCK[i].Pas_1));
      mServersCK[i].Server_2 := ReadString('DBCK'+IntToStr(i), 'Server_2',mServersCK[i].Server_2);
      mServersCK[i].WinAuth_2 := ReadBool('DBCK'+IntToStr(i),'WinAuth_2',mServersCK[i].WinAuth_2);
      mServersCK[i].Login_2 := ReadString('DBCK'+IntToStr(i), 'Login_2',mServersCK[i].Login_2);
      mServersCK[i].Pas_2 := DeCrypt(ReadString('DBCK'+IntToStr(i), 'Pas_2',mServersCK[i].Pas_2));
      mServersCK[i].Server_3 := ReadString('DBCK'+IntToStr(i), 'Server_3',mServersCK[i].Server_3);
      mServersCK[i].WinAuth_3 := ReadBool('DBCK'+IntToStr(i),'WinAuth_3',mServersCK[i].WinAuth_3);
      mServersCK[i].Login_3 := ReadString('DBCK'+IntToStr(i), 'Login_3',mServersCK[i].Login_3);
      mServersCK[i].Pas_3 := DeCrypt(ReadString('DBCK'+IntToStr(i), 'Pas_3',mServersCK[i].Pas_3));
    end;
  finally
    Free;
  end;
end;

procedure TdmData.PutIni;
var
  i: Integer;
begin
  with TIniFile.Create(sPath + INI_FILE) do
  try
  {
    for i:=1 to COUNT_SERVERS_ACCESS do
    begin
      WriteBool('DBA'+IntToStr(i),'Active',mServersAccess[i].Active);
      WriteString('DBA'+IntToStr(i), 'Name', mServersAccess[i].Name);
      WriteInteger('DBA'+IntToStr(i), 'TimeOut', mServersAccess[i].TimeOut);
      WriteString('DBA'+IntToStr(i), 'Database', mServersAccess[i].NameDB);
    end;
   }
    for i:=1 to COUNT_SERVERS_SQL do
    begin
      WriteBool('DB'+IntToStr(i),'Active',mServersSQL[i].Active);
      WriteString('DB'+IntToStr(i), 'Name', mServersSQL[i].Name);
      WriteInteger('DB'+IntToStr(i), 'TimeOut', mServersSQL[i].TimeOut);
      WriteString('DB'+IntToStr(i), 'Server', mServersSQL[i].ServerIP);
      WriteString('DB'+IntToStr(i), 'Database', mServersSQL[i].NameDB);
      WriteString('DB'+IntToStr(i), 'Login', mServersSQL[i].Login);
      WriteString('DB'+IntToStr(i), 'Password', Crypt(mServersSQL[i].Password));
      WriteBool('DB'+IntToStr(i),'WinNT',mServersSQL[i].WinNTAuth);
    end;
       
    for i:=1 to COUNT_SERVERS_CK do
    begin
      WriteBool('DBCK'+IntToStr(i),'Active',mServersCK[i].Active);
      WriteString('DBCK'+IntToStr(i), 'Name', mServersCK[i].Name);
      WriteString('DBCK'+IntToStr(i), 'Server_1', mServersCK[i].Server_1);
      WriteBool('DBCK'+IntToStr(i),'WinAuth_1',mServersCK[i].WinAuth_1);
      WriteString('DBCK'+IntToStr(i), 'Login_1', mServersCK[i].Login_1);
      WriteString('DBCK'+IntToStr(i), 'Pas_1', Crypt(mServersCK[i].Pas_1));
      WriteString('DBCK'+IntToStr(i), 'Server_2', mServersCK[i].Server_2);
      WriteBool('DBCK'+IntToStr(i),'WinAuth_2',mServersCK[i].WinAuth_2);
      WriteString('DBCK'+IntToStr(i), 'Login_2', mServersCK[i].Login_2);
      WriteString('DBCK'+IntToStr(i), 'Pas_2', Crypt(mServersCK[i].Pas_2));
      WriteString('DBCK'+IntToStr(i), 'Server_3', mServersCK[i].Server_3);
      WriteBool('DBCK'+IntToStr(i),'WinAuth_3',mServersCK[i].WinAuth_3);
      WriteString('DBCK'+IntToStr(i), 'Login_3', mServersCK[i].Login_3);
      WriteString('DBCK'+IntToStr(i), 'Pas_3', Crypt(mServersCK[i].Pas_3));
    end;
  finally
    Free;
  end;
end;

function TdmData.GetParam(name: string): string;
var
  aq: TAdoQuery;
begin
  aq:=SelectQuerySimple(adc80020,Format('select top 1 * from tblMaket80020Options where [name]=''%s''',[name]));
  try
    if not aq.IsEmpty then
      Result := aq.FieldByName('value').AsString
    else
    begin
      ExecQuerySimple(adc80020,Format('insert into tblMaket80020Options ([name],[value]) values (''%s'','''')',[name]));
      Result := '';
    end;
  finally
    aq.Free;
  end;
end;

function TdmData.SetParam(name,value: string): Boolean;
begin
  Result := ExecQuerySimple(adc80020,Format('update tblMaket80020Options  set [value]=''%s'' where [name]=''%s'' ',[value,name])) = 0 ;
end;

function TdmData.Crypt(s: string): string;
var
  i: Integer;
  news: string;
begin
  news:='';
  for i:=1 to Length(s) do
    news:=news+Chr(Ord(s[i]) xor Ord(CRYPT_KEY)) + Chr(Random(50)+150);
  Result:=news;
end;

function TdmData.DeCrypt(s: string): string;
var
  i: Integer;
  news: string;
begin
  news:='';
  for i:=1 to Length(s) do
    if odd(i) then
      news:=news+Chr(Ord(s[i]) xor Ord(CRYPT_KEY));
  Result:=news;
end;

procedure TdmData.Get80020sendmail(var mail: recSMTPSendMail);
var
  aq: TAdoQuery;
begin
  with mail do
  begin
    Active := false;
    SMTPserver := '';
    SMTPport := '';
    TimeOut := 0;
    mailbox := '';
    OtKogo := '';
    Subject := '';
    Komu := '';
    CharSet := '';
    TextEncoding := te8Bit;
    FileFormat := '';
    FileTmpDelete := false;
    FileZiped := false;
  end;
  aq:=SelectQuerySimple(adc80020,'select * from tblMaket80020Options');
  try
    if aq.Locate('name',PARAM_SMTP_ACTIVE,[loCaseInsensitive,loPartialKey]) then
      mail.Active := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_SMTP_SERVER,[loCaseInsensitive,loPartialKey]) then
      mail.SMTPserver := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_PORT,[loCaseInsensitive,loPartialKey]) then
      mail.SMTPport := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_TIMEOUT,[loCaseInsensitive,loPartialKey]) then
      mail.TimeOut := aq.FieldByName('value').AsInteger;
    if aq.Locate('name',PARAM_SMTP_MAILBOX,[loCaseInsensitive,loPartialKey]) then
      mail.mailbox := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_OTKOGO,[loCaseInsensitive,loPartialKey]) then
      mail.OtKogo := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_SUBJECT,[loCaseInsensitive,loPartialKey]) then
      mail.Subject := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_KOMU,[loCaseInsensitive,loPartialKey]) then
      mail.Komu := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_CHARSET,[loCaseInsensitive,loPartialKey]) then
      mail.CharSet := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_TEXTENCODING,[loCaseInsensitive,loPartialKey]) then
    begin
      if aq.FieldByName('value').AsString = 'teBase64' then
        mail.TextEncoding := teBase64
      else
        mail.TextEncoding := te8Bit;
    end;
    if aq.Locate('name',PARAM_SMTP_FILEFORMAT,[loCaseInsensitive,loPartialKey]) then
      mail.FileFormat := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_SMTP_FILETMPDELETE,[loCaseInsensitive,loPartialKey]) then
      mail.FileTmpDelete := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_SMTP_FILEZIPED,[loCaseInsensitive,loPartialKey]) then
      mail.FileZiped := StrToBoolDef(aq.FieldByName('value').AsString,false);
  finally
    aq.Free;
  end;
end;

procedure TdmData.Get80020getmail(var mail: recPOPGetMail);
var
  aq: TAdoQuery;
begin
  with mail do
  begin
    Active := false;
    POPserver := '';
    POPport := '';
    Login := '';
    Password := '';
    FileFormat := '';
    IsEmailFrom := false;
    EmailFrom := '';
    IsDeleteLoadedEmail := false;
    FileTmpDelete := false;
  end;
  aq:=SelectQuerySimple(adc80020,'select * from tblMaket80020Options');
  try
    if aq.Locate('name',PARAM_POP_ACTIVE,[loCaseInsensitive,loPartialKey]) then
      mail.Active := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_POP_SERVER,[loCaseInsensitive,loPartialKey]) then
      mail.POPserver := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_POP_PORT,[loCaseInsensitive,loPartialKey]) then
      mail.POPport := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_POP_LOGIN,[loCaseInsensitive,loPartialKey]) then
      mail.Login := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_POP_PASSWORD,[loCaseInsensitive,loPartialKey]) then
      mail.Password := DeCrypt(aq.FieldByName('value').AsString);
    if aq.Locate('name',PARAM_POP_FILEFORMAT,[loCaseInsensitive,loPartialKey]) then
      mail.FileFormat := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_POP_ISEMAILFROM,[loCaseInsensitive,loPartialKey]) then
      mail.IsEmailFrom := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_POP_EMAILFROM,[loCaseInsensitive,loPartialKey]) then
      mail.EmailFrom := aq.FieldByName('value').AsString;
    if aq.Locate('name',PARAM_POP_ISDELETELOADDEDEMAIL,[loCaseInsensitive,loPartialKey]) then
      mail.IsDeleteLoadedEmail := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_POP_FILETMPDELETE,[loCaseInsensitive,loPartialKey]) then
      mail.FileTmpDelete := StrToBoolDef(aq.FieldByName('value').AsString,false);
  finally
    aq.Free;
  end;
end;

procedure TdmData.Get80020subscribe(var mail: recSubscribe);
var
  aq: TAdoQuery;
begin
  with mail do
  begin
    Active:= true;
    IsDeleteLoadedEmail:= true;
    FileTmpDelete:= true;
    FileZipped:= true;
  end;
  aq:=SelectQuerySimple(adc80020,'select * from tblMaket80020Options');
  try
    if aq.Locate('name',PARAM_SUBSCRIBE_ACTIVE,[loCaseInsensitive,loPartialKey]) then
      mail.Active := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_SUBSCRIBE_ISDELETELOADDEDEMAIL,[loCaseInsensitive,loPartialKey]) then
      mail.IsDeleteLoadedEmail := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_SUBSCRIBE_FILETMPDELETE,[loCaseInsensitive,loPartialKey]) then
      mail.FileTmpDelete := StrToBoolDef(aq.FieldByName('value').AsString,false);
    if aq.Locate('name',PARAM_SUBSCRIBE_FILEZIPED,[loCaseInsensitive,loPartialKey]) then
      mail.FileZipped := StrToBoolDef(aq.FieldByName('value').AsString,false);
  finally
    aq.Free;
  end;
end;

function  TdmData.SendMailSMTP(mail :recSMTPSendMail; filesatt: array of string; countatt:Integer): Boolean;
var
  i: Integer;
begin
  try
    try
      Result:=false;
      SakSMTP1.host := mail.SMTPserver;
      SakSMTP1.port := mail.SMTPport;
      SakSMTP1.TimeOut := mail.TimeOut;

      SakMsg1.CharSet := mail.CharSet;
      SakMsg1.TextEncoding := mail.TextEncoding;
      SakMsg1.From := mail.mailbox;
      SakMsg1.UserName := ParseStr(mail.OtKogo);
      SakMsg1.Subject := ParseStr(mail.Subject);
      SakMsg1.SendTo := StringReplace(mail.Komu,';',',',[rfReplaceAll, rfIgnoreCase]);

      SakMsg1.Text.Clear;
      SakMsg1.Text.Add('Количество вложенных файлов: '+IntToStr(countatt));

      SakMsg1.AttachedFiles.clear;
      for i:=1 to countatt do
        if FileExists(filesatt[i-1]) then
          SakMsg1.AttachedFiles.Add(filesatt[i-1]);

      SakSMTP1.Connect;
      if not SakSMTP1.SMTPError then
      begin
        SakSMTP1.SendTheMessage(SakMsg1);
        SakSMTP1.Disconnect;
      end;

      SakMsg1.Free;
      SakMsg1 := TSakMsg.Create(self);

      Result:=true;
    except
      Result:=false;
    end;
  finally

  end;         
end;

procedure TdmData.AutoLoad();
var
  dt1,dt2: TDateTime;
  aq: TADOQuery;
begin
  // автоматическая отправка , без диалоговых окон
{$IFDEF TEST_AUTO}
  Log_Info('Автоматическая отправка макета.');
{$ENDIF}
  try
    if (mServersSQL[1].Active) and (mServersCK[1].Active) then
    begin
      //нужно вычеслить дату последней отправки
      aq:=SelectQuerySimple(adc80020,'select max(DateFile) as MaxDateFile from tblMaket80020Log where status in (1,2,3)');
      try
        if aq.FieldByName('MaxDateFile').IsNull then
          dt1 := Date()-2 //позавчарася (чтоб за вчарася отправять)
        else
          dt1 := aq.FieldByName('MaxDateFile').AsDateTime + 1;
      finally
        aq.Free;
      end;
      dt2 := Date()-1;

{$IFDEF TEST_AUTO}
     // dt1 := Date()-1;
{$ENDIF}

      // отправить за все дни до сегоднешнего
      if ( dt1 <= dt2 ) then
      begin
        frmMain.SendMaket(dt1,dt2,false,nil);
        if dt1 <> dt2 then
          Log_Info('Автоматическая отправка за '+DateToStr(dt1)+' - '+DateToStr(dt2))
        else
          Log_Info('Автоматическая отправка за '+DateToStr(dt1));
      end;

{$IFDEF TEST_AUTO}
      Log_Info('Автоматическая отправка макета прошла.');
{$ENDIF}

    end;

  except
    on E : Exception do
    begin
      Log_Error(Format('Ошибка при авто-отправке : %s ', [E.Message]));
    end;
  end;

end;

procedure TdmData.AutoTestPost();
var
  s: string;
begin
  // автоматическое получение ответов , без диалоговых окон
{$IFDEF TEST_AUTO}
      Log_Info('Автоматическое получение ответов.');
{$ENDIF}
  if (mServersSQL[1].Active) then
  try

    s:=frmMain.PrepareTestMail(false);
    
    if Trim(s)<>'' then
      Log_Error(s);
{$IFDEF TEST_AUTO}
      Log_Info('Автоматическое получение ответов прошло.');
{$ENDIF}
  except
    on E : Exception do
    begin
      Log_Error(Format('Ошибка при авто-получении: %s ', [E.Message]));
    end;
  end;
end;


procedure TdmData.AutoLoadSubscribePost();
var
  s: string;
begin
  // автоматическое получение макетов , без диалоговых окон
{$IFDEF TEST_AUTO}
      Log_Info('Автоматическое получение макетов.');
{$ENDIF}
  if (mServersSQL[1].Active) then
  try

    s:=frmMain.LoadMailSubscribe(false, true);

    if Trim(s)<>'' then
      Log_Error(s);
{$IFDEF TEST_AUTO}
      Log_Info('Автоматическое получение макетов прошло.');
{$ENDIF}
  except
    on E : Exception do
    begin
      Log_Error(Format('Ошибка при авто-получении макетов: %s ', [E.Message]));
    end;
  end;
end;

function TdmData.StatusIsCommerce(val: TOutCKData): string;
begin
  if PriznToHexStr(val.Prizn) = '0x00008000' then
    Result := '1'
  else
    Result := '0';  
end;

function TdmData.VarToStrDefIsNull(val: TOutCKData; koef: Integer; def: string): string;
begin
  if PriznToHexStr(val.Prizn) = '0x00008000' then
    Result := def
  else
    try
      Result := IntToStr(Round(val.Value * koef));
    except
      Result := def;
    end;
end;

procedure TdmData.DataModuleDestroy(Sender: TObject);
begin
  ck2007.Free;
end;

initialization
  Randomize;
end.


