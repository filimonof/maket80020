unit frmMain_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxNavBarCollns, dxNavBarBase, ExtCtrls, dxNavBar, cxGraphics,
  cxControls, dxStatusBar, dxDockControl, dxDockPanel, dxBar, ActnList, cvProgress,
  XMLDoc, XMLIntf, ADODB, DB, uVar, DateUtils, VCLUnZip, VCLZip, ck7GetData,
  dxBarExtItems, XSLProd, xmldom, msxmldom, StrUtils, ComObj, StdCtrls,
  cxContainer, cxEdit, cxTextEdit;

type
  TfrmMain = class(TForm)
    dxStatusBar1: TdxStatusBar;
    dxDockingManager1: TdxDockingManager;
    dxDockPanel1: TdxDockPanel;
    dxNavBar2: TdxNavBar;
    dxNavBarGroup1: TdxNavBarGroup;
    dxNavBarGroup2: TdxNavBarGroup;
    dxNavBarGroup3: TdxNavBarGroup;
    dxNavBarItem1: TdxNavBarItem;
    dxNavBarItem2: TdxNavBarItem;
    dxNavBarItem3: TdxNavBarItem;
    dxNavBarItem4: TdxNavBarItem;
    dxNavBarItem5: TdxNavBarItem;
    dxNavBarItem6: TdxNavBarItem;
    dxDockSite1: TdxDockSite;
    dxDockSite3: TdxDockSite;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dxBarManager1: TdxBarManager;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSubItem4: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    alMain: TActionList;
    aOptionsMaket: TAction;
    aAbout: TAction;
    aExit: TAction;
    aLogList: TAction;
    dxDockSite2: TdxDockSite;
    dxDockSite4: TdxDockSite;
    aTestPost: TAction;
    aSendMaket: TAction;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarSubItem5: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    aOptionsSK: TAction;
    dxNavBar2Item1: TdxNavBarItem;
    aPreview: TAction;
    dxNavBar2Item2: TdxNavBarItem;
    dxBarButton9: TdxBarButton;
    aLoadMaketToDisk: TAction;
    dxBarSubItem6: TdxBarSubItem;
    dxBarButton10: TdxBarButton;
    dxBarStatic1: TdxBarStatic;
    aspParseM80020: TADOStoredProc;
    aspCreateMaket: TADOStoredProc;
    adsCreateMaket: TADODataSet;
    procedure FormCreate(Sender: TObject);
    procedure aExecute(Sender: TObject);
  private
    { Private declarations }
  public
    function ShowSimpleForm(AClassName: string): TForm;
    function isAssignedForm(AClassName: string): Boolean;
    function Name2Form(AClassName: string): TForm;
    function PrepareTestMail(isDialog: Boolean): string;
    function LoadMailSubscribe(isDialog: Boolean; isAuto: Boolean): string;
    function CreateMaket80020(dt: TDatetime; num: Integer; var fn: string; mail :recSMTPSendMail; prJob: TVProgress = nil): Boolean;
    procedure PrepareSendMaket();
    function EmailIsSubscribeCompany(email: string; var ssName: string; var ssFileFormat: string; var ssFileFormatOut: string; var ssSend: Boolean): Boolean;
    procedure SendMaket(dt1,dt2: TDateTime; isDialog: Boolean; prJob: TVProgress = nil);
    //procedure GetAscueOIK(var atiRes: TOutCKDataArray; field: string; dt: TDateTime);
    procedure LoadMaketToDisk();
    function ParseMaket80020(fn: string; isDialog: Boolean; Caption: string; isAuto: Boolean): string;
  end;

  TfrmClass = class of TForm;

var
  frmMain: TfrmMain;

  progr: TVProgress;

implementation

uses uUtils, uAdoUtils, dmData_u, dlgOptionsMaket_u, dlgGetDate_u,
  Math, frmLogList_u, dlgOptionsDB_u, dlgAbout_u, frmPreview_u, dlgProcess_u,
  SakMsg, uLog;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DecimalSeparator := ',';
  frmMain.Caption := NAME_PROGRAM + ' версия '+VERSION_PROGRAM;
  Application.Title :=  NAME_PROGRAM_SMALL;

  // создаем временную дирректорию
  if not DirectoryExists(sTempDir) then
    if not CreateDir(sTempDir) then
    begin
      Log_Error('Ошибка при создании временной директории.');
      if not ((ParamCount > 0) and (ParamStr(1) = 'auto')) then
        MessageDlg('Ошибка при создании временной директории.',mtError,[mbOk],0);
    end;    
end;

function TfrmMain.ShowSimpleForm(AClassName: string): TForm;
var
  F: TFormClass;
  i: integer;
  Form: TForm;
begin
  F := TFormClass(FindClass(AClassName));
  Form := nil;
  for i := 0 to MDIChildCount - 1 do
    if MDIChildren[i] is F then begin
      Form := MDIChildren[i];
      Break;
    end;
  if Assigned(Form) then
  begin
		Form.Show;
		if Form.WindowState = wsMinimized then
      Form.WindowState := wsNormal;
    Result := nil;
  end
  else
  begin
    if F.ClassParent = TForm then
    begin
      Form := TfrmClass(F).Create(Self);
      Form.BorderStyle := bsSizeable;
      Form.FormStyle := fsMDIChild;
      Form.Show;
    end else
    begin
      Form := F.Create(Application);
    end;
    Form.FormStyle := fsMDIChild;
    Form.Show;
    Result := Form;
  end;
end;

function TfrmMain.isAssignedForm(AClassName: string): Boolean;
var
  F: TFormClass;
  i: integer;
  Form: TForm;
begin
  F := TFormClass(FindClass(AClassName));
  Form := nil;
  for i := 0 to MDIChildCount - 1 do
    if MDIChildren[i] is F then begin
      Form := MDIChildren[i];
      Break;
    end;
  Result:=Assigned(Form);
end;

function TfrmMain.Name2Form(AClassName: string): TForm;
var
  F: TFormClass;
  i: integer;
  Form: TForm;
begin
  F := TFormClass(FindClass(AClassName));
  Form := nil;
  for i := 0 to MDIChildCount - 1 do
    if MDIChildren[i] is F then begin
      Form := MDIChildren[i];
      Break;
    end;
  Result:=Form;
end;

procedure TfrmMain.aExecute(Sender: TObject);
begin
  if TAction(Sender).Name = 'aExit' then
  begin
    if MessageDlg('Выйти из программы?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      Application.Terminate;
  end
  else if TAction(Sender).Name = 'aLogList' then
  begin
    ShowSimpleForm('TfrmLogList');    
  end
  else if TAction(Sender).Name = 'aTestPost' then
  begin
    LoadMailSubscribe(true, false);
    PrepareTestMail(true);
  end
  else if TAction(Sender).Name = 'aSendMaket' then
  begin
    PrepareSendMaket();
  end
  else if TAction(Sender).Name = 'aOptionsMaket' then
  begin
    DoOptionsMaket(Application.MainForm);
  end
  else if TAction(Sender).Name = 'aAbout' then
  begin
    DoAbout(Application.MainForm);
  end
  else if TAction(Sender).Name = 'aOptionsSK' then
  begin
    DoOptionsDB(Application.MainForm);
  end
  else if TAction(Sender).Name = 'aPreview' then
  begin
    ShowSimpleForm('TfrmPreview');  
  end
  else if TAction(Sender).Name = 'aLoadMaketToDisk' then
  begin
    LoadMaketToDisk();
  end
  else if TAction(Sender).Name = '' then
  begin
  end
end;

procedure TfrmMain.PrepareSendMaket();
var
  dt1,dt2: TDateTime;
  inp: Integer;
  aq: TAdoQuery;
  prJob: TVProgress;
begin
  //нужно вычеслить дату последней отправки
  aq:=SelectQuerySimple(dmData.adc80020,'select max(DateFile) as MaxDateFile from tblMaket80020Log');
  try
    if aq.FieldByName('MaxDateFile').IsNull then
      dt1 := Date()-2 //позавчарася (чтоб за вчарася отправять)
    else
      dt1 := aq.FieldByName('MaxDateFile').AsDateTime + 1;
  finally
    aq.Free;
  end;
  if dt1 >= Date() then
    dt1 := Date()-1;
  if DoGetDate(Application.MainForm,dt1,dt2,inp) then
  begin
    prJob:=TVProgress.Create(Application);
    try
      SendMaket(dt1,dt2,true,prJob);
    finally
      prJob.Free;
    end;  
  end;
end;

procedure TfrmMain.SendMaket(dt1,dt2: TDateTime; isDialog: Boolean; prJob: TVProgress = nil);
var
  dt: TDateTime;
  fn: string;
  filesatt: array of string;
  nums: array of Integer;  
  Number: Integer;
  i: Integer;
begin
  if prJob <> nil then
  begin
    prJob.Show(false);
    Application.ProcessMessages;
    prJob.Caption:='Отправка макета 80020';
    prJob.Max := Trunc(dt2 - dt1 + 1);
  end;
  Application.ProcessMessages;
  SetLength(filesatt, Trunc(dt2 - dt1) + 1);
  SetLength(nums, Trunc(dt2 - dt1) + 1);
  dt := dt1;
  while (dt <= dt2) do
  begin
    Number := StrToIntDef(dmData.GetParam(PARAM_LAST_NUM),1);
    nums[Trunc(dt - dt1)] := Number;
    dmData.SetParam(PARAM_LAST_NUM,IntToStr(Number+1));
    if CreateMaket80020(dt,Number,fn,m80020sendmail,prJob) then
    begin
      filesatt[Trunc(dt - dt1)]:=fn;
      if m80020sendmail.FileZiped then
      begin
        with TVCLZip.Create(self) do
        begin
          ZipName := ChangeFileExt(fn,'.zip');
          FilesList.Add(fn);
          Recurse := False;
          StorePaths := False;
          PackLevel := 9;
          if Zip > 0 then
          begin
            if FileExists(fn) then
              if DeleteFile(fn) then
                filesatt[Trunc(dt - dt1)]:=ZipName;
          end
          else
          begin
            if prJob <> nil then
              prJob.AddInfo('Ошибка создания архива ' + ZipName)
            else
              Log_Info('Ошибка создания архива ' + ZipName);
          end;
        end;//zip
      end
    end;
    if prJob <> nil then
      prJob.StepProgress();
    dt:=dt+1;
  end;

  if prJob <> nil then
    prJob.AddInfo('Отправка по почте.');
  if m80020sendmail.Active then
    if dmData.SendMailSMTP(m80020sendmail, filesatt, Trunc(dt2 - dt1 + 1)) then
    begin
      dt := dt1;
      while dt <= dt2 do
      begin
        ExecQuerySimple(dmData.adc80020,'insert into tblMaket80020Log (Status,DateFile,INNFile,NumberFile) values (1,'''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],dt)+''','+dmData.GetParam(PARAM_SENDER_INN)+','+IntToStr(Nums[Trunc(dt - dt1)])+')');
        dt := dt + 1;
      end;
      if isAssignedForm('TfrmLogList') then
        (Name2Form('TfrmLogList') as TfrmLogList).RefreshLog;
    end;
  if m80020sendmail.FileTmpDelete then
  begin
    if prJob <> nil then
      prJob.AddInfo('Удаление временных файлов.');
    for i:=0 to Trunc(dt2 - dt1) do
      if FileExists(filesatt[i]) then
        DeleteFile(filesatt[i]);
  end;
  SetLength(filesatt,0);
  filesatt:=nil;
end;

function TfrmMain.CreateMaket80020(dt: TDatetime; num: Integer; var fn: string; mail :recSMTPSendMail; prJob: TVProgress = nil): Boolean;
var
  xdoc: IXMLDocument;
  xMessage,xField,xArea,
  xmp, xPeriod, xValue: IXMLNode;
  aq_a,aq: TAdoQuery;
  i: Integer;
  sSenderINN, sSenderName: string;
  koef: Integer;

  addDay_SummerToWinter: Integer;

  tiInArea: TTI;
  atiRes: TOutCKDataArray;
begin
  try
    fn:='';
//  if not prJob.StepProgress() then Exit;

// <xml>
    xdoc := TXMLDocument.Create(nil);
    xdoc.Active := true;
    xdoc.Encoding := 'windows-1251';
    xdoc.Version := '1.0';

// <message>
    xMessage:=xdoc.AddChild('message');
    xMessage.Attributes['class']:='80020';
    xMessage.Attributes['version']:='2';
    xMessage.Attributes['number']:=num;
    
// <datetime>
    xField:=xMessage.AddChild('datetime');
    xField.AddChild('timestamp').NodeValue:=FormatDateTime('YYYYMMDDhhmmss',Now());
    xField.AddChild('daylightsavingtime').NodeValue:=DayLightSavingTime(dt);
    {daylightsavingtime :   1 летнее время,
                            0 зимнее,
                            2 сутки с зимнего на летнее и обратно}
    xField.AddChild('day').NodeValue:=FormatDateTime('YYYYMMDD',dt);
    
// <sender>
    sSenderINN := dmData.GetParam(PARAM_SENDER_INN);
    sSenderName := dmData.GetParam(PARAM_SENDER_NAME);
    xField:=xMessage.AddChild('sender');
    xField.AddChild('inn').NodeValue  := sSenderINN;
    xField.AddChild('name').NodeValue := sSenderName;
    if (Trim(sSenderINN)='') or (Trim(sSenderName)='') then
    begin
      if prJob <> nil then
        prJob.AddInfo('Неуказан отправитель <sender>.');
    end;

// <area>
    aq_a:=SelectQuerySimple(dmData.adc80020,'select * from tblMaket80020Area where [Enabled]=1');
    try
      if not aq_a.IsEmpty then
      begin
        aq_a.First;
        while not aq_a.Eof do
        begin
          xArea:=xMessage.AddChild('area');
          xArea.AddChild('inn').NodeValue:=aq_a.FieldByName('INN').AsString;
          xArea.AddChild('name').NodeValue:=aq_a.FieldByName('name').AsString;
// <perertok>
          aq:=SelectQuerySimple(dmData.adc80020,'select * from tblMaket80020ParamPoint where [Enabled]=1 and AreaID='+aq_a.FieldByName('ID').AsString);
          try
            if not aq.IsEmpty then
            begin
              aq.First;
              while not aq.Eof do
              begin
                xmp:=xArea.AddChild(aq.FieldByName('NamePoint').AsString);
                xmp.Attributes['name']:=aq.FieldByName('NameObj').AsString;
                if (Length(aq.FieldByName('code').AsString)>0) then
                  xmp.Attributes['code']:=aq.FieldByName('code').AsString;
                if (Length(aq.FieldByName('codefrom').AsString)>0) then
                  xmp.Attributes['codefrom']:=aq.FieldByName('codefrom').AsString;
                if (Length(aq.FieldByName('codeto').AsString)>0) then
                  xmp.Attributes['codeto']:=aq.FieldByName('codeto').AsString;
                if VarIsNull(aq.FieldByName('koef').AsVariant)  then
                  koef:=1
                else
                  koef:=aq.FieldByName('koef').AsInteger;




// данные брать либо из ск либо суммированием по таблицк планов

{
ALTER     PROCEDURE [dbo].[m80020_CreateMaket]
( @inn NVARCHAR(50),@dt DATETIME,@paramID INT, @error output)
output (select)
start end  summer SumStatus Value
0000	0100	0	0	0
0100	0200	0	0	2
0200	0300	0	0	0
0300	0400	0	0	0
0400	0500	0	0	0
0500	0600	0	0	0
0600	0700	0	0	0
0700	0800	0	0	0
0800	0900	0	0	0
0900	1000	0	0	0
1000	1100	0	0	0
1100	1200	0	0	0
1200	1300	0	0	0
1300	1400	0	0	0
1400	1500	0	0	0
1500	1600	0	0	0
1600	1700	0	0	0
1700	1800	0	0	0
1800	1900	0	0	0
1900	2000	0	0	0
2000	2100	0	0	0
2100	2200	0	0	0
2200	2300	0	0	0
2300	0000	0	0	0
}

                if aq.FieldByName('IsSK').AsInteger = INT_ENABLED then
                begin
                  //берём данные из СК-2003
                  tiInArea.id := aq.FieldByName('SK_TI').AsInteger;
                  tiInArea.cat := NumToCat( aq.FieldByName('SK_Arch').AsInteger );
                  atiRes := mServersCK[1].Pclass.GetArrayValueTI_Sync(tiInArea.id,tiInArea.cat,ckTI24,dt);

                  // если пеерход с зимнего времени на летнее то с 2 до 3 часов вставим 0
                  if (dayWinterTOSumer(YearOf(dt)) = dt) then
                  begin
                    SetLength(atiRes,24);
                    for i:=22 downto 2 do
                      atiRes[i+1] := atiRes[i];
                    atiRes[2].Value := 0;
                    atiRes[2].Prizn := 524288; //0x00080000 - замена: отчетной информацией
                  end;

                end
                else
                begin
                  if (daySumerTOWinter(YearOf(dt)) = dt) then
                    SetLength(atiRes,25) // при переводе ЛетоЗима добавляется лишний час
                  else
                    SetLength(atiRes,24);
                  for i:=0 to Length(atiRes)-1 do
                  begin
                    atiRes[i].TStamp := IncHour(dt,i);
                    atiRes[i].Prizn := 32768; //0x00008000 нет данных
                    atiRes[i].Value := 0;
                  end;
                  try try
                    //берём данные из своего хранилища путём суммирования по Плану Выполнения
                    // @inn     = aq.FieldByName('INN_from').AsString
                    // @dt      = dt
                    // @paramID = aq.FieldByName('id').AsInteger
                    adsCreateMaket.Close;
                    //adsCreateMaket.Parameters.ParamByName('@inn').DataType := ftString;
                    //adsCreateMaket.Parameters.ParamByName('@inn').Value := aq.FieldByName('INN_from').AsString;
                    adsCreateMaket.Parameters.ParamByName('@dt').DataType := ftDate;
                    adsCreateMaket.Parameters.ParamByName('@dt').Value := dt;
                    adsCreateMaket.Parameters.ParamByName('@paramID').DataType := ftInteger;
                    adsCreateMaket.Parameters.ParamByName('@paramID').Value := aq.FieldByName('id').AsInteger;
                    adsCreateMaket.Prepared := True;
                    adsCreateMaket.Open;// ExecProc;

                    if not adsCreateMaket.IsEmpty then
                    begin
                      adsCreateMaket.First;
                      while not adsCreateMaket.Eof do
                      begin
                        i := StrToInt(System.Copy(adsCreateMaket.FieldByName('start').AsString,1,2));
                        if (false  {daySumerTOWinter(YearOf(dt)) = dt}) then // если перевод времени ЛетоЗима
                        begin
                          if (adsCreateMaket.FieldByName('summer').AsInteger = 0) then
                            i := i + 1;
                        end;
                        atiRes[i].Value := adsCreateMaket.FieldByName('Value').AsInteger;
                        if adsCreateMaket.FieldByName('SumStatus').AsInteger = 0 then
                          atiRes[i].Prizn :=  268435456; // 0x 10 000 000 - источник: данные АСКУЭ
                        adsCreateMaket.Next;
                      end;
                    end;
                  except
                  //малчим
                  end;
                  finally
                    adsCreateMaket.Close;
                  end;
                end;       

                if prJob <> nil then
                  prJob.AddInfo(aq.FieldByName('NameObj').AsString);

                addDay_SummerToWinter := 0;  // нужен для смещения в массиве
                for i:=0 to 23 do
                begin
// <period>
                  xPeriod:=xmp.AddChild('period');
                  { формат времени "ччмм" }
                  xPeriod.Attributes['start']:=IntToStrLen(i,2)+'00';
                  if i <> 23 then
                    xPeriod.Attributes['end']:=IntToStrLen(i+1,2)+'00'
                  else
                    xPeriod.Attributes['end']:='0000';

                  if (false {dayWinterTOSumer(YearOf(dt)) = dt}) and (i>2) then
                    xPeriod.Attributes['summer']:='1';

                  if (false {daySumerTOWinter(YearOf(dt)) = dt}) and (i<2) then
                    xPeriod.Attributes['summer']:='1';

                  if (false {daySumerTOWinter(YearOf(dt)) = dt}) and (i=2) then
                  begin
                    xPeriod.Attributes['summer']:='1';
                    xValue:=xPeriod.AddChild('value');
                    xValue.Attributes['status']:='0';
                    xValue.NodeValue := dmData.VarToStrDefIsNull(atiRes[i],koef,NULLTODEF);
                    // дублируем
                    addDay_SummerToWinter := 1;
                    xPeriod:=xmp.AddChild('period');
                    xPeriod.Attributes['start']:=IntToStrLen(i,2)+'00';
                    xPeriod.Attributes['end']:=IntToStrLen(i+1,2)+'00'
                  end;
                 { при переходе с зимнего на летнее число пеерходов тоже;
                 при переходе с ЛЕТНЕГО на ЗИМНЕЕ число переходов увеличивается на 1,
                 при этом daylightsavingtime=2 а у периодов, относящихся к летнему времени атрибут summer=1}

// <value>
                  xValue:=xPeriod.AddChild('value');
{
	status CDATA #IMPLIED
	errofmeasuring CDATA #IMPLIED
	param1 CDATA #IMPLIED
	param2 CDATA #IMPLIED
	param3 CDATA #IMPLIED
	extendedstatus CDATA #IMPLIED
  Статус 0 означает, что передаваемая информация имеет статус коммерческой.
  В этом случае атрибут статус может отсутствовать.
  Значение поля status 1 означает, что данную информацию НЕЛЬЗЯ использовать в коммерческих расчетах.
 	Содержимое атрибута errofmeasuring элемента <value> содержит абсолютную погрешность результатов измерений.
  Обязательность передачи атрибута определяется Актом соответствия АИСС техническим требованиям  ОРЭ.
	Атрибуты param1, param2, param3 содержат дополнительную информацию, содержание которой определяется значением
  атрибута extendedstatus.
	Атрибут extendedstatus содержит расширенный статус передаваемой информации.
  В частности, в случае замещения результатов измерений в точке измерения на значение
  результатов измерений в группе точек измерений
  (в случае включения присоединения через обходной выключатель),  значение атрибута
  exstendedstatus равно 1114, а значение атрибута param1 принимает значение равное коду,
  присвоенному НП "АТС" группе точек измерений.
}
                  xValue.Attributes['status']:=dmData.StatusIsCommerce(atiRes[ i+addDay_SummerToWinter ]); //1 если нет данных иначе 0
                  xValue.NodeValue := dmData.VarToStrDefIsNull(atiRes[ i+addDay_SummerToWinter ],koef,NULLTODEF);
                end;


                aq.Next;
                atiRes := nil;
              end;
            end
            else
            begin
              if prJob <> nil then
                prJob.AddInfo('Нет точек для отправки')
              else
                Log_Error('Нет точек для отправки');
            end;
          finally
            aq.Free;
          end;
          aq_a.Next;
        end;
      end
      else
      begin
        if prJob <> nil then
          prJob.AddInfo('Нет зон для отправки')
        else
          Log_Error('Нет зон для отправки');
      end;
    finally
      aq_a.Free;
    end;
    fn:=mail.FileFormat;
    fn:=StringReplace(fn,'<%INN%>',sSenderINN,[rfReplaceAll, rfIgnoreCase]);
    fn:=StringReplace(fn,'<%date%>',FormatDateTime('YYYYMMDD',dt),[rfReplaceAll, rfIgnoreCase]);
    fn:=StringReplace(fn,'<%number%>',IntToStr(num),[rfReplaceAll, rfIgnoreCase]);
    fn:=sTempDir+fn;
    xdoc.SaveToFile(fn);
    Result := true;
  finally
     //xdoc.Free; делать ненадо это интерфейс
     xdoc := nil;
     atiRes := nil;
  end;
end;

  procedure TestEmailCount(var count: Integer);
  var
    i,f: Integer;
    msg: TSakMsg;
  begin
    count := 0;
    if dmData.SakMsgList1.count > 0 then
    begin
      for i:=0 to dmData.SakMsgList1.count-1 do
      begin
        msg := dmData.SakMsgList1.Items[i];
        if (m80020getmail.IsEmailFrom and IncludeArray(m80020getmail.EmailFrom,msg.ReturnPath)) or (not m80020getmail.IsEmailFrom) then
        begin
          if msg.AttachedFiles.Count > 0 then
          begin
            for f := 0 to msg.AttachedFiles.Count-1 do
              if IsFileMasking(msg.AttachedFiles[f].FileName,m80020getmail.FileFormat) or IsFileMasking(msg.AttachedFiles[f].FileName,ChangeFileExt(m80020getmail.FileFormat,'.zip')) then
                Inc(count);                                                                                                                                 
          end;
        end;
      end;
    end;
  end;

  function DeleteMessageTOID(MesId: string; isDialog: Boolean): string;
  var
    i: Integer;
    saka: TSakMsg;
  begin
    Result := '';
    if isDialog then
      ShowProcessCancel(Application.MainForm,'Удаление загруженного письма ...',true,3,false);
    with dmData.SakPOP1 do
    try
      Host := m80020getmail.POPserver;
      Port := m80020getmail.POPport;
      UserId := m80020getmail.Login;
      UserPasswd := m80020getmail.Password;
      Connect;
      if POPError then
      begin
        Result := 'Ошибка соединения. Нет связи с почтовым сервером('+m80020getmail.POPserver+').';
        Exit;
      end;
      if not Login then
      begin
        Result := 'Нет доступа. Возможно введен неправильный пароль.';
        Exit;
      end;
      Init;      
      saka := TSakMsg.Create(nil);
      try
        for i:=dmData.SakPOP1.MsgsCount downto 1 do
        begin
          dmData.SakPOP1.RetrieveMessage(i,saka);
          if saka.MessageId = MesId then
          begin
            dmData.SakPOP1.DeleteMessage(i);
            Exit;
          end;
        end;
      finally
        saka.Free;
      end;
    finally
      if dmData.SakPOP1.Connected then
        dmData.SakPOP1.Disconnect;
      if isDialog then
        HideProcessCancel;
    end;
  end;
  
function TfrmMain.PrepareTestMail(isDialog: Boolean): string;
var
  b, bMsgIsDel, bLoad, bEmail: Boolean;
  i, iCurData, iMaxCountData, f: Integer;
  er: string;
  msg: TSakMsg;
  fn: string;

  function Load80021ToBase(fn,caption: string; isDialog: Boolean): Boolean;
  var
    xdoc: IXMLDocument;
    xroot,xfield: IXMLNode;
    xmlfn, xmlfile: string;
    status: Integer;
    INNFile,DateFile,NumberFile,s :string;
  begin
{
  <?xml version="1.0" encoding="windows-1251" ?>
- <message class="80021" version="1" id="13">
- <email>
  <id>SAK.2006.03.09.opdncraelqknpdnl@a.b.c</id>
  <received>20060309125818</received>
  <from>fvv@rdurm.odusv.so-cdu.ru</from>
  <subject>80020 лНПДНБЯЙНЕ пдс</subject>
  </email>
- <file zip="0">
  <name>80020_600004_20060308_38.xml</name>     по этому параметру узнаем про запись
  <date>20060308</date>
  </file>
  <reply status="0" />
  </message>
}

{
 inn date nomer
 menyaem status
}


    try
      if isDialog then
        ShowProcessCancel(Application.MainForm,Caption,false,dmData.SakPOP1.RetrieveProgressStep,false);

      if not FileExists(fn) then
      begin
        Result := false;
        Exit;
      end;
      xdoc := TXMLDocument.Create(nil);
      with xdoc do
      begin
        xdoc.FileName := fn;
        Active := true;
        xroot := xdoc.DocumentElement;

        if (xroot.Attributes['class']='80021') and (xroot.Attributes['version']='1') then
        begin
          // <file>  : <name>
          xfield := xroot.ChildNodes['file'];
          xmlfn:=' ';
          if xfield.ChildNodes['name'].IsTextElement then
            xmlfn :=xfield.ChildNodes['name'].Text;
          // <reply>
          xfield := xroot.ChildNodes['reply'];
//          status := -1;
          status := xfield.Attributes['status'];

          xmlfile := XML.Text;

{
    пересчет status
 в файле xml
0 - файл принят и успешно обработан системой,
1 - файл принят и обработан, по некоторым каналам есть некоммерческая информация,
2 - файл не принят, некоторые измерительные каналы не обработаны из-за их отсутствия в базе данных,
3 - файл не принят, имеются  ошибки формата,
4 - файл не соответствует стандарту xml.
 в логе
0 - хрень какаято
1 - отослано
2 - возврат ОК
3 - возврат ОК, но есть некомерческая инфа
4 - возврат ошибки
}
          case status of
           -1: status:=0;       // хрень какаято
            0: status:=2;       // возврат ОК
            1: status:=3;       // возврат ОК, но есть некомерческая инфа
            2,3,4: status:=4;    // ошибка
            else status:=0;       // хрень какаято
          end;

          xmlfn:=StringReplace(xmlfn,' ','_',[rfReplaceAll, rfIgnoreCase]);
          //80020_600004_20060308_38
          System.Delete(xmlfn,1,Pos('_',xmlfn));
          INNFile := Copy(xmlfn,1,Pos('_',xmlfn)-1);
          System.Delete(xmlfn,1,Pos('_',xmlfn));
          DateFile := Copy(xmlfn,1,Pos('_',xmlfn)-1);
          System.Delete(xmlfn,1,Pos('_',xmlfn));
          NumberFile :=Copy(xmlfn,1,Pos('.',xmlfn)-1);
          System.Insert('.',DateFile,7);
          System.Insert('.',DateFile,5);
          //2006.03.08
          s:=DateFile;
          DateFile := s[9]+s[10]+s[8]+s[6]+s[7]+s[5]+s[1]+s[2]+s[3]+s[4];
          ExecQuerySimple(dmData.adc80020,'update tblMaket80020Log set Status= '+IntToStr(status)+'   where  INNFile='''+INNFile+''' and DateFile='''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],(StrToDate(DateFile)))+''' and NumberFile='+NumberFile+' ');
          ExecQuerySimple(dmData.adc80020,'update tblMaket80020Log set  Comment = '''+xmlfile+'''  where  INNFile='''+INNFile+''' and DateFile='''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],(StrToDate(DateFile)))+''' and NumberFile='+NumberFile+' ');
        end
        else
          MessageDlg('Не совпал номер макета или версия ('+String(xroot.Attributes['class'])+','+string(xroot.Attributes['version'])+')',mtInformation,[mbOk],0);
      end;
    finally
      Result := true;
      xdoc.Active := False;
      xdoc := nil;
      if isDialog then
        HideProcessCancel;
    end
  end;

begin
  b := false;
  if m80020getmail.Active then
  try
    if isDialog then
      ShowProcessCancel(Application.MainForm,'Проверка почтового ящика (уведомление) ...',true,dmData.SakPOP1.RetrieveProgressStep,false);
    with dmData.SakPOP1 do
    begin
      Host := m80020getmail.POPserver;
      Port := m80020getmail.POPport;
      UserId := m80020getmail.Login;
      UserPasswd := m80020getmail.Password;
      Connect;
      if POPError then
      begin
        Result := 'Ошибка соединения. Нет связи с почтовым сервером('+m80020getmail.POPserver+').';
        Exit;
      end;
      if not Login then
      begin
        Result := 'Нет доступа. Возможно введен неправильный пароль.';
        Exit;
      end;
      Init;
      retrieveAllMessages(dmData.SakMsgList1);
      b := true;       
    end;
    TestEmailCount(iMaxCountData);
  finally
    dmData.SakPOP1.Disconnect;
    if isDialog then
      HideProcessCancel;
  end
  else
  begin
    if isDialog then
      MessageDlg('Проверка почтового ящика отключена в настройках.',mtInformation,[mbOk],0);
    Exit;
  end;

  bLoad    := false;
  bEmail   := false;
  if b then
  try
    iCurData := 0;

    if dmData.SakMsgList1.count > 0 then
    begin
      for i:=0 to dmData.SakMsgList1.count-1 do
      begin
        msg := dmData.SakMsgList1.Items[i];
        if (m80020getmail.IsEmailFrom and IncludeArray(m80020getmail.EmailFrom,msg.ReturnPath)) or (not m80020getmail.IsEmailFrom) then
        begin
          bMsgIsDel := true;        
          if msg.AttachedFiles.Count > 0 then
          begin
            for f := 0 to msg.AttachedFiles.Count-1 do
              if IsFileMasking(msg.AttachedFiles[f].FileName,m80020getmail.FileFormat) or IsFileMasking(msg.AttachedFiles[f].FileName,ChangeFileExt(m80020getmail.FileFormat,'.zip')) then
              begin
                msg.AttachedFiles[f].SaveToFile(sTempDir+msg.AttachedFiles[f].FileName);
                fn := sTempDir+msg.AttachedFiles[f].FileName;
                if ExtractFileExt(fn)='.zip' then
                begin
                  //разархивиорвать
                  with TVCLUnZip.Create(Self) do
                  try
                    ZipName:= fn;
                    ReadZip;
                    DestDir:= sTempDir; // Путь для разархивации
                    RecreateDirs:=False;
                    RetainAttributes:=True;
                    ReplaceReadOnly := true;
                    OverwriteMode := Always;
                    FilesList.Clear;
                    FilesList.Add('*.xml'); // Добавляем файлы
                    if UnZip > 0 then
                    begin
                      if FileExists(ChangeFileExt(fn,'.xml')) then
                      begin
                        if m80020getmail.FileTmpDelete then
                          DeleteFile(fn);
                        fn := ChangeFileExt(fn,'.xml');
                      end  
                      else
                      begin
                        if isDialog then
                          MessageDlg('Не найден файл '+ChangeFileExt(fn,'.xml')+' после разархивации ответа.',mtError,[mbOk],0)
                        else
                          Log_Error('Не найден файл '+ChangeFileExt(fn,'.xml')+' после разархивации ответа.');
                      end;
                    end
                    else
                    begin
                      if isDialog then
                        MessageDlg('Ошибка при разархивации файла '+fn,mtError,[mbOk],0)
                      else
                        Log_Error('Ошибка при разархивации файла '+fn);
                    end;
                  finally
                    Free;
                  end;
                end;
                if FileExists(fn) then
                begin
                  bEmail := true;
                  Inc(iCurData);

                  if not Load80021ToBase(fn,Format('Обработка макета ( %d файл из %d )',[iCurData,iMaxCountData]),isDialog) then
                  begin
                    bMsgIsDel := false;
                    Break;
                  end;

                  if m80020getmail.FileTmpDelete then
                    DeleteFile(fn);

                  if isAssignedForm('TfrmLogList') then
                    (Name2Form('TfrmLogList') as TfrmLogList).RefreshLog;

                end
                else
                begin
                  bMsgIsDel := false;
                  if isDialog then
                    MessageDlg('Ошибка при чтении файла. Возможно диск полон или нет доступа.',mtError,[mbOk],0)
                  else
                    Log_Error('Ошибка при чтении файла. Возможно диск полон или нет доступа.');
                end;
              end
              else
                bMsgIsDel := false;
          end
          else
            bMsgIsDel := false;
            
          if bMsgIsDel and (m80020getmail.IsDeleteLoadedEmail) then
          begin
            bMsgIsDel := false;
            er:=DeleteMessageTOID(msg.MessageId,isDialog);
            if er<>'' then
            begin
              if isDialog then
                MessageDlg('Ошибка при удалении загруженого письма: '+er,mtError,[mbOk],0)
              else
                Log_Error('Ошибка при удалении загруженого письма: '+er);
            end;
          end;
        end;
      end;
    end;
    bLoad:=true;
  finally
    dmData.SakPOP1.Disconnect;
    dmData.SakMsgList1.Clear;
{ это придётся выкинуть
    if isDialog then
    begin
      if not bEmail then
        MessageDlg('Проверка почты прошла успешно. Нет файлов для загрузки.',mtInformation,[mbOk],0)
      else
        if bLoad then
          MessageDlg('Загрузка прошла успешно.',mtInformation,[mbOk],0)
    end;
}
  end;
end;

function TfrmMain.LoadMailSubscribe(isDialog: Boolean; isAuto: Boolean): string;
var
  b, bMsgIsDel, bLoad, bEmail: Boolean;
  i, iCurData, iMaxCountData, f: Integer;
  er: string;
  msg: TSakMsg;
  fn: string;
  err_load: string;

  ssName, ssFileFormat, ssFileFormatOut: string;
  ssSend: Boolean;

begin
  b := false;
  if m80020subscribe.Active then
  try
    if isDialog then
      ShowProcessCancel(Application.MainForm,'Проверка почтового ящика (подписка) ...',true,dmData.SakPOP1.RetrieveProgressStep,false);
    with dmData.SakPOP1 do
    begin
      Host := m80020getmail.POPserver;
      Port := m80020getmail.POPport;
      UserId := m80020getmail.Login;
      UserPasswd := m80020getmail.Password;
      Connect;
      if POPError then
      begin
        Result := 'Ошибка соединения. Нет связи с почтовым сервером('+m80020getmail.POPserver+').';
        Exit;
      end;
      if not Login then
      begin
        Result := 'Нет доступа. Возможно введен неправильный пароль.';
        Exit;
      end;
      Init;
      retrieveAllMessages(dmData.SakMsgList1);
      b := true;       
    end;
    TestEmailCount(iMaxCountData);
  finally
    dmData.SakPOP1.Disconnect;
    if isDialog then
      HideProcessCancel;
  end
  else
  begin
    if isDialog then
      MessageDlg('Проверка почтового ящика отключена в настройках.',mtInformation,[mbOk],0);
    Exit;
  end;

  bLoad    := false;
  bEmail   := false;
  if b then
  try
    iCurData := 0;

    if dmData.SakMsgList1.count > 0 then
    begin
      for i:=0 to dmData.SakMsgList1.count-1 do
      begin
        msg := dmData.SakMsgList1.Items[i];
//        if IncludeArray(m80020getmail.EmailFrom,msg.ReturnPath) then
        ssName:='';
        ssFileFormat:='';
        ssFileFormatOut:='';
        ssSend := false;
        if EmailIsSubscribeCompany(msg.ReturnPath, ssName, ssFileFormat, ssFileFormatOut, ssSend) then
        begin
          bMsgIsDel := true;
          if msg.AttachedFiles.Count > 0 then
          begin
            for f := 0 to msg.AttachedFiles.Count-1 do
              //if IsFileMasking(msg.AttachedFiles[f].FileName,m80020getmail.FileFormat) or IsFileMasking(msg.AttachedFiles[f].FileName,ChangeFileExt(m80020getmail.FileFormat,'.zip')) then
              if IsFileMasking(msg.AttachedFiles[f].FileName,ssFileFormat) or IsFileMasking(msg.AttachedFiles[f].FileName,ChangeFileExt(ssFileFormat,'.zip')) then
              begin
                msg.AttachedFiles[f].SaveToFile(sTempDir+msg.AttachedFiles[f].FileName);
                fn := sTempDir+msg.AttachedFiles[f].FileName;
                if ExtractFileExt(fn)='.zip' then
                begin
                  //разархивиорвать
                  with TVCLUnZip.Create(Self) do
                  try
                    ZipName:= fn;
                    ReadZip;
                    DestDir:= sTempDir; // Путь для разархивации
                    RecreateDirs:=False;
                    RetainAttributes:=True;
                    ReplaceReadOnly := true;
                    OverwriteMode := Always;
                    FilesList.Clear;
                    FilesList.Add('*.xml'); // Добавляем файлы
                    if UnZip > 0 then
                    begin
                      if FileExists(ChangeFileExt(fn,'.xml')) then
                      begin
                        if m80020subscribe.FileTmpDelete then
                          DeleteFile(fn);
                        fn := ChangeFileExt(fn,'.xml');
                      end
                      else
                      begin
                        if isDialog then
                          MessageDlg('Не найден файл '+ChangeFileExt(fn,'.xml')+' после разархивации ответа.',mtError,[mbOk],0)
                        else
                          Log_Error('Не найден файл '+ChangeFileExt(fn,'.xml')+' после разархивации ответа.');
                      end;
                    end
                    else
                    begin
                      if isDialog then
                        MessageDlg('Ошибка при разархивации файла '+fn,mtError,[mbOk],0)
                      else
                        Log_Error('Ошибка при разархивации файла '+fn);
                    end;
                  finally
                    Free;
                  end;
                end;
                if FileExists(fn) then
                begin
                  bEmail := true;
                  Inc(iCurData);

                  err_load := ParseMaket80020(fn, false, Format('Разбор макета %d из %d',[iCurData, iMaxCountData]), isAuto);
                  if err_load <> '' then
                  begin
                    if isDialog then
                    begin
                      MessageDlg('Ошибка при добавлении макета в базу:'#13#10+err_load,mtError,[mbOk],0);
                      Application.ProcessMessages;
                    end
                    else
                      Log_Error('Ошибка при добавлении макета в базу:'+err_load);


//todo: отсылать уведомление что ошибка при загрузке

                    bMsgIsDel := false;
                    Break;
                  end;

//todo: отсылать уведомление что всё ок

                  if m80020subscribe.FileTmpDelete then
                    DeleteFile(fn);

                  if isAssignedForm('TfrmLogList') then
                    (Name2Form('TfrmLogList') as TfrmLogList).RefreshLog;

                end
                else
                begin
                  bMsgIsDel := false;
                  if isDialog then
                  begin
                    MessageDlg('Ошибка при чтении файла. Возможно диск полон или нет доступа.',mtError,[mbOk],0);
                    Application.ProcessMessages;
                  end
                  else
                    Log_Error('Ошибка при чтении файла. Возможно диск полон или нет доступа.');
                end;
              end
              else
                bMsgIsDel := false;
          end
          else
            bMsgIsDel := false;

          if bMsgIsDel and (m80020subscribe.IsDeleteLoadedEmail) then
          begin
            bMsgIsDel := false;
            er:=DeleteMessageTOID(msg.MessageId,isDialog);
            if er<>'' then
            begin
              if isDialog then
                MessageDlg('Ошибка при удалении загруженого письма: '+er,mtError,[mbOk],0)
              else
                Log_Error('Ошибка при удалении загруженого письма: '+er);
            end;
          end; //удалено письмо
        end; //если пиьсьмо это, тюею наше
      end; //цикл по количеству писем в почте
    end; //если количество писем в почте больше нуля
    bLoad:=true;
  finally
    dmData.SakPOP1.Disconnect;
    dmData.SakMsgList1.Clear;
{ это придётся выкинуть
    if isDialog then
    begin
      if not bEmail then
        MessageDlg('Проверка почты прошла успешно. Нет файлов для загрузки.',mtInformation,[mbOk],0)
      else
        if bLoad then
          MessageDlg('Загрузка прошла успешно.',mtInformation,[mbOk],0)
    end;
}
  end;
end;

function TfrmMain.EmailIsSubscribeCompany(email: string; var ssName: string; var ssFileFormat: string; var ssFileFormatOut: string; var ssSend: Boolean): Boolean;
var
  aq: TADOQuery;
begin
  Result := false;
  aq:=SelectQuerySimple(dmData.adc80020,'select * from tblMaket80020SubscribeCompany where [Enabled]=1');
  try
    if aq.IsEmpty then
    begin
      Result := false;
      Exit;
    end;
    aq.First;
    while not aq.Eof do
    begin
      if ((not aq.FieldByName('Email').IsNull)
        and (Length(aq.FieldByName('Email').AsString)>0)
        and IsFileMasking(email,aq.FieldByName('Email').AsString)) then
      begin
        ssName := aq.FieldByName('Name').AsString;
        ssFileFormat := aq.FieldByName('FormatFileMaket').AsString;
        if aq.FieldByName('SendNotification').AsInteger = 1 then
          ssSend := true
        else
          ssSend := false;
        ssFileFormatOut := aq.FieldByName('FormatFileNotification').AsString;
        Result := true;
        Exit;
      end;
      aq.Next;
    end;
  finally
    aq.Free;
  end;
end;

procedure TfrmMain.LoadMaketToDisk();
var
  OpenDialog1: TOpenDialog;
  i: Integer;
  err: string;
begin
  OpenDialog1 := TOpenDialog.Create(nil);
  try
    OpenDialog1.Title := 'Выберите макеты, которые нужно загрузить в базу';
    OpenDialog1.DefaultExt := 'xml';
    OpenDialog1.Options := [ofAllowMultiSelect, ofFileMustExist, ofReadOnly];
    OpenDialog1.Filter := 'Maket 80020|80020_*.xml';
    if OpenDialog1.Execute then
    begin
      for i:=0 to OpenDialog1.Files.Count-1 do
      begin
        err := '';
        err := ParseMaket80020(OpenDialog1.Files[i], true, Format('Разбор макета %d из %d',[i+1, OpenDialog1.Files.Count]), false);
        if err <> '' then ShowMessage(err);
      end;
    end;
    if isAssignedForm('TfrmLogList') then
      (Name2Form('TfrmLogList') as TfrmLogList).RefreshLog;
  finally
    OpenDialog1.Free;
  end;
end;

function TfrmMain.ParseMaket80020(fn: string; isDialog: Boolean; Caption: string; isAuto: Boolean): string;
var
  status, INNFile, DateFile, NumberFile, s: string;

  procedure ReplaMaket(Filename: string; oldstring: string; newstring: string);
  var
    f: file;
    l: Longint;
    s: string;
  begin
    s := oldstring;
    AssignFile(f, Filename);
    Reset(f, 1);
    //for l := 0 to FileSize(f) - Length(oldstring) - 1 do
    //можно ограничить тлько поиск в начале 1000 символов
    for l := 0 to 1000 do
    begin
      //Application.ProcessMessages;
      Seek(f, l);
      BlockRead(f, oldstring[1], Length(oldstring));
      if oldstring = s then
      begin
        Seek(f, l);
        BlockWrite(f, newstring[1], Length(newstring));
      end;
    end;
    CloseFile(f);
  end;

begin
{
  <?xml version="1.0" encoding="windows-1251"?>
  <message class="80020" version="2" number="1056">
  <datetime>
    <timestamp>20080110040922</timestamp>
    <daylightsavingtime>0</daylightsavingtime>
    <day>20080109</day>
  </datetime>
  <sender>
    <name>Мордовский филиал ОАО "ТГК-6"</name>
    <inn>5257072937</inn>
  </sender>
  <area timezone="1">
    <name>Мордовский филиал ОАО "ТГК-6"</name>
    <inn>1328903069</inn>
    <measuringpoint code="131150001113003" name="ТГ-4">
      <measuringchannel code="02" desc="счетчик, акт. отдача">
        <period start="0000" end="0030">
          <value>48845</value>
        </period>
        <period start="0030" end="0100">
          <value>48518</value>

}
  try try
    Result := '';
    if isDialog then
      ShowProcessCancel(Application.MainForm,Caption,false,dmData.SakPOP1.RetrieveProgressStep,false);
{
uses MidasLib
или
Regsvr32 C:\Windows\System\midas.dll
}

    {
      нужно в макете вместо
      <?xml version="1.0" encoding="windows-1251"?>
      поставить
      <?xml version="1.0"?>
    }
    ReplaMaket(fn,'encoding="windows-1251"'
                 ,'                       ');
    aspParseM80020.Parameters.ParamByName('@maket').LoadFromFile(fn, ftString);
    aspParseM80020.Parameters.ParamByName('@filename').DataType := ftString;
    aspParseM80020.Parameters.ParamByName('@filename').Value := ExtractFileName(fn);
    aspParseM80020.Parameters.ParamByName('@error').Value := '';
    aspParseM80020.Prepared := True;
    aspParseM80020.ExecProc;
    if not VarIsNull(aspParseM80020.Parameters.ParamByName('@error').Value)  then
      Result := aspParseM80020.Parameters.ParamByName('@error').Value;
    aspParseM80020.Close;

    // заносим информацию о событии в лог файл
    fn:=StringReplace(ExtractFileName(fn),' ','_',[rfReplaceAll, rfIgnoreCase]);
    //80020_600004_20060308_38
    System.Delete(fn,1,Pos('_',fn));
    INNFile := Copy(fn,1,Pos('_',fn)-1);
    System.Delete(fn,1,Pos('_',fn));
    DateFile := Copy(fn,1,Pos('_',fn)-1);
    System.Delete(fn,1,Pos('_',fn));
    if Pos('_',fn) > 0 then
      NumberFile :=Copy(fn,1,Pos('_',fn)-1)
    else
      NumberFile :=Copy(fn,1,Pos('.',fn)-1);
    System.Insert('.',DateFile,7);
    System.Insert('.',DateFile,5);
    //2006.03.08
    s := DateFile;
    DateFile := s[9]+s[10]+s[8]+s[6]+s[7]+s[5]+s[1]+s[2]+s[3]+s[4];
{
 пересчет status  в файле xml
0 - файл принят и успешно обработан системой,
1 - файл принят и обработан, по некоторым каналам есть некоммерческая информация,
2 - файл не принят, некоторые измерительные каналы не обработаны из-за их отсутствия в базе данных,
3 - файл не принят, имеются  ошибки формата,
4 - файл не соответствует стандарту xml.
 в логе
0 - хрень какаято
1 - отослано
2 - возврат ОК
3 - возврат ОК, но есть некомерческая инфа
4 - возврат ошибки
5 - файл успешно принят
6 - файл успешно принят но есть некомерческая инфа
7 - файл не принят, имеются ошибки формата
8 - файл успешно принят ручной ввод
9 - файл успешно принят но есть некомерческая инфа ручной ввод
10 - файл не принят, имеются ошибки формата ручной ввод
}
    if (Result = '') and (isAuto) then status:='5'
    else if (Result <> '') and (isAuto) then status:='7'
    else if (Result = '') and (not isAuto) then status:='8'
    else status := '10'; 
    ExecQuerySimple(dmData.adc80020,'insert into tblMaket80020Log (Status,DateFile,INNFile,NumberFile,Comment) values ('+status+','''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],(StrToDate(DateFile)))+''','+INNFile+','+NumberFile+','''+Result+''')');
    
  except
    on E: Exception do
    begin
      Result := Result +  #10#13 + 'Ошибка: ' + E.Message;
    end;
  end;
  finally
    if isDialog then
      HideProcessCancel;
  end
end;

initialization
  sPath := ExtractFilePath(ParamStr(0));
  sTempDir := sPath + sTempDir + '\';
  sDirReports := sPath + sDirReports + '\';
//  mServersAccess[1].NameDB := sPath + mServersAccess[1].NameDB;
end.
