unit dlgAbout_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, cxControls,
  cxContainer, cxEdit, cxImage, cxLabel, XPMan, Menus, cxTextEdit,
  cxHyperLinkEdit;

type
  TdlgAbout = class(TForm)
    cxImage1: TcxImage;
    cxButton1: TcxButton;
    cxImage2: TcxImage;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    XPManifest1: TXPManifest;
    cxHyperLinkEdit1: TcxHyperLinkEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoAbout(AOwner: TComponent); 

var
  dlgAbout: TdlgAbout;

implementation

uses uVar;

procedure DoAbout(AOwner: TComponent);
begin
  with TdlgAbout.Create(AOwner) do
  try
    cxLabel2.Caption := NAME_PROGRAM;
    cxLabel4.Caption := VERSION_PROGRAM;
    ShowModal;
  finally
    Free;
  end;
end;

{$R *.dfm}

end.
