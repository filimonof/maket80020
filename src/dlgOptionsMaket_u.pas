unit dlgOptionsMaket_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLabel, cxControls, cxContainer, cxEdit, cxImage, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, XPMan, cxPC,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, ADODB, cxCheckBox, cxDropDownEdit, cxGroupBox, cxTextEdit,
  cxDBEdit, cxRadioGroup, cxMaskEdit, cxSpinEdit, cxButtonEdit, ADOint, SakMsg;

type
  TdlgOptionsMaket = class(TForm)
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    Bevel1: TBevel;
    cxButton1: TcxButton;
    XPManifest1: TXPManifest;
    adsArea: TADODataSet;
    adsPeretok: TADODataSet;
    dsArea: TDataSource;
    dsPeretok: TDataSource;
    adsAreaid: TAutoIncField;
    adsAreaName: TWideStringField;
    adsAreaINN: TWideStringField;
    adsPeretokid: TAutoIncField;
    adsPeretokAreaID: TIntegerField;
    adsPeretokcode: TWideStringField;
    adsPeretokcodefrom: TWideStringField;
    adsPeretokcodeto: TWideStringField;
    adsPeretokNameObj: TWideStringField;
    adsPeretokNameParam: TWideStringField;
    adsPeretokNamePoint: TWideStringField;
    adsPeretokSK_TI: TIntegerField;
    adsPeretokSK_Arch: TIntegerField;
    adsPeretokEnabled: TIntegerField;
    adsAreaEnabled: TIntegerField;
    adsPeretokkoef: TIntegerField;
    adsSubscribe: TADODataSet;
    dsSubscribe: TDataSource;
    adsSubscribeid: TAutoIncField;
    adsSubscribeName: TWideStringField;
    adsSubscribeEnabled: TIntegerField;
    adsSubscribeEmail: TWideStringField;
    adsSubscribeFormatFileMaket: TWideStringField;
    adsSubscribeSendNotification: TIntegerField;
    adsSubscribeFormatFileNotification: TWideStringField;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    btnSenderCancel: TcxButton;
    btnSenderPost: TcxButton;
    cxTextEdit4: TcxTextEdit;
    cxTextEdit5: TcxTextEdit;
    cxTabSheet2: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Enabled: TcxGridDBColumn;
    cxGrid1DBTableView1Name: TcxGridDBColumn;
    cxGrid1DBTableView1INN: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2DBTableView1Enabled: TcxGridDBColumn;
    cxGrid2DBTableView1code: TcxGridDBColumn;
    cxGrid2DBTableView1codefrom: TcxGridDBColumn;
    cxGrid2DBTableView1codeto: TcxGridDBColumn;
    cxGrid2DBTableView1NameObj: TcxGridDBColumn;
    cxGrid2DBTableView1NameParam: TcxGridDBColumn;
    cxGrid2DBTableView1NamePoint: TcxGridDBColumn;
    cxGrid2DBTableView1SK_TI: TcxGridDBColumn;
    cxGrid2DBTableView1SK_Arch: TcxGridDBColumn;
    cxGrid2DBTableView1koef: TcxGridDBColumn;
    cxGrid2Level1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxTabSheet3: TcxTabSheet;
    cxRadioGroup1: TcxRadioGroup;
    cxCheckBox1: TcxCheckBox;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxTextEdit1SMTP: TcxTextEdit;
    cxTextEdit3: TcxTextEdit;
    cxLabel7: TcxLabel;
    cxTextEdit7: TcxTextEdit;
    cxTextEdit8: TcxTextEdit;
    cxTextEdit9: TcxTextEdit;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxRadioGroup2: TcxRadioGroup;
    cxComboBox1: TcxComboBox;
    cxTextEdit10: TcxTextEdit;
    cxLabel12: TcxLabel;
    cxCheckBox2: TcxCheckBox;
    cxCheckBox3: TcxCheckBox;
    btnEmailSMTPPost: TcxButton;
    btnEmailSMTPCancel: TcxButton;
    cxSpinEdit1: TcxSpinEdit;
    cxSpinEdit2: TcxSpinEdit;
    cxLabel19: TcxLabel;
    cxTabSheet4: TcxTabSheet;
    cxCheckBox4: TcxCheckBox;
    cxRadioGroup3: TcxRadioGroup;
    cxTextEdit1POP: TcxTextEdit;
    cxLabel13: TcxLabel;
    cxSpinEdit3: TcxSpinEdit;
    cxLabel14: TcxLabel;
    cxTextEdit2: TcxTextEdit;
    cxLabel15: TcxLabel;
    cxTextEdit6: TcxTextEdit;
    cxLabel16: TcxLabel;
    cxTextEdit11: TcxTextEdit;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxTextEdit12: TcxTextEdit;
    cxCheckBox5: TcxCheckBox;
    cxCheckBox6: TcxCheckBox;
    btnPOPPost: TcxButton;
    btnPOPCancel: TcxButton;
    cxCheckBox7: TcxCheckBox;
    cxTabSheet5: TcxTabSheet;
    cxGroupBox2: TcxGroupBox;
    cxCheckBox8: TcxCheckBox;
    cxCheckBox9: TcxCheckBox;
    cxCheckBox10: TcxCheckBox;
    cxCheckBox11: TcxCheckBox;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1Enabled: TcxGridDBColumn;
    cxGridDBTableView1Name: TcxGridDBColumn;
    cxGridDBTableView1Email: TcxGridDBColumn;
    cxGridDBTableView1FormatFileMaket: TcxGridDBColumn;
    cxGridDBTableView1SendNotification: TcxGridDBColumn;
    cxGridDBTableView1FormatFileNotification: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    btnSubscribePost: TcxButton;
    btnSubscribeCancel: TcxButton;
    adsPeretokIsSK: TIntegerField;
    adsPeretokINN_from: TWideStringField;
    cxGrid2DBTableView1isCK: TcxGridDBColumn;
    cxGrid2DBTableView1INN_from: TcxGridDBColumn;
    procedure btnSenderPostClick(Sender: TObject);
    procedure btnSenderCancelClick(Sender: TObject);
    procedure cxTextEdit4PropertiesChange(Sender: TObject);
    procedure cxTextEdit1SMTPPropertiesChange(Sender: TObject);
    procedure btnEmailSMTPPostClick(Sender: TObject);
    procedure btnEmailSMTPCancelClick(Sender: TObject);
    procedure cxTextEdit1POPPropertiesChange(Sender: TObject);
    procedure btnPOPPostClick(Sender: TObject);
    procedure btnPOPCancelClick(Sender: TObject);
    procedure cxGrid2DBTableView1SK_ArchPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxCheckBox6PropertiesChange(Sender: TObject);
    procedure btnSubscribeCancelClick(Sender: TObject);
    procedure btnSubscribePostClick(Sender: TObject);
    procedure cxCheckBox8PropertiesChange(Sender: TObject);
    procedure cxGrid2DBTableView1Column3PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
  public
    procedure SenderPost;
    procedure SenderCancel;
    procedure EmailSMTPPost;
    procedure EmailSMTPCancel;
    procedure EmailPOPPost;
    procedure EmailPOPCancel;
    procedure SubscribePost;
    procedure SubscribeCancel;            
  end;

procedure DoOptionsMaket(AOwner: TComponent);

var
  dlgOptionsMaket: TdlgOptionsMaket;

implementation

uses dmData_u, uVar, dlgProcess_u, uAdoUtils, dlgPlanCalculate_u;

{$R *.dfm}

procedure DoOptionsMaket(AOwner: TComponent);
begin
  with TdlgOptionsMaket.Create(AOwner) do
  try
    ShowProcessCancel(Application.MainForm,'Чтение данных...');
    try
      dmData.Get80020sendmail(m80020sendmail);
      dmData.Get80020getmail(m80020getmail);
      dmData.Get80020subscribe(m80020subscribe);      
      SenderCancel;
      EmailSMTPCancel;
      EmailPOPCancel;
      SubscribeCancel;
    finally
      HideProcessCancel;
    end;
    if not adsArea.Active then
      adsArea.Open;
    if not adsPeretok.Active then
      adsPeretok.Open;
    if not adsSubscribe.Active then
      adsSubscribe.Open;
    adsArea.Properties['Update Resync'].Value:= adResyncAutoIncrement + adResyncInserts;
    adsPeretok.Properties['Update Resync'].Value:= adResyncAutoIncrement + adResyncInserts;
    adsSubscribe.Properties['Update Resync'].Value:= adResyncAutoIncrement + adResyncInserts;

    ShowModal();
    
    ShowProcessCancel(Application.MainForm,'Сохранение данных...');
    try
      AdoPostCancelClose(adsArea);
      AdoPostCancelClose(adsPeretok);
      AdoPostCancelClose(adsSubscribe);
      if btnSenderPost.Enabled then
        if Application.MessageBox('Желаете сохранить данные об отправителе?','',MB_OKCANCEL) = IDOK then
        begin
           Application.ProcessMessages;
           SenderPost;
        end;
      if btnEmailSMTPPost.Enabled then
        if Application.MessageBox('Желаете сохранить данные об SMTP подключении отправки макета?','',MB_OKCANCEL) = IDOK then
        begin
           Application.ProcessMessages;
           EmailSMTPPost;
           dmData.Get80020sendmail(m80020sendmail);           
        end;
      if btnPOPPost.Enabled then
        if Application.MessageBox('Желаете сохранить данные об POP подключении ответного макета?','',MB_OKCANCEL) = IDOK then
        begin
           Application.ProcessMessages;
           EmailPOPPost;
           dmData.Get80020getmail(m80020getmail);
        end;
      if btnSubscribePost.Enabled then
        if Application.MessageBox('Желаете сохранить данные о настройках приёма макетов','',MB_OKCANCEL) = IDOK then
        begin
           Application.ProcessMessages;
           SubscribePost;
           dmData.Get80020subscribe(m80020subscribe);
        end;

    finally
      HideProcessCancel;
    end;
  finally
    Free;
  end;
end;

procedure TdlgOptionsMaket.SenderPost;
begin
  dmData.SetParam(PARAM_SENDER_NAME,cxTextEdit4.Text);
  dmData.SetParam(PARAM_SENDER_INN,cxTextEdit5.Text);
  btnSenderPost.Enabled   := false;
  btnSenderCancel.Enabled := false;
end;

procedure TdlgOptionsMaket.SenderCancel;
begin
  cxTextEdit4.Text := dmData.GetParam(PARAM_SENDER_NAME);
  cxTextEdit5.Text := dmData.GetParam(PARAM_SENDER_INN);
  btnSenderPost.Enabled   := false;
  btnSenderCancel.Enabled := false;
end;

procedure TdlgOptionsMaket.btnSenderPostClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Сохранение данных...');
  try
    SenderPost;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.btnSenderCancelClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    SenderCancel;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.cxTextEdit4PropertiesChange(Sender: TObject);
begin
  btnSenderPost.Enabled   := true;
  btnSenderCancel.Enabled := true;
end;

procedure TdlgOptionsMaket.EmailSMTPPost;
begin
  dmData.SetParam(PARAM_SMTP_ACTIVE,BoolToStr(cxCheckBox1.Checked,false));
  dmData.SetParam(PARAM_SMTP_SERVER,cxTextEdit1SMTP.Text);
  dmData.SetParam(PARAM_SMTP_PORT,cxSpinEdit1.Value);
  dmData.SetParam(PARAM_SMTP_TIMEOUT,cxSpinEdit2.Value);
  dmData.SetParam(PARAM_SMTP_MAILBOX,cxTextEdit3.Text);
  dmData.SetParam(PARAM_SMTP_OTKOGO,cxTextEdit9.Text);
  dmData.SetParam(PARAM_SMTP_SUBJECT,cxTextEdit8.Text);
  dmData.SetParam(PARAM_SMTP_KOMU,cxTextEdit7.Text);
  dmData.SetParam(PARAM_SMTP_CHARSET,cxComboBox1.Text);
  if cxRadioGroup2.ItemIndex = 1 then
    dmData.SetParam(PARAM_SMTP_TEXTENCODING,'teBase64')
  else
    dmData.SetParam(PARAM_SMTP_TEXTENCODING,'te8Bit');
  dmData.SetParam(PARAM_SMTP_FILEFORMAT,cxTextEdit10.Text);
  dmData.SetParam(PARAM_SMTP_FILETMPDELETE,BoolToStr(cxCheckBox3.Checked,false));
  dmData.SetParam(PARAM_SMTP_FILEZIPED,BoolToStr(cxCheckBox2.Checked,false));

  btnEmailSMTPPost.Enabled   := false;
  btnEmailSMTPCancel.Enabled := false;
  
  dmData.Get80020sendmail(m80020sendmail);
end;

procedure TdlgOptionsMaket.EmailSMTPCancel;
begin
  with m80020sendmail do
  begin
    cxCheckBox1.Checked := Active;
    cxTextEdit1SMTP.Text := SMTPserver;
    cxSpinEdit1.Value := StrToIntDef(SMTPport,25);
    cxSpinEdit2.Value := TimeOut;
    cxTextEdit3.Text := mailbox;
    cxTextEdit9.Text := OtKogo;
    cxTextEdit8.Text := Subject;
    cxTextEdit7.Text := Komu;
    cxComboBox1.Text := CharSet;
    if TextEncoding = teBase64 then
      cxRadioGroup2.ItemIndex := 1
    else
      cxRadioGroup2.ItemIndex := 0;
    cxTextEdit10.Text := FileFormat;
    cxCheckBox3.Checked := FileTmpDelete;
    cxCheckBox2.Checked := FileZiped;
  end;
  btnEmailSMTPPost.Enabled   := false;
  btnEmailSMTPCancel.Enabled := false;
end;

procedure TdlgOptionsMaket.EmailPOPCancel;
begin
  with m80020getmail do
  begin
    cxCheckBox4.Checked := Active;
    cxTextEdit1POP.Text := POPserver;
    cxSpinEdit3.Value := StrToIntDef(POPport,110);
    cxTextEdit2.Text := Login;
    cxTextEdit6.Text := Password;
    cxTextEdit12.Text := FileFormat;
    cxCheckBox6.Checked := IsEmailFrom;
    cxTextEdit11.Text := EmailFrom;
    cxCheckBox5.Checked := IsDeleteLoadedEmail;
    cxCheckBox7.Checked := FileTmpDelete;
  end;
  btnPOPPost.Enabled := false;
  btnPOPCancel.Enabled := false;
end;

procedure TdlgOptionsMaket.EmailPOPPost;
begin
  dmData.SetParam(PARAM_POP_ACTIVE,BoolToStr(cxCheckBox4.Checked,false));
  dmData.SetParam(PARAM_POP_SERVER,cxTextEdit1POP.Text);
  dmData.SetParam(PARAM_POP_PORT,cxSpinEdit3.Value);
  dmData.SetParam(PARAM_POP_LOGIN,cxTextEdit2.Text);
  dmData.SetParam(PARAM_POP_PASSWORD,dmData.Crypt(cxTextEdit6.Text));
  dmData.SetParam(PARAM_POP_FILEFORMAT,cxTextEdit12.Text);
  dmData.SetParam(PARAM_POP_ISEMAILFROM,BoolToStr(cxCheckBox6.Checked,false));
  dmData.SetParam(PARAM_POP_EMAILFROM,cxTextEdit11.Text);
  dmData.SetParam(PARAM_POP_ISDELETELOADDEDEMAIL,BoolToStr(cxCheckBox5.Checked,false));
  dmData.SetParam(PARAM_POP_FILETMPDELETE,BoolToStr(cxCheckBox7.Checked,false));

  btnPOPPost.Enabled := false;
  btnPOPCancel.Enabled := false;

  dmData.Get80020getmail(m80020getmail);
end;
 
procedure TdlgOptionsMaket.SubscribeCancel;
begin
  with m80020subscribe do
  begin
    cxCheckBox8.Checked := Active;
    cxCheckBox10.Checked := IsDeleteLoadedEmail;
    cxCheckBox11.Checked := FileZipped;
    cxCheckBox9.Checked := FileTmpDelete;
  end;
  btnSubscribePost.Enabled := false;
  btnSubscribeCancel.Enabled := false;
end;

procedure TdlgOptionsMaket.SubscribePost;
begin
  dmData.SetParam(PARAM_SUBSCRIBE_ACTIVE,BoolToStr(cxCheckBox8.Checked,false));
  dmData.SetParam(PARAM_SUBSCRIBE_ISDELETELOADDEDEMAIL,BoolToStr(cxCheckBox10.Checked,false));
  dmData.SetParam(PARAM_SUBSCRIBE_FILETMPDELETE,BoolToStr(cxCheckBox9.Checked,false));
  dmData.SetParam(PARAM_SUBSCRIBE_FILEZIPED,BoolToStr(cxCheckBox11.Checked,false));

  btnSubscribePost.Enabled := false;
  btnSubscribeCancel.Enabled := false;

  dmData.Get80020subscribe(m80020subscribe);
end;

procedure TdlgOptionsMaket.btnEmailSMTPPostClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Сохранение данных...');
  try
    EmailSMTPPost;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.btnEmailSMTPCancelClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    EmailSMTPCancel;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.cxTextEdit1SMTPPropertiesChange(Sender: TObject);
begin
  btnEmailSMTPPost.Enabled   := true;
  btnEmailSMTPCancel.Enabled := true;
end;

procedure TdlgOptionsMaket.cxTextEdit1POPPropertiesChange(Sender: TObject);
begin
  btnPOPPost.Enabled   := true;
  btnPOPCancel.Enabled := true;
end;

procedure TdlgOptionsMaket.cxCheckBox6PropertiesChange(Sender: TObject);
begin
  cxTextEdit1POPPropertiesChange(Sender);
  cxTextEdit11.Enabled := cxCheckBox6.Checked;
end;

procedure TdlgOptionsMaket.btnPOPPostClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Сохранение данных...');
  try
    EmailPOPPost;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.btnPOPCancelClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    EmailPOPCancel;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.btnSubscribePostClick(Sender: TObject);
begin
  ShowProcessCancel(Application.MainForm,'Сохранение данных...');
  try
    SubscribePost
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.btnSubscribeCancelClick(Sender: TObject);
begin
   ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    SubscribeCancel;
  finally
    HideProcessCancel;
  end;
end;

procedure TdlgOptionsMaket.cxCheckBox8PropertiesChange(Sender: TObject);
begin
  btnSubscribePost.Enabled   := true;
  btnSubscribeCancel.Enabled := true;
end;

procedure TdlgOptionsMaket.cxGrid2DBTableView1SK_ArchPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  ShowMessage(
    ' Список категорий СК-2003:'#10#13
    +' 1 Телеизмерения	ТИ '#10#13
    +' 2 Телесигналы	ТС '#10#13
    +' 3 Интегралы и средние	ИС '#10#13
    +' 4 СВ-1 (мгновенная,СДВ)	СВ '#10#13
    +' 5 Планы	ПЛ '#10#13
    +' 6 Ежедневная информация	ЕИ  '#10#13
    +' 7 Специальные параметры вещественные	СП '#10#13
    +' 8 СВ-2 (усредненная)	ПВ '#10#13
    +' 9 Фильтрованные телеизмерения	ФТИ '#10#13
    +'10 Специальные параметры целочисленные	МСК '#10#13
    +'11 Телеизмерения "сырые"	ТИС '#10#13
    +'12 Телесигналы "сырые"	ТСС '#10#13
    +'13 Универсальные хранилища 30 мин	ПЧАС  '#10#13
    +'14 Универсальные хранилища 1 час	ЧАС   '#10#13
    +'15 Универсальные хранилища 1 день	СУТ   '
   );   
end;

procedure TdlgOptionsMaket.cxGrid2DBTableView1Column3PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  DoPlanCalc(Application.MainForm, adsPeretokid.AsInteger);
end;

end.
