unit CatField;

interface

type
  TCatField = class
  private
    FName:  string;
    FRType: Cardinal;
    FRSize: Cardinal;
  public
    constructor Create(Name: string; RType, RSize: Cardinal);

    property Name: string read FName;
    property RType: Cardinal read FRType;
    property RSize: Cardinal read FRSize;
  end;

implementation

{ TCatField }

constructor TCatField.Create(Name: string; RType, RSize: Cardinal);
begin
  FName:=Name;
  FRType:=RType;
  FRSize:=RSize;
end;

end.
