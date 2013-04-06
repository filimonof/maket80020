unit dlgGetDate_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLabel, cxControls, cxContainer, cxEdit, cxImage, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxRadioGroup, cxGroupBox, XPMan;

type
  TdlgGetDate = class(TForm)
    cxImage2: TcxImage;
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    Bevel1: TBevel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    deDate: TcxDateEdit;
    XPManifest1: TXPManifest;
    deDateEnd: TcxDateEdit;
    rbManyDay: TcxRadioButton;
    rbDay: TcxRadioButton;
    procedure rbDayClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgGetDate: TdlgGetDate;

function DoGetDate(AOwner: TComponent; var date1: TDateTime; var date2: TDateTime; var inputprint: Integer): Boolean;

implementation

{$R *.dfm}

function DoGetDate(AOwner: TComponent; var date1: TDateTime; var date2: TDateTime; var inputprint: Integer): Boolean;
begin
  with TdlgGetDate.Create(AOwner) do
  try
    deDate.Date := date1;
    deDateEnd.Date := Date()-1;
    Result := ShowModal = mrOK;
    if Result then
    begin
      date1 := deDate.Date;
      if rbManyDay.Checked then
        date2 := deDateEnd.Date
      else
        date2 := date1;        
      inputprint:=0     // email
    end;
  finally
    Free;
  end;
end;

procedure TdlgGetDate.rbDayClick(Sender: TObject);
begin
  deDateEnd.Enabled := not rbDay.Checked;
end;

procedure TdlgGetDate.cxButton1Click(Sender: TObject);
begin
  if (rbManyDay.Checked)  then
  begin
    if (deDateEnd.Date <  deDate.Date) then
    begin
      MessageDlg('Начальная дата не может быть больше конечной.',mtInformation,[mbOk],0);
    end
    else
    begin
      if (deDateEnd.Date - deDate.Date > 30) then
      begin
        if MessageDlg('Диапазон дат более 30. Желаете отправить?',mtConfirmation,[mbYes,mbCancel],0) = mrCancel then
          Exit;
      end;
      ModalResult := mrOk;
    end;
  end
  else
  begin
    ModalResult := mrOk;
  //  Close;
  end;  
end;

end.
