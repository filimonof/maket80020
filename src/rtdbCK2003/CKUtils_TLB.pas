unit CKUtils_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 15.04.2004 14:10:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Views\roman_v3.1\OIK_CommonLib\CKUtils\CKUtils.tlb (1)
// LIBID: {7EFAD6D7-7207-4558-8C09-96241C4121B0}
// LCID: 0
// Helpfile: 
// HelpString: CKUtils Library
// DepndLst: 
//   (1) v2.0 stdole, (D:\WINDOWS\System32\STDOLE2.TLB)
//   (2) v2.1 ADODB, (D:\Program Files\Common Files\System\ADO\msado21.tlb)
//   (3) v2.0 MSXML, (D:\WINDOWS\System32\msxml.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, ADODB_TLB, Classes, Graphics, MSXML_TLB, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CKUtilsMajorVersion = 1;
  CKUtilsMinorVersion = 0;

  LIBID_CKUtils: TGUID = '{7EFAD6D7-7207-4558-8C09-96241C4121B0}';

  IID_IRTDBDialogs: TGUID = '{C7DB1670-CF32-4D3E-9865-1528D6DDD1C1}';
  CLASS_RTDBDialogs: TGUID = '{98F8F2CE-B435-4996-969C-AFDAB7A4A50B}';
  IID_INSIDialogs: TGUID = '{5E97CC8A-6E7F-4479-8AB7-A7A93823826C}';
  CLASS_NSIDialogs: TGUID = '{8E96C3EC-90F8-4DB0-96B6-D6A4B269E0F5}';
  IID_IFrmlMainPrg: TGUID = '{EA23CC13-7AEF-4B87-A1B4-842FA8EB7BB0}';
  IID_IFormula: TGUID = '{6728E0E4-5282-447E-BA60-403F69CC616C}';
  CLASS_Formula: TGUID = '{89DDF792-DFED-437F-9EED-9179A5D32A21}';
  IID_ITranslator: TGUID = '{6C0D54B1-7D67-4AD9-B7F1-BB2EB101C0E9}';
  CLASS_Translator: TGUID = '{E074A399-5CB4-40AC-A213-E8FA3E7ADEA2}';
  IID_IStyle: TGUID = '{C2EC89AC-99EB-4F4F-ADFD-44B42866A471}';
  CLASS_Style: TGUID = '{34C73A16-E847-484E-990A-960CECEB19E2}';
  IID_IFormater: TGUID = '{2FA2002B-4210-4D3E-8AF2-43B2D99FA682}';
  CLASS_Formater: TGUID = '{4886C24B-6620-4595-A812-DDA26E5B092E}';
  IID_IPrintImg: TGUID = '{BCAD6C78-26FB-4A0E-B42B-7097E2F8AEA6}';
  CLASS_PrintImg: TGUID = '{385FE96E-1CB5-4CCC-B3A7-72AA357EED62}';
  IID_IAboutDlg: TGUID = '{001B5BA1-4987-4100-9C01-58A7032A7818}';
  CLASS_AboutDlg: TGUID = '{0F38C62E-4CCE-49B3-8F85-BE5E59DC947E}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum RuchModeEnum
type
  RuchModeEnum = TOleEnum;
const
  rmManual = $00000000;
  rmNoTrust = $00000001;

// Constants for enum FrmlTypeEnum
type
  FrmlTypeEnum = TOleEnum;
const
  ftOperative = $00000000;
  ftUniversal = $00000001;
  ftLocal = $00000002;
  ftAlarm = $00000003;
  ftLocalTopaz = $00000004;

// Constants for enum StyleIdxEnum
type
  StyleIdxEnum = TOleEnum;
const
  siDefault = $00000000;
  siVAP = $00000001;
  siNAP = $00000002;
  siVPP = $00000003;
  siNPP = $00000004;
  siInauth = $00000005;
  siManual = $00000006;
  siRestore = $00000007;
  siRestDistrust = $00000008;
  siDistrust = $00000009;
  siJump = $0000000A;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IRTDBDialogs = interface;
  IRTDBDialogsDisp = dispinterface;
  INSIDialogs = interface;
  INSIDialogsDisp = dispinterface;
  IFrmlMainPrg = interface;
  IFrmlMainPrgDisp = dispinterface;
  IFormula = interface;
  IFormulaDisp = dispinterface;
  ITranslator = interface;
  ITranslatorDisp = dispinterface;
  IStyle = interface;
  IStyleDisp = dispinterface;
  IFormater = interface;
  IFormaterDisp = dispinterface;
  IPrintImg = interface;
  IPrintImgDisp = dispinterface;
  IAboutDlg = interface;
  IAboutDlgDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  RTDBDialogs = IRTDBDialogs;
  NSIDialogs = INSIDialogs;
  Formula = IFormula;
  Translator = ITranslator;
  Style = IStyle;
  Formater = IFormater;
  PrintImg = IPrintImg;
  AboutDlg = IAboutDlg;


// *********************************************************************//
// Interface: IRTDBDialogs
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C7DB1670-CF32-4D3E-9865-1528D6DDD1C1}
// *********************************************************************//
  IRTDBDialogs = interface(IDispatch)
    ['{C7DB1670-CF32-4D3E-9865-1528D6DDD1C1}']
    procedure Set_AppHandle(Param1: Integer); safecall;
    procedure Set_Connection(const Param1: _Connection); safecall;
    procedure Set_RTDBConId(Param1: Integer); safecall;
    procedure DecodeDR(IsFrml: WordBool; const DR: WideString; Time: Integer; Modal: WordBool); safecall;
    procedure OIPassport(Cat: Integer; Id: Integer; Time: Integer; Modal: WordBool); safecall;
    procedure ShowOIData(Cat: Integer; Id: Integer; Modal: WordBool); safecall;
    function SelectDomain(const Caption: WideString): WideString; safecall;
    function SelectRTDB: WideString; safecall;
    function SelectSQL(AskDB: WordBool; const DefDB: WideString): WideString; safecall;
    function SetRuch(Cat: Integer; Id: Integer; Mode: RuchModeEnum): WordBool; safecall;
    function ResetRuch(Cat: Integer; Id: Integer): WordBool; safecall;
    function Get_EventKey: Integer; safecall;
    function SelectManOI(var Cat: Integer; var Id: Integer): WordBool; safecall;
    function IsDomainAccessible(const Domain: WideString): WordBool; safecall;
    procedure ShowListData(const Caption: WideString; Modal: WordBool; const OIList: WideString); safecall;
    function ResetRuchSilent(Cat: Integer; Id: Integer): WordBool; safecall;
    property AppHandle: Integer write Set_AppHandle;
    property Connection: _Connection write Set_Connection;
    property RTDBConId: Integer write Set_RTDBConId;
    property EventKey: Integer read Get_EventKey;
  end;

// *********************************************************************//
// DispIntf:  IRTDBDialogsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C7DB1670-CF32-4D3E-9865-1528D6DDD1C1}
// *********************************************************************//
  IRTDBDialogsDisp = dispinterface
    ['{C7DB1670-CF32-4D3E-9865-1528D6DDD1C1}']
    property AppHandle: Integer writeonly dispid 201;
    property Connection: _Connection writeonly dispid 202;
    property RTDBConId: Integer writeonly dispid 203;
    procedure DecodeDR(IsFrml: WordBool; const DR: WideString; Time: Integer; Modal: WordBool); dispid 204;
    procedure OIPassport(Cat: Integer; Id: Integer; Time: Integer; Modal: WordBool); dispid 205;
    procedure ShowOIData(Cat: Integer; Id: Integer; Modal: WordBool); dispid 206;
    function SelectDomain(const Caption: WideString): WideString; dispid 207;
    function SelectRTDB: WideString; dispid 208;
    function SelectSQL(AskDB: WordBool; const DefDB: WideString): WideString; dispid 209;
    function SetRuch(Cat: Integer; Id: Integer; Mode: RuchModeEnum): WordBool; dispid 210;
    function ResetRuch(Cat: Integer; Id: Integer): WordBool; dispid 211;
    property EventKey: Integer readonly dispid 212;
    function SelectManOI(var Cat: Integer; var Id: Integer): WordBool; dispid 213;
    function IsDomainAccessible(const Domain: WideString): WordBool; dispid 214;
    procedure ShowListData(const Caption: WideString; Modal: WordBool; const OIList: WideString); dispid 215;
    function ResetRuchSilent(Cat: Integer; Id: Integer): WordBool; dispid 216;
  end;

// *********************************************************************//
// Interface: INSIDialogs
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5E97CC8A-6E7F-4479-8AB7-A7A93823826C}
// *********************************************************************//
  INSIDialogs = interface(IDispatch)
    ['{5E97CC8A-6E7F-4479-8AB7-A7A93823826C}']
    procedure Set_AppHandle(Param1: Integer); safecall;
    procedure Set_Connection(const Param1: _Connection); safecall;
    function SelectOI(const CatFilter: WideString; var Cat: Integer; var Id: Integer; 
                      out Name: WideString): WordBool; safecall;
    function SelectStat(var Cat: Integer; var Id: Integer; out Name: WideString; 
                        var StatId: Integer; var StatVal: Integer; var StatPeriod: Integer): WordBool; safecall;
    function SelectEnObj(const Caption: WideString; TopObj: Integer; AllowMulti: WordBool; 
                         var List: WideString): WordBool; safecall;
    function EditFrml(FrmlType: FrmlTypeEnum; var Text: WideString; var AlwaysEval: WordBool; 
                      Modal: WordBool; const AddParams: IXMLDOMDocument; const MainPrg: IFrmlMainPrg): WordBool; safecall;
    procedure CancelEditFrml; safecall;
    procedure AddToFrml(const Text: WideString); safecall;
    function Get_RTDBDlg: IRTDBDialogs; safecall;
    procedure Set_RTDBDlg(const Value: IRTDBDialogs); safecall;
    function SelectRTU(const Caption: WideString; TopRTU: Integer; AllowMulti: WordBool; 
                       var List: WideString): WordBool; safecall;
    function SelectOIFlt(Cat: Integer; var Id: Integer; var Name: WideString; 
                         const Filter: WideString): WordBool; safecall;
    property AppHandle: Integer write Set_AppHandle;
    property Connection: _Connection write Set_Connection;
    property RTDBDlg: IRTDBDialogs read Get_RTDBDlg write Set_RTDBDlg;
  end;

// *********************************************************************//
// DispIntf:  INSIDialogsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5E97CC8A-6E7F-4479-8AB7-A7A93823826C}
// *********************************************************************//
  INSIDialogsDisp = dispinterface
    ['{5E97CC8A-6E7F-4479-8AB7-A7A93823826C}']
    property AppHandle: Integer writeonly dispid 201;
    property Connection: _Connection writeonly dispid 202;
    function SelectOI(const CatFilter: WideString; var Cat: Integer; var Id: Integer; 
                      out Name: WideString): WordBool; dispid 203;
    function SelectStat(var Cat: Integer; var Id: Integer; out Name: WideString; 
                        var StatId: Integer; var StatVal: Integer; var StatPeriod: Integer): WordBool; dispid 204;
    function SelectEnObj(const Caption: WideString; TopObj: Integer; AllowMulti: WordBool; 
                         var List: WideString): WordBool; dispid 205;
    function EditFrml(FrmlType: FrmlTypeEnum; var Text: WideString; var AlwaysEval: WordBool; 
                      Modal: WordBool; const AddParams: IXMLDOMDocument; const MainPrg: IFrmlMainPrg): WordBool; dispid 206;
    procedure CancelEditFrml; dispid 207;
    procedure AddToFrml(const Text: WideString); dispid 208;
    property RTDBDlg: IRTDBDialogs dispid 209;
    function SelectRTU(const Caption: WideString; TopRTU: Integer; AllowMulti: WordBool; 
                       var List: WideString): WordBool; dispid 210;
    function SelectOIFlt(Cat: Integer; var Id: Integer; var Name: WideString; 
                         const Filter: WideString): WordBool; dispid 211;
  end;

// *********************************************************************//
// Interface: IFrmlMainPrg
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EA23CC13-7AEF-4B87-A1B4-842FA8EB7BB0}
// *********************************************************************//
  IFrmlMainPrg = interface(IDispatch)
    ['{EA23CC13-7AEF-4B87-A1B4-842FA8EB7BB0}']
    procedure ParamSelected(const Params: IXMLDOMElement); safecall;
    procedure EditComplete(Success: WordBool; const Text: WideString; AlwaysEval: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IFrmlMainPrgDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EA23CC13-7AEF-4B87-A1B4-842FA8EB7BB0}
// *********************************************************************//
  IFrmlMainPrgDisp = dispinterface
    ['{EA23CC13-7AEF-4B87-A1B4-842FA8EB7BB0}']
    procedure ParamSelected(const Params: IXMLDOMElement); dispid 201;
    procedure EditComplete(Success: WordBool; const Text: WideString; AlwaysEval: WordBool); dispid 202;
  end;

// *********************************************************************//
// Interface: IFormula
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6728E0E4-5282-447E-BA60-403F69CC616C}
// *********************************************************************//
  IFormula = interface(IDispatch)
    ['{6728E0E4-5282-447E-BA60-403F69CC616C}']
    function Get_Count: Integer; safecall;
    procedure Set_Count(Value: Integer); safecall;
    function Get_OIVal(index: Integer): Double; safecall;
    procedure Set_OIVal(index: Integer; Value: Double); safecall;
    function Get_AlwaysEval: WordBool; safecall;
    procedure Set_AlwaysEval(Value: WordBool); safecall;
    function Get_Id: Integer; safecall;
    procedure Set_Id(Value: Integer); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Value: WideString); safecall;
    function Get_OI(index: Integer): WideString; safecall;
    procedure Set_OI(index: Integer; const Value: WideString); safecall;
    function Get_Cod: WideString; safecall;
    procedure Set_Cod(const Value: WideString); safecall;
    function Get_Success: WordBool; safecall;
    procedure Set_Success(Value: WordBool); safecall;
    function Get_Notch: Integer; safecall;
    procedure Set_Notch(Value: Integer); safecall;
    procedure Reset; safecall;
    function GetOI(index: Integer; out OICat: Shortint; out OIId: Integer; out TShift: Integer): WordBool; safecall;
    function Get_TShift(index: Integer): Integer; safecall;
    procedure Set_TShift(index: Integer; Value: Integer); safecall;
    procedure Evaluate(out Value: Double; out Prizn: LongWord); safecall;
    procedure AssignFrml(const Src: IFormula); safecall;
    function Get_OIList: WideString; safecall;
    procedure Set_OIList(const Value: WideString); safecall;
    function Get_OIPrizn(index: Integer): Integer; safecall;
    procedure Set_OIPrizn(index: Integer; Value: Integer); safecall;
    function SaveXML(const Root: IXMLDOMElement): WordBool; safecall;
    function LoadXML(const Elem: IXMLDOMElement): WordBool; safecall;
    property Count: Integer read Get_Count write Set_Count;
    property OIVal[index: Integer]: Double read Get_OIVal write Set_OIVal;
    property AlwaysEval: WordBool read Get_AlwaysEval write Set_AlwaysEval;
    property Id: Integer read Get_Id write Set_Id;
    property Text: WideString read Get_Text write Set_Text;
    property OI[index: Integer]: WideString read Get_OI write Set_OI;
    property Cod: WideString read Get_Cod write Set_Cod;
    property Success: WordBool read Get_Success write Set_Success;
    property Notch: Integer read Get_Notch write Set_Notch;
    property TShift[index: Integer]: Integer read Get_TShift write Set_TShift;
    property OIList: WideString read Get_OIList write Set_OIList;
    property OIPrizn[index: Integer]: Integer read Get_OIPrizn write Set_OIPrizn;
  end;

// *********************************************************************//
// DispIntf:  IFormulaDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6728E0E4-5282-447E-BA60-403F69CC616C}
// *********************************************************************//
  IFormulaDisp = dispinterface
    ['{6728E0E4-5282-447E-BA60-403F69CC616C}']
    property Count: Integer dispid 201;
    property OIVal[index: Integer]: Double dispid 202;
    property AlwaysEval: WordBool dispid 203;
    property Id: Integer dispid 204;
    property Text: WideString dispid 205;
    property OI[index: Integer]: WideString dispid 206;
    property Cod: WideString dispid 207;
    property Success: WordBool dispid 208;
    property Notch: Integer dispid 209;
    procedure Reset; dispid 210;
    function GetOI(index: Integer; out OICat: {??Shortint}OleVariant; out OIId: Integer; 
                   out TShift: Integer): WordBool; dispid 211;
    property TShift[index: Integer]: Integer dispid 213;
    procedure Evaluate(out Value: Double; out Prizn: LongWord); dispid 214;
    procedure AssignFrml(const Src: IFormula); dispid 212;
    property OIList: WideString dispid 215;
    property OIPrizn[index: Integer]: Integer dispid 216;
    function SaveXML(const Root: IXMLDOMElement): WordBool; dispid 217;
    function LoadXML(const Elem: IXMLDOMElement): WordBool; dispid 218;
  end;

// *********************************************************************//
// Interface: ITranslator
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C0D54B1-7D67-4AD9-B7F1-BB2EB101C0E9}
// *********************************************************************//
  ITranslator = interface(IDispatch)
    ['{6C0D54B1-7D67-4AD9-B7F1-BB2EB101C0E9}']
    function TranslateFrml(const Formula: IFormula): WordBool; safecall;
    procedure Set_Connection(const Param1: _Connection); safecall;
    function TranslateArray(FrmlArray: OleVariant): WordBool; safecall;
    property Connection: _Connection write Set_Connection;
  end;

// *********************************************************************//
// DispIntf:  ITranslatorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {6C0D54B1-7D67-4AD9-B7F1-BB2EB101C0E9}
// *********************************************************************//
  ITranslatorDisp = dispinterface
    ['{6C0D54B1-7D67-4AD9-B7F1-BB2EB101C0E9}']
    function TranslateFrml(const Formula: IFormula): WordBool; dispid 201;
    property Connection: _Connection writeonly dispid 202;
    function TranslateArray(FrmlArray: OleVariant): WordBool; dispid 203;
  end;

// *********************************************************************//
// Interface: IStyle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C2EC89AC-99EB-4F4F-ADFD-44B42866A471}
// *********************************************************************//
  IStyle = interface(IDispatch)
    ['{C2EC89AC-99EB-4F4F-ADFD-44B42866A471}']
    procedure SelectStyle(Id: Integer); safecall;
    function Get_Name: WideString; safecall;
    function Get_Id: Integer; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_FontName: WideString; safecall;
    function Get_FontSize: Integer; safecall;
    function Get_FontColor: OLE_COLOR; safecall;
    function Get_FontItalic: WordBool; safecall;
    function Get_FontBold: WordBool; safecall;
    function Get_FontUnderline: WordBool; safecall;
    function Get_FontStrikeOut: WordBool; safecall;
    function SelectFromList(Id: Integer): WordBool; safecall;
    procedure Set_AppHandle(Param1: Integer); safecall;
    property Name: WideString read Get_Name;
    property Id: Integer read Get_Id;
    property Color: OLE_COLOR read Get_Color;
    property FontName: WideString read Get_FontName;
    property FontSize: Integer read Get_FontSize;
    property FontColor: OLE_COLOR read Get_FontColor;
    property FontItalic: WordBool read Get_FontItalic;
    property FontBold: WordBool read Get_FontBold;
    property FontUnderline: WordBool read Get_FontUnderline;
    property FontStrikeOut: WordBool read Get_FontStrikeOut;
    property AppHandle: Integer write Set_AppHandle;
  end;

// *********************************************************************//
// DispIntf:  IStyleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C2EC89AC-99EB-4F4F-ADFD-44B42866A471}
// *********************************************************************//
  IStyleDisp = dispinterface
    ['{C2EC89AC-99EB-4F4F-ADFD-44B42866A471}']
    procedure SelectStyle(Id: Integer); dispid 201;
    property Name: WideString readonly dispid 202;
    property Id: Integer readonly dispid 203;
    property Color: OLE_COLOR readonly dispid 204;
    property FontName: WideString readonly dispid 205;
    property FontSize: Integer readonly dispid 206;
    property FontColor: OLE_COLOR readonly dispid 207;
    property FontItalic: WordBool readonly dispid 208;
    property FontBold: WordBool readonly dispid 209;
    property FontUnderline: WordBool readonly dispid 210;
    property FontStrikeOut: WordBool readonly dispid 211;
    function SelectFromList(Id: Integer): WordBool; dispid 212;
    property AppHandle: Integer writeonly dispid 213;
  end;

// *********************************************************************//
// Interface: IFormater
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FA2002B-4210-4D3E-8AF2-43B2D99FA682}
// *********************************************************************//
  IFormater = interface(IDispatch)
    ['{2FA2002B-4210-4D3E-8AF2-43B2D99FA682}']
    function FormatValue(Value: OleVariant; Prizn: LongWord; const FormatStr: WideString; 
                         PriznInStr: LongWord; Styles: PSafeArray): WideString; safecall;
    function Get_ValueStyle: IStyle; safecall;
    function FormatTime(const Fmt: WideString; Time: TDateTime): WideString; safecall;
    property ValueStyle: IStyle read Get_ValueStyle;
  end;

// *********************************************************************//
// DispIntf:  IFormaterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FA2002B-4210-4D3E-8AF2-43B2D99FA682}
// *********************************************************************//
  IFormaterDisp = dispinterface
    ['{2FA2002B-4210-4D3E-8AF2-43B2D99FA682}']
    function FormatValue(Value: OleVariant; Prizn: LongWord; const FormatStr: WideString; 
                         PriznInStr: LongWord; Styles: {??PSafeArray}OleVariant): WideString; dispid 201;
    property ValueStyle: IStyle readonly dispid 202;
    function FormatTime(const Fmt: WideString; Time: TDateTime): WideString; dispid 203;
  end;

// *********************************************************************//
// Interface: IPrintImg
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BCAD6C78-26FB-4A0E-B42B-7097E2F8AEA6}
// *********************************************************************//
  IPrintImg = interface(IDispatch)
    ['{BCAD6C78-26FB-4A0E-B42B-7097E2F8AEA6}']
    procedure Set_AppHandle(Param1: Integer); safecall;
    procedure Print(Image: Integer); safecall;
    property AppHandle: Integer write Set_AppHandle;
  end;

// *********************************************************************//
// DispIntf:  IPrintImgDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BCAD6C78-26FB-4A0E-B42B-7097E2F8AEA6}
// *********************************************************************//
  IPrintImgDisp = dispinterface
    ['{BCAD6C78-26FB-4A0E-B42B-7097E2F8AEA6}']
    property AppHandle: Integer writeonly dispid 201;
    procedure Print(Image: Integer); dispid 202;
  end;

// *********************************************************************//
// Interface: IAboutDlg
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {001B5BA1-4987-4100-9C01-58A7032A7818}
// *********************************************************************//
  IAboutDlg = interface(IDispatch)
    ['{001B5BA1-4987-4100-9C01-58A7032A7818}']
    procedure Show(Modal: WordBool); safecall;
    procedure Set_AppHandle(Param1: Integer); safecall;
    procedure CanNotUse(const Title: WideString); safecall;
    procedure LicUsage(const Title: WideString; const OrgName: WideString; Current: Integer; 
                       Maximum: Integer); safecall;
    procedure ShowModule(const Module: WideString; Modal: WordBool); safecall;
    property AppHandle: Integer write Set_AppHandle;
  end;

// *********************************************************************//
// DispIntf:  IAboutDlgDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {001B5BA1-4987-4100-9C01-58A7032A7818}
// *********************************************************************//
  IAboutDlgDisp = dispinterface
    ['{001B5BA1-4987-4100-9C01-58A7032A7818}']
    procedure Show(Modal: WordBool); dispid 201;
    property AppHandle: Integer writeonly dispid 202;
    procedure CanNotUse(const Title: WideString); dispid 203;
    procedure LicUsage(const Title: WideString; const OrgName: WideString; Current: Integer; 
                       Maximum: Integer); dispid 204;
    procedure ShowModule(const Module: WideString; Modal: WordBool); dispid 205;
  end;

// *********************************************************************//
// The Class CoRTDBDialogs provides a Create and CreateRemote method to          
// create instances of the default interface IRTDBDialogs exposed by              
// the CoClass RTDBDialogs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRTDBDialogs = class
    class function Create: IRTDBDialogs;
    class function CreateRemote(const MachineName: string): IRTDBDialogs;
  end;

// *********************************************************************//
// The Class CoNSIDialogs provides a Create and CreateRemote method to          
// create instances of the default interface INSIDialogs exposed by              
// the CoClass NSIDialogs. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoNSIDialogs = class
    class function Create: INSIDialogs;
    class function CreateRemote(const MachineName: string): INSIDialogs;
  end;

// *********************************************************************//
// The Class CoFormula provides a Create and CreateRemote method to          
// create instances of the default interface IFormula exposed by              
// the CoClass Formula. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFormula = class
    class function Create: IFormula;
    class function CreateRemote(const MachineName: string): IFormula;
  end;

// *********************************************************************//
// The Class CoTranslator provides a Create and CreateRemote method to          
// create instances of the default interface ITranslator exposed by              
// the CoClass Translator. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTranslator = class
    class function Create: ITranslator;
    class function CreateRemote(const MachineName: string): ITranslator;
  end;

// *********************************************************************//
// The Class CoStyle provides a Create and CreateRemote method to          
// create instances of the default interface IStyle exposed by              
// the CoClass Style. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoStyle = class
    class function Create: IStyle;
    class function CreateRemote(const MachineName: string): IStyle;
  end;

// *********************************************************************//
// The Class CoFormater provides a Create and CreateRemote method to          
// create instances of the default interface IFormater exposed by              
// the CoClass Formater. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFormater = class
    class function Create: IFormater;
    class function CreateRemote(const MachineName: string): IFormater;
  end;

// *********************************************************************//
// The Class CoPrintImg provides a Create and CreateRemote method to          
// create instances of the default interface IPrintImg exposed by              
// the CoClass PrintImg. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPrintImg = class
    class function Create: IPrintImg;
    class function CreateRemote(const MachineName: string): IPrintImg;
  end;

// *********************************************************************//
// The Class CoAboutDlg provides a Create and CreateRemote method to          
// create instances of the default interface IAboutDlg exposed by              
// the CoClass AboutDlg. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAboutDlg = class
    class function Create: IAboutDlg;
    class function CreateRemote(const MachineName: string): IAboutDlg;
  end;

implementation

uses ComObj;

class function CoRTDBDialogs.Create: IRTDBDialogs;
begin
  Result := CreateComObject(CLASS_RTDBDialogs) as IRTDBDialogs;
end;

class function CoRTDBDialogs.CreateRemote(const MachineName: string): IRTDBDialogs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_RTDBDialogs) as IRTDBDialogs;
end;

class function CoNSIDialogs.Create: INSIDialogs;
begin
  Result := CreateComObject(CLASS_NSIDialogs) as INSIDialogs;
end;

class function CoNSIDialogs.CreateRemote(const MachineName: string): INSIDialogs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_NSIDialogs) as INSIDialogs;
end;

class function CoFormula.Create: IFormula;
begin
  Result := CreateComObject(CLASS_Formula) as IFormula;
end;

class function CoFormula.CreateRemote(const MachineName: string): IFormula;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Formula) as IFormula;
end;

class function CoTranslator.Create: ITranslator;
begin
  Result := CreateComObject(CLASS_Translator) as ITranslator;
end;

class function CoTranslator.CreateRemote(const MachineName: string): ITranslator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Translator) as ITranslator;
end;

class function CoStyle.Create: IStyle;
begin
  Result := CreateComObject(CLASS_Style) as IStyle;
end;

class function CoStyle.CreateRemote(const MachineName: string): IStyle;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Style) as IStyle;
end;

class function CoFormater.Create: IFormater;
begin
  Result := CreateComObject(CLASS_Formater) as IFormater;
end;

class function CoFormater.CreateRemote(const MachineName: string): IFormater;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Formater) as IFormater;
end;

class function CoPrintImg.Create: IPrintImg;
begin
  Result := CreateComObject(CLASS_PrintImg) as IPrintImg;
end;

class function CoPrintImg.CreateRemote(const MachineName: string): IPrintImg;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PrintImg) as IPrintImg;
end;

class function CoAboutDlg.Create: IAboutDlg;
begin
  Result := CreateComObject(CLASS_AboutDlg) as IAboutDlg;
end;

class function CoAboutDlg.CreateRemote(const MachineName: string): IAboutDlg;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AboutDlg) as IAboutDlg;
end;

end.
