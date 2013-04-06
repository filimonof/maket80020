unit CatParam;

interface

uses
  ADODB, SysUtils, Classes, CatField;

type
  TCatParam = class(TList)
  private
    function GetFields(Index: Integer): TCatField;
    procedure SetFields(Index: Integer; const Value: TCatField);
  public
    Letter:   Char;
    Abbr:     string;
    Name:     string;
    Size:     Cardinal;

    DTable:   Boolean;
    InRTDB:   Boolean;
    InFrml:   Boolean;

    procedure Clear; override;

    property Fields[Index: Integer]: TCatField read GetFields write SetFields; default;

    procedure GetValFromBuf(Buff: Pointer; var Ofs: Cardinal;
      out Value: Double; out Prizn: Cardinal);
    procedure WriteValToBuf(Buff: Pointer; var Ofs: Cardinal; Value: Double;
      Prizn: Cardinal);
  end;

implementation

{ TQryClass }

procedure TCatParam.Clear;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    Fields[i].Free;
  inherited;
end;

function TCatParam.GetFields(Index: Integer): TCatField;
begin
  Result:=TCatField(Items[Index]);
end;

procedure TCatParam.GetValFromBuf(Buff: Pointer; var Ofs: Cardinal;
  out Value: Double; out Prizn: Cardinal);
var
  i: Integer;
  x: Extended;
begin
  Value:=0;
  Prizn:=0;
  for i:=2 to Count-1 do begin
    x:=0;
    case Fields[i].RType of  // получаем значение ОИ
      1:
        x:=PByte(Cardinal(Buff)+Ofs)^;
      2:
        x:=PWord(Cardinal(Buff)+Ofs)^;
      3:
        x:=PSmallInt(Cardinal(Buff)+Ofs)^;
      4:
        x:=PCardinal(Cardinal(Buff)+Ofs)^;
      5:
        x:=PInteger(Cardinal(Buff)+Ofs)^;
      6:
        x:=PSingle(Cardinal(Buff)+Ofs)^;
      8:
        x:=PDouble(Cardinal(Buff)+Ofs)^;
      9:
        x:=PInt64(Cardinal(Buff)+Ofs)^;
    end;
    Inc(Ofs, Fields[i].RSize);

    try
      if Fields[i].Name = 'value' then
        Value:=x
      else if Fields[i].Name = 'prizn' then
        Prizn:=Round(x);
    except end;
  end;
end;

procedure TCatParam.SetFields(Index: Integer; const Value: TCatField);
begin
  Items[Index]:=Value;
end;

procedure TCatParam.WriteValToBuf(Buff: Pointer; var Ofs: Cardinal;
  Value: Double; Prizn: Cardinal);
var
  iv: Int64;
  fv: Double;
  i:  Integer;
begin
  for i:=2 to Count-1 do begin
    if Fields[i].Name = 'value' then begin
      iv:=Round(Value);
      fv:=Value;
    end else if Fields[i].Name = 'prizn' then begin
      iv:=Prizn;
      fv:=Prizn;
    end else begin
      iv:=0;
      fv:=0;
    end;

    case Fields[i].RType of
      1:
        PByte(Cardinal(Buff)+Ofs)^:=iv;
      2:
        PWord(Cardinal(Buff)+Ofs)^:=iv;
      3:
        PSmallInt(Cardinal(Buff)+Ofs)^:=iv;
      4:
        PCardinal(Cardinal(Buff)+Ofs)^:=iv;
      5:
        PInteger(Cardinal(Buff)+Ofs)^:=iv;
      6:
        PSingle(Cardinal(Buff)+Ofs)^:=fv;
      8:
        PDouble(Cardinal(Buff)+Ofs)^:=fv;
      9:
        PInt64(Cardinal(Buff)+Ofs)^:=iv;
    end;
    Inc(Ofs, Fields[i].RSize);
  end;
end;

end.
