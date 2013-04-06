unit cvProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, XPMan, Menus,
  cxControls, cxContainer, cxEdit, cxProgressBar,
  cxTextEdit, cxMemo, cxLookAndFeelPainters, cxButtons;

type
  TdlgProgress = class(TForm)
    AdvPanel1: TPanel;
    Bevel1: TBevel;
    XPManifest1: TXPManifest;
    pbResult: TcxProgressBar;
    amInfo: TcxMemo;
    btnCancel: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private

  public
    bModal: Boolean;
    bCancelled: Boolean; 
  end;

  { class TVProgress }

  TVProgress = class
  private
    FProgress: TdlgProgress;
    FCaption: string;
    FPosition: Integer;
    FCount,
    FMax: Integer;
    FError: string;    

    procedure SetCaption(Value: string);
    procedure SetPosition(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetCount(Value: Integer);
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    property Caption: string read FCaption write SetCaption;
    property Position: Integer read FPosition write SetPosition;
    property Max: Integer read FMax write SetMax;
    property Count: Integer read FCount write SetCount;

    procedure Show(bMod: Boolean = true);
    procedure AddInfo(sInf: string);
    function StepProgress(Value: Integer = 1): Boolean;
    procedure ResetProgress(iMax: Integer = 1);
  end;
  
implementation

{
procedure EndProgress();
begin
  if dlgProgress = nil then
    Exit;
  dlgProgress.Cancelled:=true;
  dlgProgress.btnCancel.Caption:='Закрыть';
end;

procedure ExitToForm();
begin
  if dlgProgress = nil then
    Exit;
  dlgProgress.Close;
  dlgProgress:=nil;
end;   

}

{$R *.dfm}

procedure TdlgProgress.FormCreate(Sender: TObject);
begin
  bModal:=true;
end;

procedure TdlgProgress.FormDeactivate(Sender: TObject);
begin
  if bModal then
  begin
    Show;
    Activate;
  end;  
end;

procedure TdlgProgress.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TdlgProgress.btnCancelClick(Sender: TObject);
begin
  if bCancelled then
    Close  
  else
    bCancelled := true;
end;

{  class TVProgress }

constructor TVProgress.Create(aOwner: TComponent);
begin
  inherited Create;
  FProgress:=TdlgProgress.Create(aOwner);
  Caption := '';
  ResetProgress(1);
  FProgress.amInfo.Lines.Clear;
  FProgress.bCancelled := False;
  FProgress.btnCancel.Caption := 'Отмена';
//
  FError := '';
end;

destructor TVProgress.Destroy;
begin
  FProgress.Free;
  inherited Destroy;
end;

procedure TVProgress.SetCaption(Value: string);
begin
  FProgress.Caption := Value;
  FCaption := Value;
end;

procedure TVProgress.SetPosition(Value: Integer);
begin
  FProgress.pbResult.Position := Value;
  FPosition := Value;
end;

procedure TVProgress.SetMax(Value: Integer);
begin
  FMax := Value;
end;

procedure TVProgress.SetCount(Value: Integer);
begin
  FCount := Value;
end;

procedure TVProgress.Show(bMod: Boolean = true);
begin
  if not bMod then
    FProgress.FormStyle:=fsStayOnTop;
  FProgress.bModal := bMod;
  FProgress.Show;
end;

procedure TVProgress.AddInfo(sInf: string);
begin
  FProgress.amInfo.Lines.Add(sInf);
end;

procedure TVProgress.ResetProgress(iMax: Integer = 1);
begin
  if iMax < 1 then
    Max:=1
  else
    Max:=iMax;
  Position := 0;
  Count:=0;
end;

function TVProgress.StepProgress(Value: Integer = 1): Boolean;
begin
  if not FProgress.bCancelled then
  begin
    Application.ProcessMessages;
    Count:=Count+Value;
    Position:=Round(Count * 100 / Max);
    Result:=true;
  end
  else
  begin
//    exit;
    Result:=false;
  end;
end;

end.
