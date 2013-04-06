object dmData: TdmData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 625
  Top = 474
  Height = 232
  Width = 339
  object SakSMTP1: TSakSMTP
    Port = '25'
    SendProgressStep = 10
    TimeOut = 60000
    Left = 24
    Top = 64
  end
  object SakMsg1: TSakMsg
    CharSet = 'ISO-8859-1'
    Left = 88
    Top = 64
  end
  object SakPOP1: TSakPOP
    Port = '110'
    StrErrorInFormatOfMsg = 'Error en el formato del mensaje.'
    RetrieveProgressStep = 10
    Left = 24
    Top = 112
  end
  object SakMsgList1: TSakMsgList
    Left = 88
    Top = 112
  end
  object adc80020: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=,fyrjvfn;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=m80020;Data Source=rdusql'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 24
    Top = 16
  end
end
