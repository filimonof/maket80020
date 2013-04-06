unit dlgPlanCalculate_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLabel, XPMan, cxControls, cxContainer, cxEdit, cxImage, Menus,
  cxLookAndFeelPainters, ExtCtrls, StdCtrls, cxButtons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dmData_u, ADODB,
  cxDropDownEdit, cxDBLookupComboBox;

type
  TdlgPlanCalculate = class(TForm)
    cxImage1: TcxImage;
    XPManifest1: TXPManifest;
    cxLabel1: TcxLabel;
    cxImage2: TcxImage;
    cxButton1: TcxButton;
    Bevel1: TBevel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    adsPlan: TADODataSet;
    dsPlan: TDataSource;
    adsPlanid: TAutoIncField;
    adsPlanparamID: TIntegerField;
    adsPlankoef: TIntegerField;
    adsPlanarea: TWideStringField;
    adsPlantype: TIntegerField;
    adsPlancode1: TWideStringField;
    adsPlancode2: TWideStringField;
    adsPlanchannel: TWideStringField;
    cxGridDBTableView1koef: TcxGridDBColumn;
    cxGridDBTableView1area: TcxGridDBColumn;
    cxGridDBTableView1type: TcxGridDBColumn;
    cxGridDBTableView1code1: TcxGridDBColumn;
    cxGridDBTableView1code2: TcxGridDBColumn;
    cxGridDBTableView1channel: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    dsType: TDataSource;
    adsType: TADODataSet;
    adsArea: TADODataSet;
    dsArea: TDataSource;
    adsCode: TADODataSet;
    dsCode: TDataSource;
    adsPlaninn: TWideStringField;
    cxGridDBTableView1inn: TcxGridDBColumn;
    dsINN: TDataSource;
    adsINN: TADODataSet;
    procedure adsPlanNewRecord(DataSet: TDataSet);
  private
    paramID: Integer;
  public
    { Public declarations }
  end;

procedure DoPlanCalc(AOwner: TComponent; prmID: Integer);

var
  dlgPlanCalculate: TdlgPlanCalculate;

implementation

{$R *.dfm}

procedure DoPlanCalc(AOwner: TComponent; prmID: Integer);
begin
  with TdlgPlanCalculate.Create(AOwner) do
  try
    paramID := prmID;
    adsINN.Open;
    adsType.Open;
    adsArea.Open;
    adsCode.Open;    
    adsPlan.Close;
    adsPlan.Parameters.ParamByName('A').Value := paramID;
    adsPlan.Open;

    ShowModal();

    try
    finally
      //HideProcessCancel;
    end;
  finally
    if adsPlan.State in [dsEdit, dsInsert] then
      adsPlan.Post;
    adsPlan.Close;
    adsType.Close;
    adsArea.Close;
    adsCode.Close;
    adsINN.Close;       
    Free;
  end;
end;  

procedure TdlgPlanCalculate.adsPlanNewRecord(DataSet: TDataSet);
begin
  DataSet['paramID'] := paramID;
end;

end.
