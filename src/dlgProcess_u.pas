unit dlgProcess_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, ComCtrls, 
  StdCtrls,  XPMan, Buttons, cxControls,
  cxContainer, cxEdit, cxProgressBar, cxLookAndFeelPainters, cxButtons,
  Menus;

type
  TCancelProcedure = procedure;

  TdlgProcess= class(TForm)
    AdvPanel1: TPanel;
    Bevel1: TBevel;
    Timer1: TTimer;
    lbName: TLabel;
    pbProgress: TcxProgressBar;
    btnCancel: TcxButton;
    procedure FormDeactivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    OnCancel: TCancelProcedure;
    { Private declarations }
  public
    iMaxTime: Integer;
    iProcess: Integer;
  end;

var
  dlgProcess: TdlgProcess = nil;
  ProcessCanceled : Boolean;

procedure ShowProcessCancel(AOwner: TComponent = nil;
                            ACaption : string = 'ֶהטעו....';
                            Timer: Boolean = false;
                            MaxTime: Integer = 0;
                            Cancel: Boolean = false;
                            AOnCancel: TCancelProcedure = nil);
procedure ProcessCancelNext;
procedure HideProcessCancel;
procedure StopProcess;
procedure ContinueProcess;


implementation

procedure ShowProcessCancel(AOwner: TComponent = nil;
                            ACaption : string = 'ֶהטעו....';
                            Timer: Boolean = false;
                            MaxTime: Integer = 0;
                            Cancel: Boolean = false;
                            AOnCancel: TCancelProcedure = nil);
begin
  if dlgProcess <> nil then
    Exit;
  Application.ProcessMessages;  
  ProcessCanceled := False;
  dlgProcess := TdlgProcess.Create(AOwner);
  dlgProcess.OnCancel := AOnCancel;
  dlgProcess.lbName.Caption := ACaption;
  dlgProcess.pbProgress.Position := 0;
  dlgProcess.iProcess := 0;
  dlgProcess.iMaxTime := MaxTime;
  if not Cancel then
    dlgProcess.Width := 435 - 90;
  dlgProcess.btnCancel.Visible := Cancel;
  dlgProcess.Show;
  dlgProcess.Repaint;
  dlgProcess.Timer1.Enabled := Timer;
end;

procedure ProcessCancelNext;
begin
  if dlgProcess = nil then
    Exit;
  with dlgProcess do
  begin
    iProcess := iProcess + 1;
    if iProcess > iMaxTime then
      iProcess := 1;
     pbProgress.Position := Round(( iProcess * 100 ) / iMaxTime);
  end;
end;

procedure HideProcessCancel;
var
  dlgProcess1 : TdlgProcess;
begin
  dlgProcess.Timer1.Enabled := False;
  if dlgProcess = nil then
    Exit;
  dlgProcess1 := dlgProcess;
  dlgProcess := nil;
  dlgProcess1.Free;
  ProcessCanceled := True;
end;

procedure StopProcess;
begin
  dlgProcess.Timer1.Enabled := false;
end;                                       

procedure ContinueProcess;
begin
  dlgProcess.Timer1.Enabled := true;
end;

{$R *.dfm}

procedure TdlgProcess.FormDeactivate(Sender: TObject);
begin
  if dlgProcess = nil then
    Exit;
  Show;
  Activate;
end;

procedure TdlgProcess.Timer1Timer(Sender: TObject);
begin
  ProcessCancelNext; 
end;

procedure TdlgProcess.btnCancelClick(Sender: TObject);
begin
  if @OnCancel <> nil then
    OnCancel;
  ProcessCanceled := True;    
end;

end.
