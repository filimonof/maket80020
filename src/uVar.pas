unit uVar;

interface

uses SakMsg, ck7GetData;

const
  NAME_PROGRAM = 'Макет 80020';
  NAME_PROGRAM_SMALL = 'm80020';
  VERSION_PROGRAM = '3.2.0';

  INT_ENABLED = 1;
  INT_DISABLED = 0;

  COUNT_SERVERS_ACCESS = 0;
  COUNT_SERVERS_CK = 1;
  COUNT_SERVERS_SQL = 1;

  CRYPT_KEY = '%';

  REG_KEY_OPTIONS = '\SOFTWARE\RDURM\m80020';
  INI_FILE = 'm80020.ini';

  PARAM_SENDER_NAME   = 'SenderName';
  PARAM_SENDER_INN    = 'SenderINN';
  PARAM_LAST_NUM      = 'LastNum';

  PARAM_SMTP_ACTIVE   = 'SMTPActive';
  PARAM_SMTP_SERVER   = 'SMTPServer';
  PARAM_SMTP_PORT     = 'SMTPPort';
  PARAM_SMTP_TIMEOUT  = 'SMTPTimeOut';
  PARAM_SMTP_MAILBOX  = 'SMTPMailBox';
  PARAM_SMTP_OTKOGO   = 'SMTPOtKogo';
  PARAM_SMTP_SUBJECT  = 'SMTPSubject';
  PARAM_SMTP_KOMU     = 'SMTPKomu';
  PARAM_SMTP_CHARSET  = 'SMTPCharSet';
  PARAM_SMTP_TEXTENCODING  = 'SMTPTextEncoding';
  PARAM_SMTP_FILEFORMAT    = 'SMTPFileFormat';
  PARAM_SMTP_FILETMPDELETE = 'SMTPFileTmpDelete';
  PARAM_SMTP_FILEZIPED     = 'SMTPFileZiped';

  PARAM_POP_ACTIVE   = 'POPActive';
  PARAM_POP_SERVER   = 'POPServer';
  PARAM_POP_PORT     = 'POPPort';
  PARAM_POP_LOGIN    = 'POPLogin';
  PARAM_POP_PASSWORD = 'POPPassword';
  PARAM_POP_FILEFORMAT    = 'POPFileFormat';
  PARAM_POP_ISEMAILFROM   = 'POPIsEmailFrom';
  PARAM_POP_EMAILFROM     = 'POPEmailFrom';
  PARAM_POP_ISDELETELOADDEDEMAIL = 'POPIsDeleteLoadedEmail';
  PARAM_POP_FILETMPDELETE = 'POPFileTmpDelete';

  PARAM_SUBSCRIBE_ACTIVE               = 'SubscribeActive';
  PARAM_SUBSCRIBE_ISDELETELOADDEDEMAIL = 'SubscribeIsDeleteLoadedEmail';
  PARAM_SUBSCRIBE_FILETMPDELETE        = 'SubscribeFileTmpDelete';
  PARAM_SUBSCRIBE_FILEZIPED            = 'SubscribeFileZiped';

  NULLTODEF = '';

type
  recDataBaseCK = record
    Active: Boolean;
    Name: string;
    Server_1: string;
    WinAuth_1: Boolean;
    Login_1: string;
    Pas_1: string;
    Server_2: string;
    WinAuth_2: Boolean;
    Login_2: string;
    Pas_2: string;
    Server_3: string;
    WinAuth_3: Boolean;
    Login_3: string;
    Pas_3: string;
    TimeOut: Integer;
    Pclass: Tck7Data;
  end;

  recDataBaseACCESS = record
    Active: Boolean;
    Name: string;
    NameDB: string;
    TimeOut: Integer;    
    NameComponents: string;
  end;

  recDataBaseSQL = record
    Active: Boolean;
    Name: string;
    ServerIP: string;
    NameDB: string;
    Login: string;
    Password: string;
    WinNTAuth: Boolean;
    TimeOut: Integer;
    NameComponent: string;
  end;

  recSMTPSendMail = record
    Active: Boolean;
    SMTPserver: string;
    SMTPport: string;
    TimeOut: Integer;
    mailbox: string;
    OtKogo: string;
    Subject: string;
    Komu: string;
    CharSet: string;
    TextEncoding: TTextEncoding;
    FileFormat: string;
    FileTmpDelete: Boolean;
    FileZiped: Boolean;
  end;

  recPOPGetMail = record
    Active: Boolean;
    POPserver: string;
    POPport: string;
    Login: string;
    Password: string;
    FileFormat: string;
    IsEmailFrom: Boolean;
    EmailFrom: string;
    IsDeleteLoadedEmail: Boolean;
    FileTmpDelete: Boolean;
  end;

  recSubscribe = record
    Active: Boolean;
    IsDeleteLoadedEmail: Boolean;
    FileTmpDelete: Boolean;
    FileZipped: Boolean;
  end;

var
  sPath: string;
  sTempDir: string = 'tmp';
  sDirReports: string = 'reports';

{
  mServersAccess: array [1..COUNT_SERVERS_ACCESS] of recDataBaseAccess = (
   ( Active: true;
      Name:'Основная';
      NameDB:'Report.mdb';
      TimeOut: 20;
      NameComponents:'adcLog')
   );
}

   sSQLDateTimeFormat: array [1..COUNT_SERVERS_SQL] of string;

   mServersSQL: array [1..COUNT_SERVERS_SQL] of recDataBaseSQL = (
    ( Active: true;
      Name:'Основная';
      ServerIP:'dupakfvv';
      NameDB:'m80020';
      Login:'';
      Password:'';
      WinNTAuth:true;
      TimeOut: 30;      
      NameComponent:'adc80020')
    );
        
  mServersCK: array [1..COUNT_SERVERS_CK] of recDataBaseCK = (
    ( Active: true;
      Name: 'CK-2007';
      Server_1: 'oik07-1-mrdv';
      WinAuth_1: true;
      Login_1: 'reader';
      Pas_1: 'reader';
      Server_2: 'oik07-2-mrdv';
      WinAuth_2: true;
      Login_2: 'reader';
      Pas_2: 'reader';
      Server_3: 'oik07-3-mrdv';
      WinAuth_3: true;
      Login_3: 'reader';
      Pas_3: 'reader';
      TimeOut: 30;
      Pclass: nil)
    );

  m80020sendmail: recSMTPSendMail =
  (
    Active: true;
    SMTPserver: 'mail';
    SMTPport: '25';
    TimeOut: 60000;
    mailbox: 'fvv@rdurm.odusv.so-cdu.ru';
    OtKogo: '80020 МордовПрвиет. ское РДУ';
    Subject: '80020 Мордовское РДУ';
    Komu: 'fvv@rdurm.odusv.so-cdu.ru';
//    Komu: 'galina@odusv.so-cdu.ru';
//    Komu: 'vitalikvf@mail.ru,aai_@mail.ru';
//    Komu: 'kav@moren.elektra.ru';
    CharSet: 'windows-1251';
    TextEncoding: teBase64;
    FileFormat: '80020_<%INN%>_<%date%>_<%number%>.xml';
    FileTmpDelete: false;
    FileZiped: false;
  );

  m80020getmail: recPOPGetMail =
  (
    Active: true;
    POPserver: 'mail';
    POPport: '110';
    Login: 'fvv';
    Password: '';
    FileFormat: '80020_<%INN%>_<%date%>_<%number%>.xml'; //?
    IsEmailFrom: false;
    EmailFrom: '';
    IsDeleteLoadedEmail: false;
  );

  m80020subscribe: recSubscribe =
  (
    Active: true;
    IsDeleteLoadedEmail: true;
    FileTmpDelete: true;
    FileZipped: true;
  );

  mWeekDay: array[1..7] of string = (
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  );

  mWeekDayShort: array[1..7] of string=('Пн','Вт','Ср','Чт','Пт','Сб','Вс');

  mMonthDay: array[1..12] of string = (
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь'
  );

  mMonthDayRP: array[1..12] of string = (
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря'
  );


implementation

end.

