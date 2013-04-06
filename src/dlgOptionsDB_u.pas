unit dlgOptionsDB_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  Buttons, cxLabel, cxControls, cxContainer, cxEdit, cxImage, cxGroupBox,
  cxTextEdit, cxCheckBox, cxMaskEdit, cxSpinEdit, cxRadioGroup;

type
  TdlgOptionsDB = class(TForm)
    Bevel1: TBevel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxImage1: TcxImage;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    cxCheckBox1: TcxCheckBox;
    cxSpinEdit1: TcxSpinEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxCheckBox2: TcxCheckBox;
    cxTextEdit3: TcxTextEdit;
    cxLabel5: TcxLabel;
    cxCheckBox3: TcxCheckBox;
    cxTextEdit5: TcxTextEdit;
    cxLabel7: TcxLabel;
    cxTextEdit6: TcxTextEdit;
    cxLabel8: TcxLabel;
    cxTextEdit7: TcxTextEdit;
    cxLabel9: TcxLabel;
    cxCheckBox4: TcxCheckBox;
    cxTextEdit4: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxTextEdit8: TcxTextEdit;
    cxLabel10: TcxLabel;
    cxTextEdit9: TcxTextEdit;
    cxLabel11: TcxLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    cxTextEdit10: TcxTextEdit;
    cxTextEdit11: TcxTextEdit;
    cxCheckBox5: TcxCheckBox;
    cxTextEdit12: TcxTextEdit;
    cxLabel12: TcxLabel;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    cxTextEdit13: TcxTextEdit;
    cxTextEdit14: TcxTextEdit;
    cxCheckBox6: TcxCheckBox;
    cxTextEdit15: TcxTextEdit;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxLabel17: TcxLabel;
    Bevel4: TBevel;
  private
    { Private declarations }
  public

  end;

var
  dlgOptionsDB: TdlgOptionsDB;

procedure DoOptionsDB(AOwner: TComponent);  

implementation

uses dmData_u, dlgProcess_u, uVar;

procedure DoOptionsDB(AOwner: TComponent);
begin
  with TdlgOptionsDB.Create(AOwner) do
  try
    cxCheckBox1.Checked := mServersSQL[1].Active;
    cxTextEdit1.Text := mServersSQL[1].Name;
    cxTextEdit2.Text := mServersSQL[1].ServerIP;
    cxTextEdit5.Text := mServersSQL[1].NameDB;
    cxCheckBox4.Checked := mServersSQL[1].WinNTAuth;
    cxTextEdit6.Text := mServersSQL[1].Login;
    cxTextEdit7.Text := mServersSQL[1].Password;
    cxSpinEdit1.Value := mServersSQL[1].TimeOut;

    cxCheckBox2.Checked := mServersCK[1].Active;
    cxTextEdit3.Text := mServersCK[1].Name;
    cxTextEdit4.Text := mServersCK[1].Server_1;
    cxCheckBox3.Checked := mServersCK[1].WinAuth_1;
    cxTextEdit8.Text := mServersCK[1].Login_1;
    cxTextEdit9.Text := mServersCK[1].Pas_1;
    cxTextEdit12.Text := mServersCK[1].Server_2;
    cxCheckBox5.Checked := mServersCK[1].WinAuth_2;
    cxTextEdit11.Text := mServersCK[1].Login_2;
    cxTextEdit10.Text := mServersCK[1].Pas_2;
    cxTextEdit15.Text := mServersCK[1].Server_3;
    cxCheckBox6.Checked := mServersCK[1].WinAuth_3;
    cxTextEdit14.Text := mServersCK[1].Login_3;
    cxTextEdit13.Text := mServersCK[1].Pas_3;

    if ShowModal() = mrOK then
    begin
      try
        ShowProcessCancel(Application.MainForm,'Сохранение данных...');

        mServersSQL[1].Active := cxCheckBox1.Checked;
        mServersSQL[1].Name := cxTextEdit1.Text;
        mServersSQL[1].ServerIP := cxTextEdit2.Text;
        mServersSQL[1].NameDB := cxTextEdit5.Text;
        mServersSQL[1].WinNTAuth := cxCheckBox4.Checked;
        mServersSQL[1].Login := cxTextEdit6.Text;
        mServersSQL[1].Password := cxTextEdit7.Text;
        mServersSQL[1].TimeOut := cxSpinEdit1.Value;

        mServersCK[1].Active := cxCheckBox2.Checked;
        mServersCK[1].Name := cxTextEdit3.Text;
        mServersCK[1].Server_1 := cxTextEdit4.Text;
        mServersCK[1].WinAuth_1 := cxCheckBox3.Checked;
        mServersCK[1].Login_1 := cxTextEdit8.Text;
        mServersCK[1].Pas_1 := cxTextEdit9.Text;
        mServersCK[1].Server_2 := cxTextEdit12.Text;
        mServersCK[1].WinAuth_2 := cxCheckBox5.Checked;
        mServersCK[1].Login_2 := cxTextEdit11.Text;
        mServersCK[1].Pas_2 := cxTextEdit10.Text;
        mServersCK[1].Server_3 := cxTextEdit15.Text;
        mServersCK[1].WinAuth_3 := cxCheckBox6.Checked;
        mServersCK[1].Login_3 := cxTextEdit14.Text;
        mServersCK[1].Pas_3 := cxTextEdit13.Text;

        dmData.PutIni;
      finally
        HideProcessCancel;
      end;

      dmData.ConnectDB;
      dmData.TestAfterConnect;
      dmData.RefreshStatusBar;
      
    end;
  finally
    Free;
  end;
end;
{
TdmData.PutIni;
}

{$R *.dfm}

end.
