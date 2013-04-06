object dlgProgress: TdlgProgress
  Left = 350
  Top = 293
  Width = 372
  Height = 218
  BorderIcons = []
  Caption = #1055#1088#1086#1075#1088#1077#1089#1089
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TPanel
    Left = 0
    Top = 0
    Width = 364
    Height = 184
    Align = alClient
    TabOrder = 0
    DesignSize = (
      364
      184)
    object Bevel1: TBevel
      Left = 5
      Top = 38
      Width = 355
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object pbResult: TcxProgressBar
      Left = 6
      Top = 10
      Anchors = [akLeft, akTop, akRight]
      Position = 75.000000000000000000
      Properties.BarStyle = cxbsGradient
      Properties.BorderWidth = 1
      Properties.EndColor = clSilver
      Properties.PeakValue = 100.000000000000000000
      Style.BorderStyle = ebsOffice11
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 0
      Width = 270
    end
    object amInfo: TcxMemo
      Left = 6
      Top = 45
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'amInfo')
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = False
      Style.Shadow = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 1
      Height = 133
      Width = 352
    end
    object btnCancel: TcxButton
      Left = 281
      Top = 8
      Width = 77
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 2
      OnClick = btnCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      NumGlyphs = 2
    end
  end
  object XPManifest1: TXPManifest
    Left = 296
    Top = 49
  end
end
