unit CatParamList;

interface

uses
  Classes, CatParam, ADODB;

type
  TCatParamList = class(TList)
  private
    function Get(Index: Integer): TCatParam;
    procedure Put(Index: Integer; const Value: TCatParam);
  public
    Letters: string;

    procedure Clear; override;
    procedure Fill(Con: TADOConnection);
    function FindCat(Letter: Char): TCatParam;

    function AbbrCat(Letter: Char): string;
    function ValTypeCat(Letter: Char): Integer;

    property Items[Index: Integer]: TCatParam read Get write Put; default;
  end;

implementation

uses
  SysUtils, CatField;

{ TCatParamList }

function TCatParamList.AbbrCat(Letter: Char): string;
var
  x: TCatParam;
begin
  x:=FindCat(Letter);
  if x <> nil then
    Result:=x.Abbr
  else
    Result:='N';
end;

procedure TCatParamList.Clear;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    Items[i].Free;
  inherited;
end;

procedure TCatParamList.Fill(Con: TADOConnection);
var
  Cat:  TCatParam;
  QCat,
  QFld: TADOQuery;
begin
  Clear;
   
  QCat:=TADOQuery.Create(nil);
  QCat.Connection:=Con;
  QCat.SQL.Text:='select Abbr, Letter, Comment, DTable, id, InRTDB, InFormul from OICat';

  QFld:=TADOQuery.Create(nil);
  QFld.Connection:=Con;
  QFld.SQL.Text:='select NnField, RTNameField, RTSizeField, RTTypeField '+
    'from oitype where oicat=:oicat order by NnField';

  Letters:='';
  QCat.Open;
  while not QCat.EOF do begin
    Cat:=TCatParam.Create;
    Cat.Letter:=QCat.FieldByName('Letter').AsString[1];
    Cat.Name:=QCat.FieldByName('Comment').AsString;
    Cat.Abbr:=TrimRight(QCat.FieldByName('Abbr').AsString);
    Cat.Size:=0;
    Cat.DTable:=not QCat.FieldByName('DTable').IsNull;
    Cat.InRTDB:=QCat.FieldByName('InRTDB').AsBoolean;
    Cat.InFrml:=QCat.FieldByName('InFormul').AsBoolean;
    if Cat.DTable then begin
      QFld.Close;
      QFld.Parameters[0].Value:=QCat.FieldByName('ID').AsInteger;
      QFld.Open;
      while not QFld.EOF do begin
        Cat.Add(TCatField.Create(Trim(QFld.FieldByName('RTNameField').AsString),
          QFld.FieldByName('RTTypeField').AsInteger,
          QFld.FieldByName('RTSizeField').AsInteger));
        Cat.Size:=Cat.Size+QFld.FieldByName('RTSizeField').AsInteger;
        QFld.Next;
      end;
      QFld.Close;
    end;
    Add(Cat);
    Letters:=Letters+Cat.Letter;
    QCat.Next;
  end;
  QCat.Free;
  QFld.Free;
end;

function TCatParamList.FindCat(Letter: Char): TCatParam;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do
    if Items[i].Letter = Letter then begin
      Result:=Items[i];
      Break;
    end;    
end;

function TCatParamList.Get(Index: Integer): TCatParam;
begin
  Result:=TCatParam(inherited Get(Index));
end;

procedure TCatParamList.Put(Index: Integer; const Value: TCatParam);
begin
  inherited Put(Index, Value);
end;

function TCatParamList.ValTypeCat(Letter: Char): Integer;
var
  x: TCatParam;
  i: Integer;
begin
  Result:=0;
  x:=FindCat(Letter);
  if x <> nil then
    for i:=0 to x.Count-1 do
      if x[i].Name = 'value' then begin
        Result:=x[i].RType;
        Break;
      end;
end;

end.
