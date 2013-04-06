unit frmPreview_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxBar, dxBarExtItems, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  DBClient, ADODB, ImgList, ck7GetData, uVar, ComObj, DateUtils;

type
  TfrmPreview = class(TForm)
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarDateCombo1: TdxBarDateCombo;
    cdsView: TClientDataSet;
    dsView: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1Level1: TcxGridLevel;
    cdsViewname: TStringField;
    cdsViewh0000: TStringField;
    cdsViewh0100: TStringField;
    cdsViewh0200: TStringField;
    cdsViewh0300: TStringField;
    cdsViewh0400: TStringField;
    cdsViewh0500: TStringField;
    cdsViewh0600: TStringField;
    cdsViewh0700: TStringField;
    cdsViewh0800: TStringField;
    cdsViewh0900: TStringField;
    cdsViewh1000: TStringField;
    cdsViewh1100: TStringField;
    cdsViewh1200: TStringField;
    cdsViewh1300: TStringField;
    cdsViewh1400: TStringField;
    cdsViewh1500: TStringField;
    cdsViewh1600: TStringField;
    cdsViewh1700: TStringField;
    cdsViewh1800: TStringField;
    cdsViewh1900: TStringField;
    cdsViewh2000: TStringField;
    cdsViewh2100: TStringField;
    cdsViewh2200: TStringField;
    cdsViewh2300: TStringField;
    cxGrid1DBBandedTableView1name: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0000: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0100: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0200: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0300: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0400: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0500: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0600: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0700: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0800: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h0900: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1000: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1100: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1200: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1300: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1400: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1500: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1600: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1700: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1800: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h1900: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h2000: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h2100: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h2200: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1h2300: TcxGridDBBandedColumn;
    ImageList1: TImageList;
    dxBarButton3: TdxBarButton;
    SaveDialog1: TSaveDialog;
    procedure dxBarButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxBarButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxBarDateCombo1Change(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure RefreshView;
    procedure ReloadView(dt: TDateTime);
    procedure ExportData;
  end;

var
  frmPreview: TfrmPreview;

implementation

uses dlgProcess_u, uAdoUtils, dmData_u, frmMain_u, uUtils;

{$R *.dfm}

procedure TfrmPreview.FormCreate(Sender: TObject);
begin
  Application.ProcessMessages;
  dxBarDateCombo1.Date := Date();
  ReloadView(dxBarDateCombo1.Date);
end;

procedure TfrmPreview.dxBarButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPreview.RefreshView;
begin
  ReloadView(dxBarDateCombo1.Date);
end;

procedure TfrmPreview.ReloadView(dt: TDateTime);
var
  tiInArea: TTI;
  atiRes: TOutCKDataArray;

  i: Integer;

  aq_a,aq: TAdoQuery;
  name: string;
  koef: Integer;
begin
  Application.ProcessMessages;
  cxGrid1.BeginUpdate;
  cdsView.DisableControls;
  ShowProcessCancel(Application.MainForm,'Чтение данных...');
  try
    if cdsView.Active then
      if cdsView.State in [dsEdit, dsInsert] then
        cdsView.Cancel;
    if not cdsView.Active then
    begin
      cdsView.CreateDataSet;
      cdsView.Open;
    end;  
    cdsView.First;
    while not cdsView.IsEmpty do
      cdsView.Delete;

    aq_a:=SelectQuerySimple(dmData.adc80020,'select * from tblMaket80020Area where [Enabled]=1');
    try
      if not aq_a.IsEmpty then
      begin
        aq_a.First;
        while not aq_a.Eof do
        begin
          aq:=SelectQuerySimple(dmData.adc80020,'select * from tblMaket80020ParamPoint where [Enabled]=1 and AreaID='+aq_a.FieldByName('ID').AsString);
          try
            if not aq.IsEmpty then
            begin
              aq.First;
              while not aq.Eof do
              begin
                name:=aq.FieldByName('NameObj').AsString;
                tiInArea.id := aq.FieldByName('SK_TI').AsInteger;
                tiInArea.cat := NumToCat( aq.FieldByName('SK_Arch').AsInteger );
                if VarIsNull(aq.FieldByName('koef').AsVariant)  then
                  koef:=1
                else
                  koef:=aq.FieldByName('koef').AsInteger;
                { TODO : PREVIEW: потом можно сделать и на 48 точек }
                //atiRes := mServersCK[1].Pclass.GetArrayValueTI_Sync(tiInArea.id,tiInArea.cat,ckTI24,dt);
                if aq.FieldByName('IsSK').AsInteger = INT_ENABLED then
                begin
                  //берём данные из СК-2003
                  tiInArea.id := aq.FieldByName('SK_TI').AsInteger;
                  tiInArea.cat := NumToCat( aq.FieldByName('SK_Arch').AsInteger );
                  atiRes := mServersCK[1].Pclass.GetArrayValueTI_Sync(tiInArea.id,tiInArea.cat,ckTI24,dt);
                end
                else
                begin
                  SetLength(atiRes,24);
                  for i:=0 to 23 do
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
                    frmMain.adsCreateMaket.Close;
                    //frmMain.adsCreateMaket.Parameters.ParamByName('@inn').DataType := ftString;
                    //frmMain.adsCreateMaket.Parameters.ParamByName('@inn').Value := aq.FieldByName('INN_from').AsString;
                    frmMain.adsCreateMaket.Parameters.ParamByName('@dt').DataType := ftDate;
                    frmMain.adsCreateMaket.Parameters.ParamByName('@dt').Value := dt;
                    frmMain.adsCreateMaket.Parameters.ParamByName('@paramID').DataType := ftInteger;
                    frmMain.adsCreateMaket.Parameters.ParamByName('@paramID').Value := aq.FieldByName('id').AsInteger;
                    frmMain.adsCreateMaket.Prepared := True;
                    frmMain.adsCreateMaket.Open;// ExecProc;

                    if not frmMain.adsCreateMaket.IsEmpty then
                    begin
                      frmMain.adsCreateMaket.First;
                      while not frmMain.adsCreateMaket.Eof do
                      begin
                        i := StrToInt(System.Copy(frmMain.adsCreateMaket.FieldByName('start').AsString,1,2));
                        atiRes[i].Value := frmMain.adsCreateMaket.FieldByName('Value').AsInteger;
                        if frmMain.adsCreateMaket.FieldByName('SumStatus').AsInteger = 0 then
                          atiRes[i].Prizn :=  268435456; // 0x 10 000 000 - источник: данные АСКУЭ
                        frmMain.adsCreateMaket.Next;
                      end;
                    end;
                  except
                  //малчим
                  end;
                  finally
                    frmMain.adsCreateMaket.Close;
                  end;
                end;

                // если пеерход с зимнего времени на летнее то с 2 до 3 часов вставим 0
                if (dayWinterTOSumer(YearOf(dt)) = dt) then
                begin
                  SetLength(atiRes,24);
                  for i:=22 downto 2 do
                    atiRes[i+1] := atiRes[i];
                  atiRes[2].Value := 0;
                  atiRes[2].Prizn := 524288; //0x00080000 - замена: отчетной информацией
                end;                

                cdsView.Insert;
                if name = '' then
                  cdsView.FieldByName('name').AsString := 'Не указано, ТИ='+IntToStr(tiInArea.id)
                else
                  cdsView.FieldByName('name').AsString := name;
                cdsView.FieldByName('h0000').AsString := dmData.VarToStrDefIsNull(atiRes[0],koef,NULLTODEF);
                cdsView.FieldByName('h0100').AsString := dmData.VarToStrDefIsNull(atiRes[1],koef,NULLTODEF);
                cdsView.FieldByName('h0200').AsString := dmData.VarToStrDefIsNull(atiRes[2],koef,NULLTODEF);
                cdsView.FieldByName('h0300').AsString := dmData.VarToStrDefIsNull(atiRes[3],koef,NULLTODEF);
                cdsView.FieldByName('h0400').AsString := dmData.VarToStrDefIsNull(atiRes[4],koef,NULLTODEF);
                cdsView.FieldByName('h0500').AsString := dmData.VarToStrDefIsNull(atiRes[5],koef,NULLTODEF);
                cdsView.FieldByName('h0600').AsString := dmData.VarToStrDefIsNull(atiRes[6],koef,NULLTODEF);
                cdsView.FieldByName('h0700').AsString := dmData.VarToStrDefIsNull(atiRes[7],koef,NULLTODEF);
                cdsView.FieldByName('h0800').AsString := dmData.VarToStrDefIsNull(atiRes[8],koef,NULLTODEF);
                cdsView.FieldByName('h0900').AsString := dmData.VarToStrDefIsNull(atiRes[9],koef,NULLTODEF);
                cdsView.FieldByName('h1000').AsString := dmData.VarToStrDefIsNull(atiRes[10],koef,NULLTODEF);
                cdsView.FieldByName('h1100').AsString := dmData.VarToStrDefIsNull(atiRes[11],koef,NULLTODEF);
                cdsView.FieldByName('h1200').AsString := dmData.VarToStrDefIsNull(atiRes[12],koef,NULLTODEF);
                cdsView.FieldByName('h1300').AsString := dmData.VarToStrDefIsNull(atiRes[13],koef,NULLTODEF);
                cdsView.FieldByName('h1400').AsString := dmData.VarToStrDefIsNull(atiRes[14],koef,NULLTODEF);
                cdsView.FieldByName('h1500').AsString := dmData.VarToStrDefIsNull(atiRes[15],koef,NULLTODEF);
                cdsView.FieldByName('h1600').AsString := dmData.VarToStrDefIsNull(atiRes[16],koef,NULLTODEF);
                cdsView.FieldByName('h1700').AsString := dmData.VarToStrDefIsNull(atiRes[17],koef,NULLTODEF);
                cdsView.FieldByName('h1800').AsString := dmData.VarToStrDefIsNull(atiRes[18],koef,NULLTODEF);
                cdsView.FieldByName('h1900').AsString := dmData.VarToStrDefIsNull(atiRes[19],koef,NULLTODEF);
                cdsView.FieldByName('h2000').AsString := dmData.VarToStrDefIsNull(atiRes[20],koef,NULLTODEF);
                cdsView.FieldByName('h2100').AsString := dmData.VarToStrDefIsNull(atiRes[21],koef,NULLTODEF);
                cdsView.FieldByName('h2200').AsString := dmData.VarToStrDefIsNull(atiRes[22],koef,NULLTODEF);
                cdsView.FieldByName('h2300').AsString := dmData.VarToStrDefIsNull(atiRes[23],koef,NULLTODEF);
                cdsView.Post;
                aq.Next;
              end;
              aq.Next;
            end
            else
            begin
              { TODO : error: нет точек для отправки }
            end;
          finally
            aq.Free;
          end;
          aq_a.Next;
        end;
      end
      else
      begin
        { TODO : error: нет зон для отправки }
      end;
    finally
      aq_a.Free;
    end;
  finally
    atiRes := nil;
    cdsView.EnableControls;
    cxGrid1.EndUpdate;
    HideProcessCancel;
  end;   
end;

procedure TfrmPreview.ExportData;
const
  xlRight=4294963144;
  xlCenter = -4108;
  xlLandscape = 2;
  xlContinuous = 1;
  xlThin = 2;
  xlEdgeBottom = 9;
  xlEdgeLeft = 7;
  xlEdgeRight = 10;
  xlEdgeTop = 8;
  xlMedium = -4138;
var
  XL,nm2: Variant;
  i: Integer;
//  k: Integer;
//  num: Integer;
//  pred: string;
  dt: TDateTime;
begin
  DateToStr(dxBarDateCombo1.Date);
  SaveDialog1.InitialDir := sPath;
  SaveDialog1.FileName := 'mrdu_'+DateToStr(dt)+'.xls';
  if SaveDialog1.Execute then
  begin
  try try
    ShowProcessCancel(Application.MainForm,'Сохранение данных...');
    Application.ProcessMessages;
    XL := CreateOleObject('Excel.Application');
    XL.DisplayAlerts := False;
    XL.Visible := False;        //Видимость окна Excel
    XL.Workbooks.Add();
    for i := XL.Workbooks[1].Worksheets.Count downto 2 do
      XL.Workbooks[1].Worksheets[i].Delete;

    XL.Workbooks[1].Worksheets[1].Name:=DateToStr(dt);
    XL.Workbooks[1].Worksheets[1].PageSetup.Orientation := xlLandscape;

// Cells[строка, столбэц]
// Columns['A:A']. ColumnWidth := 40; ширина колонки
// XL.Workbooks[1].Worksheets[1].Columns['A:A'].ColumnWidth := 40;

    XL.Workbooks[1].Worksheets[1].Columns['A:A'].ColumnWidth := 30;
    i:=2;
      XL.Workbooks[1].Worksheets[1].Cells[i,1] := 'Название ТИ';
      XL.Workbooks[1].Worksheets[1].Cells[i,2] := 'с 00 до 01';
      XL.Workbooks[1].Worksheets[1].Cells[i,3] := 'с 01 до 02';
      XL.Workbooks[1].Worksheets[1].Cells[i,4] := 'с 02 до 03';
      XL.Workbooks[1].Worksheets[1].Cells[i,5] := 'с 03 до 04';
      XL.Workbooks[1].Worksheets[1].Cells[i,6] := 'с 04 до 05';
      XL.Workbooks[1].Worksheets[1].Cells[i,7] := 'с 05 до 06';
      XL.Workbooks[1].Worksheets[1].Cells[i,8] := 'с 06 до 07';
      XL.Workbooks[1].Worksheets[1].Cells[i,9] := 'с 07 до 08';
      XL.Workbooks[1].Worksheets[1].Cells[i,10] := 'с 08 до 09';
      XL.Workbooks[1].Worksheets[1].Cells[i,11] := 'с 09 до 10';
      XL.Workbooks[1].Worksheets[1].Cells[i,12] := 'с 10 до 11';
      XL.Workbooks[1].Worksheets[1].Cells[i,13] := 'с 11 до 12';
      XL.Workbooks[1].Worksheets[1].Cells[i,14] := 'с 12 до 13';
      XL.Workbooks[1].Worksheets[1].Cells[i,15] := 'с 13 до 14';
      XL.Workbooks[1].Worksheets[1].Cells[i,16] := 'с 14 до 15';
      XL.Workbooks[1].Worksheets[1].Cells[i,17] := 'с 15 до 16';
      XL.Workbooks[1].Worksheets[1].Cells[i,18] := 'с 16 до 17';
      XL.Workbooks[1].Worksheets[1].Cells[i,19] := 'с 17 до 18';
      XL.Workbooks[1].Worksheets[1].Cells[i,20] := 'с 18 до 19';
      XL.Workbooks[1].Worksheets[1].Cells[i,21] := 'с 19 до 20';
      XL.Workbooks[1].Worksheets[1].Cells[i,22] := 'с 20 до 21';
      XL.Workbooks[1].Worksheets[1].Cells[i,23] := 'с 21 до 22';
      XL.Workbooks[1].Worksheets[1].Cells[i,24] := 'с 22 до 23';
      XL.Workbooks[1].Worksheets[1].Cells[i,25] := 'с 23 до 00';

    if not cdsView.Active then
      cdsView.Open;
    cdsView.First;
    while not cdsView.Eof do
    begin
      Inc(i);
      XL.Workbooks[1].Worksheets[1].Cells[i,1] := cdsView.FieldByName('name').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,2] := cdsView.FieldByName('h0000').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,3] := cdsView.FieldByName('h0100').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,4] := cdsView.FieldByName('h0200').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,5] := cdsView.FieldByName('h0300').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,6] := cdsView.FieldByName('h0400').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,7] := cdsView.FieldByName('h0500').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,8] := cdsView.FieldByName('h0600').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,9] := cdsView.FieldByName('h0700').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,10] := cdsView.FieldByName('h0800').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,11] := cdsView.FieldByName('h0900').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,12] := cdsView.FieldByName('h1000').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,13] := cdsView.FieldByName('h1100').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,14] := cdsView.FieldByName('h1200').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,15] := cdsView.FieldByName('h1300').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,16] := cdsView.FieldByName('h1400').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,17] := cdsView.FieldByName('h1500').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,18] := cdsView.FieldByName('h1600').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,19] := cdsView.FieldByName('h1700').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,20] := cdsView.FieldByName('h1800').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,21] := cdsView.FieldByName('h1900').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,22] := cdsView.FieldByName('h2000').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,23] := cdsView.FieldByName('h2100').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,24] := cdsView.FieldByName('h2200').AsString;
      XL.Workbooks[1].Worksheets[1].Cells[i,25] := cdsView.FieldByName('h2300').AsString;
      cdsView.Next;
    end;
    
   //Завершаем работу
    XL.Workbooks[1].SaveAs(SaveDialog1.FileName);
  except
  end;                                              
  finally
    XL.ActiveWorkbook.Close;
    Application.ProcessMessages;
    XL.Quit;//Закрываем Excel
    XL := 0;
    HideProcessCancel;
  end;
end;

end;

procedure TfrmPreview.dxBarButton1Click(Sender: TObject);
begin
  RefreshView;
end;

procedure TfrmPreview.dxBarDateCombo1Change(Sender: TObject);
begin
  ReloadView(dxBarDateCombo1.Date);
end;

procedure TfrmPreview.dxBarButton3Click(Sender: TObject);
begin
  ExportData;
end;

initialization
  RegisterClass(TfrmPreview);
end.
