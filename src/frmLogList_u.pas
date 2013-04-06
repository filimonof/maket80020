unit frmLogList_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, dxDockControl,
  dxBar, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ADODB, dmData_u, cxGridBandedTableView,
  cxGridDBBandedTableView, dxBarExtItems, DateUtils, ImgList,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  cxCheckBox;

type
  TfrmLogList = class(TForm)
    dxBarManager1: TdxBarManager;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dsLog: TDataSource;
    adsLog: TADODataSet;
    adsLogid: TAutoIncField;
    adsLogStatus: TIntegerField;
    adsLogDateEvent: TDateTimeField;
    adsLogDateFile: TDateTimeField;
    adsLogINNFile: TWideStringField;
    adsLogNumberFile: TIntegerField;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1id: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Status: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1DateEvent: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1DateFile: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1INNFile: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1NumberFile: TcxGridDBBandedColumn;
    cbiMonth: TdxBarCombo;
    seiYear: TdxBarSpinEdit;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    ilSmallIcons: TImageList;
    ilStatus: TImageList;
    dxBarButton3: TdxBarButton;
    adsLogComment: TMemoField;
    dxComboStat: TdxBarCombo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure seiYearCurChange(Sender: TObject);
    procedure cbiMonthCurChange(Sender: TObject);
    procedure seiYearButtonClick(Sender: TdxBarSpinEdit;
      Button: TdxBarSpinEditButton);
    procedure dxBarButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ReloadLogList(m,y,stat: Integer);
    procedure RefreshLog;
  end;

var
  frmLogList: TfrmLogList;

implementation

uses uVar, uAdoUtils, dlgProcess_u;

{$R *.dfm}

procedure TfrmLogList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if adsLog.State in [dsEdit, dsInsert] then
  try
    adsLog.Post;
  except
    adsLog.Cancel;
  end;
  Action := caFree;
end;

procedure TfrmLogList.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Application.ProcessMessages;
  seiYear.Value := YearOf(Now());
  cbiMonth.Items.Clear;
    for i:=1 to 12 do
      cbiMonth.Items.Add(mMonthDay[i]);
  cbiMonth.ItemIndex := MonthOf(Now())-1;
//  ReloadLogList(MonthOf(Now()),YearOf(Now()));
end;

procedure TfrmLogList.ReloadLogList(m,y,stat: Integer);
var
  day1, day2: TDateTime;
  filter: string;
begin
  Application.ProcessMessages;
  cxGrid1.BeginUpdate;
  adsLog.DisableControls;
  ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    day1:=EncodeDateTime(y,m,1,0,0,0,0);
    day2:=EncodeDateTime(y,m,DaysInAMonth(y,m),0,0,0,0);
    if adsLog.State in [dsEdit, dsInsert] then
      adsLog.Cancel;
    if adsLog.Active then
      adsLog.Close;
    adsLog.CommandType := cmdText;
    filter := ''; // все события
    case stat of
       1: filter := ' and Status IN (1, 2, 3, 5, 6, 8, 9) ';  //события без ошибок
       2: filter := ' and Status IN (5,6,7,8,9,10) ';         //входящие
       3: filter := ' and Status IN (1,2,3,4) ';              //исходящие
    end;
    adsLog.CommandText:='select * from tblMaket80020Log where DateFile>='''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],day1)+''' and DateFile<='''+DateTimeToSQLDateTimeString(sSQLDateTimeFormat[1],day2)+'''' + filter + ' order by DateEvent DESC, ID ASC';
{
Status : 
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
    adsLog.Open;
  finally
    adsLog.EnableControls;
    cxGrid1.EndUpdate;    
    HideProcessCancel;
  end;
end;

procedure TfrmLogList.RefreshLog;
var
  m,y: Integer;
  stat: Integer;
begin
  m:=cbiMonth.ItemIndex+1;
  y:=Round(seiYear.Value);
  stat := dxComboStat.ItemIndex;
  cbiMonth.DroppedDown:=False;
  Application.ProcessMessages;
  if (m in [1..12]) and (y>1) then
  begin
    ReloadLogList(m,y,stat);
  end;
end;


procedure TfrmLogList.dxBarButton1Click(Sender: TObject);
begin
  RefreshLog;
end;

procedure TfrmLogList.dxBarButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogList.seiYearCurChange(Sender: TObject);
begin
  if not VarIsNull(seiYear.CurValue) then
    seiYear.Value:=seiYear.CurValue;
end;

procedure TfrmLogList.cbiMonthCurChange(Sender: TObject);
begin
//  cbiMonth.ItemIndex := cbiMonth.CurItemIndex;
end;

procedure TfrmLogList.seiYearButtonClick(Sender: TdxBarSpinEdit;
  Button: TdxBarSpinEditButton);
begin
  RefreshLog;
end;

procedure TfrmLogList.dxBarButton3Click(Sender: TObject);
begin
  if not adsLog.IsEmpty then
    if adsLogComment.AsString<>'' then
      ShowMessage(adsLogComment.AsString);
end; 

initialization
  RegisterClass(TfrmLogList);
end.
