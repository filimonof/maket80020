unit RTDB;                         // ������ RTDBCon.dll

interface

uses
  Windows, Messages;

const
  ERR_QUERY_OK		         = 0;
  ERR_QUERY_NOSERVICE	     = 1;
  ERR_QUERY_NOPERM	       = 2;
  ERR_QUERY_ABORT	         = 3;
  RTDBCON_QUERY_ABORT	     = 4;
  RTDBCON_CONNECTION_CLOSE = 5;

  RTDB_MSG_STOP            = 901;
  RTDB_MSG_STRING          = 910;
  RTDB_CLOSE_USER	         = 998;  //���������� �� ������� ���� �� ��������� ������� ��������

  RTDB_LICENCE_CHANGE      = 965;
  RTDB_LICENCE_DEMO        = 966;
  RTDB_LICENCE_OVER        = 967;

  RTDB_SETDOIK             = 5100;

  RTDB_MSG_DATA_RECEIVE    = 1001; //������������� ��������� �������

  RTDB_EVENT               = WM_USER+200;  // ��������� �������

  LIST_SUCCESS		         = 0;      //����� �������� �������
  LIST_ERR_CONNECT         = 1;      //������ ��� ���������� � �������� ���������� ���
  LIST_ERR_SIZE		         = 2;      //������������ ������ �������
  LIST_SMALL_SIZE	         = 3;      //��������� ������ �������
  LIST_ERR_COPY		         = 4;      //������ ��� ����������� ��������

    //������ �������� � ����
  QUERY_TI_REFRESH_NUMBER  = 103;
  QUERY_TS_REFRESH_NUMBER  = 203;

  EV_TI_RUCHON             = 620;    // ��� ������� ���������� �� ������
  EV_TI_RUCHOFF            = 610;    // ��� ������� ������ � �������

  EV_TS_RUCHON             = 630;    // ��� ������� ���������� �� ������
  EV_TS_RUCHOFF            = 640;    // ��� ������� ������ � �������

  //����� � ��������� ��� ��������� �������
  EV_REST                  = $00000001;              //0-� ��� - 0-������� ������������ ��������������
  EV_KVIT                  = $00000002;              //1-� ��� - ������������
  EV_WARN                  = $00000010;              //4-� ��� - �������� ���������������
  EV_ARCH                  = $00000020;              //5-� ��� - 1-������� ������������
  EV_RTDB                  = $00000040;              //6-� ��� - 1-������ � �� ��

  EV_SETMARK               = 1500;
  EV_REMOVEMARK            = 1510;
  EV_EDITMARK              = 1520;

  //����� �������
  EV_PRED_VOSTAN           = $00000001;  // ������������ ��������������
  EV_PRED_KVITIR           = $00000002;  // ������������ ������������
  EV_VOSTANOVLEN           = $00000004;  // �������������
  EV_KVITIROVANO           = $00000008;  // �����������
  EV_PREDUPREGDE           = $00000010;  // �������� ���������������;
  EV_WRITE_SQL             = $00000020;  // ������� ������������� � ���
  EV_WRITE_RTDB            = $00000040;  // ������� ������ � ����
  EV_LMT_VOLTAGE           = $00000080;  // ������������  ��������� �������� �� ����������
  EV_LMT_SECT              = $00000100;  // ������������  ��������� �������� �� ��������
  EV_OPERATE_AUTOMATION    = $00000200;  // ������������� ������������ ����������

  MaxListSize = MaxInt div 16;

type
  PSChar    = ^Char;
  PWORD     = ^WORD;
  PSmallInt = ^SmallInt;
  PCardinal = ^Cardinal;
  PInteger  = ^Integer;
  PSingle   = ^Single;

  TOI_Id = record
    Cat: Cardinal;
    Id:  Cardinal;
  end;
  POIId = ^TOI_Id;
  OIIdArray = array of TOI_Id;
  OIIdMass  = array[0..999] of TOI_Id;
  POIIdArray = ^OIIdMass;

  OI_Tstamp_Id = record
    cat   : Cardinal;
    tstamp: Cardinal;
    id    : Cardinal;
  end;
  OI_TStamp_IdArray  = array[0..MaxListSize - 1] of OI_Tstamp_Id;
  POI_TStamp_IdArray = ^OI_Tstamp_IdArray;
  OITimeArray = array of OI_TStamp_Id;

  Data_Size = record     
    Ptr:    Pointer;
    size:   Cardinal;
  end;
  PData_Size = ^Data_Size;

  TIRec = record
    tstamp: Cardinal;
    number: Cardinal;
    value:  Single;
    prizn:  Cardinal;
  end;

  TSrec = record
    tstamp: Cardinal;
    number: Cardinal;
    value:  SmallInt;
    prizn:  WORD;        
  end;

  DRrec = record
    Tstamp: Cardinal;
    Number: Cardinal;
    Value:  Double;
    Prizn:  Cardinal;
  end;

  PLrec = record
    TStamp: Cardinal;
    Number: Cardinal;
    Value:  Double;
    Prizn:  Cardinal;
  end;

  EIrec = record
    TStamp: Cardinal;
    Number: Cardinal;
    Value:  Double;
    Prizn:  Cardinal;
  end;

  SPRec = record
    TStamp: Cardinal;
    Number: Cardinal;
    Value:  Single;
    Prizn:  Cardinal;
  end;

  MCKRec = record
    TStamp: Cardinal;
    Number: Cardinal;
    Value:  Cardinal;
    Prizn:  Cardinal;
  end;

  MaskRec = record
    Tstamp: Cardinal;	//����� �������
    Number: Cardinal;	//id ��
    Value:  Cardinal;	//�������� ��
    Prizn:  Cardinal;	//��������
  end;

    // ���������� ������
  SyncQuery = record
    typ:        Cardinal;
    oicat:      Char;
    no_answer:  Cardinal;
    TStart:     Cardinal;
    TStop:      Cardinal;
    step:       Cardinal;
    number:     Cardinal;
    mask:       Cardinal;
    mask_send:  WORD;
    mask_on:    WORD;
    query_size: Cardinal;
    query_buf:  Pointer;
  end;
  PSyncQuery = ^SyncQuery;

    // ����������� ������
  AsyncQuery = record
    typ:        Cardinal;                   //��� �������
    oicat:      Char ;                      //��������� ��
    TStart:     Cardinal;                   //����� �
    TStop:      Cardinal;                   //����� ��
    step:       Cardinal;                       //��� �� �������
    number:     Cardinal;                       //����������
    mask:       Cardinal;                   //�����
    mask_send:  WORD;
    mask_on:    WORD;
    query_size: Cardinal;
    query_buf:  Pointer;
    Handle:     THandle;
    is_thread:  Integer;                    // true - Thread, False - Window
    msg:        Cardinal;                   //����� ������������� ��������
    answer_size:Cardinal;
    answer_buf: Pointer;                    //���� �������
  end;
  PAsyncQuery = ^AsyncQuery;

  SendQObj = record                 // ��������� - ��������� �������������� ���������� �������(������33)
    idEv:  Cardinal;
    idObj: Cardinal
  end;

    // ������� �������
  {$A-}
  EV_Filtr_HD = record                  // ������ �� ������� ��������
    Newfiltr: Byte;                           //0-�������� � ������ ��������  1- ������� ������ ������
    Cont    : Byte;                           //0-������ ������ �������  1-��  ���������  2-�����
    Filtr   : Byte;                           //0-���. � �������  1-�� ���� � �������
    Typ     : Byte;                           //0-��������� �������  1-������� �������� �������  3-���� �������
  end;
  {$A+}

  EvFiltr = record                   // ������ �� ������� ��������
    Head:     EV_Filtr_HD;
    DblMas:   array [0..100] of Cardinal;
  end;

  EventKatQueryRec = record                   // ������ � �� �� �� ��������� ������� �� ����������
    type_str:   Cardinal;
    field:      Cardinal;
    Ids:        array[0..2000] of Cardinal;
  end;
  PEventKatQuery = ^EventKatQueryRec;

    // ��������� �������
  EvValMassiv = array [0..MaxListSize] of Double;
  PDoubleMas = ^EvValMassiv;

  EVENTSTRUCT = record     // ��������� ��� ���������� ���������� ������
    tstamp  :Cardinal ;  // ����� �������
    id_ev   :Cardinal ;  // ������������� ������� (������������ ����������, ��������������� �������);
    length  :Cardinal ;  // ����� ����� ��������
    parCount:WORD     ;  // ���������� ����������
    flags   :WORD     ;  // �������� ������ (������������ ����������, ��������������� �������);
    id_obj  :Cardinal ;  // ������������� ������� �� (��, ��...)
    ncon    :Cardinal ;  // ����� ���������� � ���� - ����������� ��������
    kps     :Cardinal ;  // ��� ���������� ���
    EvKey   :Cardinal ;  // ���������� ����� ������� (��������������� ����������, ��������������� �������);
    id_eobj :Cardinal ;  // ���� �������������
    id_prg  :Cardinal ;  // ������������� ���������
    id_usr  :Cardinal ;  // ������������� �����������
    kat     :WORD     ;  // ��������� (��� Kat=0, �������� ������������� ����������� ��������� �������)
    level   :WORD     ;  // ������� �������� (��� level=0, �������� ������������� ����������� ��������� �������);
  end;
  PEVENT=^EVENTSTRUCT;

  OIKInf = record
    Comment:  array[0..24] of Char;	//- ������� �������� ����
    Abr_OIK:  array[0..4] of Char;	//- ����� (�����������) ����
    rbd_name: array[0..9] of Char;      //- ��� ������� SQL-���� ���� ��� ������ ����
  end;
  MassOIKInf = array[0..9] of OIKInf;
  POIKInf = ^MassOIKInf;

  SQLInf = record
    Id:       Cardinal;
    Descr:    array[0..49] of Char;
    Host:     array[0..19] of Char;
    RealName: array[0..31] of Char;
    State:    WORD;
  end;
  MassSQLInf = array[0..9] of SQLInf;
  PSQLInf = ^MassSQLInf;  

  DomainGroupInf = record
    Domain:  array [0..32] of Char;  // ��� ������
    GrpName: array [0..32] of Char;  // ��� ������
    Comment: array [0..64] of Char;  // �������� ������
  end;
  MassDomainGroupInf = array[0..9] of DomainGroupInf;
  PDomainGroupInf = ^MassDomainGroupInf;

    // ������ � ����
  //������ ������ � ����
  function  RTDBOpen(Code_Str: PChar): LongBool;                  stdcall; external 'Rtdbcon.dll';
  //����� ������ � ����
  procedure RTDBClose;                                            stdcall; external 'Rtdbcon.dll';
  //������� ���������
  procedure RTDBEvent(ptr:PEVENT; ParVal:PDouble; Mes:PChar);     stdcall; external 'Rtdbcon.dll';
  //��������� ������ ���������� � ����
  function  RTDBGetNCon: Cardinal;                                stdcall; external 'Rtdbcon.dll';
  //����������� ����/������
  procedure RTDBMsg(hndl: THandle; Thread: LongBool);             stdcall; external 'Rtdbcon.dll';
  //������:�������.���������
  function  RTDBQuery(Query: PSyncQuery): Pointer;                stdcall; external 'Rtdbcon.dll';
  //������.������:��������.���������/������ � �����������
  function  RTDBQueryAsync(Query: PAsyncQuery): Cardinal;         stdcall; external 'Rtdbcon.dll';
  //����� �� ������.�������
  procedure RTDBQueryEnd(hQuery: Cardinal);                       stdcall; external 'Rtdbcon.dll';
  //��������� ������ �� ������������ �������
  procedure RTDBQueryData(hQuery: Cardinal);                      stdcall; external 'Rtdbcon.dll';
  //�������� ������ ����������� �������
  procedure RTDBDeleteData(Msg: Pointer);                         stdcall; external 'Rtdbcon.dll';
  function  RTDBSendAsync(hQuery: Cardinal; size: Cardinal;
    data: Pointer): LongBool;                                     stdcall; external 'Rtdbcon.dll';

    // ������� �������
  procedure FileTimeToUnix(pFT:PFileTime; pInt: pCardinal);       stdcall; external 'Rtdbcon.dll';
  procedure SystemTimeToUnix(pST:PSystemTime; pInt:pCardinal);    stdcall; external 'Rtdbcon.dll';
  procedure UnixToSystemTime(pInt:pCardinal; pST:PSystemTime);    stdcall; external 'Rtdbcon.dll';
  procedure UnixToLocalTime(pInt:pCardinal; pST:PSystemTime);     stdcall; external 'Rtdbcon.dll';
  procedure LocalTimeToUnix(pST :PSystemTime; pInt: pCardinal);   stdcall; external 'Rtdbcon.dll';
  function  CurrentUnixTime: Cardinal;                            stdcall; external 'Rtdbcon.dll';
  function  SystemTimeToUnixTime(pST :PSystemTime): Cardinal;     stdcall; external 'Rtdbcon.dll';
  function  LocalTimeToUnixTime(pST: PSystemTime): Cardinal;      stdcall; external 'Rtdbcon.dll';
  function SummerAge(year: SmallInt; S, Po: PCardinal): Cardinal; stdcall; external 'Rtdbcon.dll';

  //������ � ������� ���
  //��������� �� �������� ���
  function  SetDefOIK: Cardinal;                                  stdcall; external 'Rtdbcon.dll';
  //��������� ������ ���������� �����
  function  GetOIKList(OIKInfo: POIKInf;
    PSize: pCardinal): Cardinal;                                  stdcall; external 'Rtdbcon.dll';
  //��������� ������ ���������� SQL ��������
  function  GetSQLList(SQLInfo: PSQLInf;
    PSize: pCardinal): Cardinal;                                  stdcall; external 'Rtdbcon.dll';
  //��������� �� �������� ���
  function  SetOIK(Abr: PChar): Cardinal ;                        stdcall; external 'Rtdbcon.dll';
  //��������� ����������� ������� ����
  function  GetDefOIKAbr: PChar;                                  stdcall; external 'Rtdbcon.dll';
  //��������� ����� ������� SQL-���� ���������� ����
  function  GetOIKBD: PChar;                                      stdcall; external 'Rtdbcon.dll';
  //��������� ����� ��������� SQL ������� ���
  function  GetDefNSQL: PChar;                                    stdcall; external 'Rtdbcon.dll';
  //��������� ����� ���� ������ ����
  function  GetOIKKrnl: PChar;                                    stdcall; external 'Rtdbcon.dll';
  //�������� ���������� � ������� ���� � �������� SQL ������� ���
  function  UpdateInfo: LongBool;                                 stdcall; external 'Rtdbcon.dll';

  function  GetDomain: PChar;                                     stdcall; external 'Rtdbcon.dll';
  function  GetGroup: PChar;                                      stdcall; external 'Rtdbcon.dll';
  function  GetRTDBAbr: PChar;                                    stdcall; external 'Rtdbcon.dll';

  function  SetDefOIKForDomainGroup(dmn_grp: PChar):Cardinal;     stdcall; external 'Rtdbcon.dll';
  function  GetDomainGroupList(list: PDomainGroupInf;
    size: pCardinal):Cardinal ;                                   stdcall; external 'Rtdbcon.dll';
  procedure SetDomainGroup2(Domain: PChar; Group: PChar);         stdcall; external 'Rtdbcon.dll';
  function  SelectOIK: Boolean;                                   stdcall; external 'Rtdbcon.dll';
  procedure OIKSetPassword(pswd: PChar);                          stdcall; external 'Rtdbcon.dll';
  function  OIKSetHost(Host: PChar): Boolean;                     stdcall; external 'Rtdbcon.dll';
  function  OIKSetPort(Port: Cardinal): Boolean;                  stdcall; external 'Rtdbcon.dll';

   // ����������� ������� ��� ������������� ������ � ����������� ������
  function  CreateNewRTDBConnection: WORD;                        stdcall; external 'Rtdbcon.dll';
  procedure DestroyRTDBConnection(Id: WORD);                      stdcall; external 'Rtdbcon.dll';
  function  OIKSetHostEx(Id: WORD; Host: PChar): Boolean;         stdcall; external 'Rtdbcon.dll';
  function  OIKSetPortEx(Id: WORD; Port: Cardinal): Boolean;      stdcall; external 'Rtdbcon.dll';
  function  OIKSetPasswordEx(ID: WORD; Pswd: PChar): Boolean;     stdcall; external 'Rtdbcon.dll';
  function  SetOIKEx(ID: WORD; Abr: PChar): Cardinal;             stdcall; external 'Rtdbcon.dll';
  function  SetDefOIKEx(Id: WORD): Cardinal;                      stdcall; external 'Rtdbcon.dll';
  function  SetDefOIKForDomainGroupEx(Id: WORD;
    Dmn_Grp: PChar): Cardinal;                                    stdcall; external 'Rtdbcon.dll';
  function  SetFromIniEx(Id: WORD): Boolean;                      stdcall; external 'Rtdbcon.dll';
  function  GetDefOIKAbrEx(Id: WORD): PChar;                      stdcall; external 'Rtdbcon.dll';
  function  GetDomainEx(Id: WORD): PChar;                         stdcall; external 'Rtdbcon.dll';
  function  GetGroupEx(Id: WORD): PChar;                          stdcall; external 'Rtdbcon.dll';
  function  GetRTDBAbrEx(Id: WORD): PChar;                        stdcall; external 'Rtdbcon.dll';
  function  SelectOIKEx(Id: WORD): Boolean;                       stdcall; external 'Rtdbcon.dll';
  function  GetOIKListEx(Id: WORD; List: POIKInf;
    var Size: Cardinal): Cardinal;                                stdcall; external 'Rtdbcon.dll';
  function  GetDomainGroupListEx(Id: WORD; List: PDomainGroupInf;
    var Size: Cardinal): Cardinal;                                stdcall; external 'Rtdbcon.dll';
  function  SetDomainGroup2Ex(Id: WORD; Domain,
    Group: PChar): Boolean;                                       stdcall; external 'Rtdbcon.dll';
  function  GetSQLListEx(Id: WORD; List: PSQLInf;
    var Size: Cardinal): Cardinal;                                stdcall; external 'Rtdbcon.dll';
  function  GetOIKBDEx(Id: WORD): PChar;                          stdcall; external 'Rtdbcon.dll';
  function  GetOIKKrnlEx(Id: WORD): PChar;                        stdcall; external 'Rtdbcon.dll';
  function  GetRTDBPortEx(Id: WORD): Cardinal;                    stdcall; external 'Rtdbcon.dll';
  function  GetRTDBHostEx(Id: WORD): PChar;                       stdcall; external 'Rtdbcon.dll';
  function  GetDefNSQLEx(Id: WORD): PChar;                        stdcall; external 'Rtdbcon.dll';
  function  UpdateInfoEx(Id: WORD): Boolean;                      stdcall; external 'Rtdbcon.dll';
  function  RTDBOpenEx(Id: WORD; Code_Str: PChar): Boolean;       stdcall; external 'Rtdbcon.dll';
  procedure RTDBCloseEx(Id: WORD);                                stdcall; external 'Rtdbcon.dll';
  procedure RTDBEventEx(Id: WORD; Ptr: PEvent; ParVal: PDouble;
    Str: PChar);                                                  stdcall; external 'Rtdbcon.dll';
  function RTDBGetNConEx(Id: Word): Cardinal;                     stdcall; external 'Rtdbcon.dll';
  function  RTDBQueryAsyncEx(Id: WORD;
    Query: PAsyncQuery): Cardinal;                                stdcall; external 'Rtdbcon.dll';
  procedure RTDBMsgEx(Id: WORD; Handle: THandle;
    Thread: Boolean);                                             stdcall; external 'Rtdbcon.dll';
  function  RTDBQueryEx(Id: WORD; Query: PSyncQuery): Pointer;    stdcall; external 'Rtdbcon.dll';
  procedure RTDBDeleteDataEx(Id: WORD; Data: Pointer);            stdcall; external 'Rtdbcon.dll';

  function  SplitOIId(OIId: Cardinal; OI: PChar): Cardinal;       stdcall; external 'Rtdbcon.dll';
  function  MergeOIId(OI: Char; Id: Cardinal): Cardinal;          stdcall; external 'Rtdbcon.dll';

  function IsSetOIKOption(opt: PChar): Cardinal;                  stdcall; external 'Rtdbcon.dll';
  function IsSetOIKOptionEx(id: WORD; opt: PChar): Cardinal;      stdcall; external 'Rtdbcon.dll';
  
implementation

end.
