program m80020;

uses
  Forms,
  MidasLib,
  frmMain_u in 'frmMain_u.pas' {frmMain},
  uVar in 'uVar.pas',
  uLog in 'uLog.pas',
  frmLogList_u in 'frmLogList_u.pas' {frmLogList},
  dmData_u in 'dmData_u.pas' {dmData: TDataModule},
  dlgProcess_u in 'dlgProcess_u.pas' {dlgProcess},
  cvProgress in 'cvProgress.pas',
  uAdoUtils in 'uAdoUtils.pas',
  dlgOptionsMaket_u in 'dlgOptionsMaket_u.pas' {dlgOptionsMaket},
  dlgGetDate_u in 'dlgGetDate_u.pas' {dlgGetDate},
  dlgOptionsDB_u in 'dlgOptionsDB_u.pas' {dlgOptionsDB},
  dlgInputSQLPas_u in 'dlgInputSQLPas_u.pas' {dlgInputSQLPas},
  dlgAbout_u in 'dlgAbout_u.pas' {dlgAbout},
  frmPreview_u in 'frmPreview_u.pas' {frmPreview},
  dlgPlanCalculate_u in 'dlgPlanCalculate_u.pas' {dlgPlanCalculate},
  ck7GetData in 'ck7GetData\ck7GetData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
