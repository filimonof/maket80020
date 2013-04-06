unit dlgInputSQLPas_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLabel, cxControls, cxContainer, cxEdit, cxImage, ExtCtrls,
  Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxTextEdit, cxCheckBox;

type
  TdlgInputSQLPas = class(TForm)
    Panel1: TPanel;
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Bevel1: TBevel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxTextEdit1: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxTextEdit2: TcxTextEdit;
    cxTextEdit3: TcxTextEdit;
    cxTextEdit4: TcxTextEdit;
    cxCheckBox1: TcxCheckBox;
    cxLabel7: TcxLabel;
    procedure cxCheckBox1PropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoInputSQLPas(AOwner: TComponent; var server,database,login,pas: string; var winnt: Boolean): Boolean;

var
  dlgInputSQLPas: TdlgInputSQLPas;

implementation

{$R *.dfm}

function DoInputSQLPas(AOwner: TComponent; var server,database,login,pas: string; var winnt: Boolean): Boolean;
begin
  with TdlgInputSQLPas.Create(AOwner) do
  try
    cxTextEdit1.Text:=server;
    cxTextEdit2.Text:=database;
    cxCheckBox1.Checked := winnt;
    if winnt then
    begin
      cxTextEdit3.Text:='';
      cxTextEdit4.Text:='';
    end
    else
    begin
      cxTextEdit3.Text:=login;
      cxTextEdit4.Text:=pas;
    end;

    Result := ShowModal = mrOk;

    if Result then
    begin
      server := cxTextEdit1.Text;
      database := cxTextEdit2.Text;
      winnt := cxCheckBox1.Checked;
      if winnt then
      begin
        login := '';
        pas := '';
      end
      else
      begin
        login := cxTextEdit3.Text;
        pas := cxTextEdit4.Text;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TdlgInputSQLPas.cxCheckBox1PropertiesChange(Sender: TObject);
begin
  cxTextEdit3.Enabled := not cxCheckBox1.Checked;
  cxTextEdit4.Enabled := not cxCheckBox1.Checked;  
end;

procedure TdlgInputSQLPas.FormShow(Sender: TObject);
begin
    if cxTextEdit1.Text = '' then
      cxTextEdit1.SetFocus
    else if cxTextEdit2.Text = '' then
      cxTextEdit2.SetFocus
    else if not cxCheckBox1.Checked then
    begin
      if cxTextEdit3.Text = '' then
        cxTextEdit3.SetFocus
      else
        cxTextEdit4.SetFocus;
    end
    else
      cxButton1.SetFocus;
end;

end.
