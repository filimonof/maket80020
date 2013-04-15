object frmMain: TfrmMain
  Left = 334
  Top = 265
  Width = 786
  Height = 480
  Caption = #1052#1072#1082#1077#1090' 80020'
  Color = clMenuBar
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxStatusBar1: TdxStatusBar
    Left = 0
    Top = 422
    Width = 770
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Color = clBtnFace
        PanelStyle.Font.Charset = DEFAULT_CHARSET
        PanelStyle.Font.Color = clWindowText
        PanelStyle.Font.Height = -11
        PanelStyle.Font.Name = 'MS Sans Serif'
        PanelStyle.Font.Style = []
        PanelStyle.ParentFont = False
        Text = '13123'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    PaintStyle = stpsOffice11
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
  end
  object dxDockSite3: TdxDockSite
    Left = 770
    Top = 26
    Width = 0
    Height = 396
    Align = alRight
    AutoSize = True
    DockType = 0
    OriginalWidth = 0
    OriginalHeight = 396
  end
  object dxDockSite2: TdxDockSite
    Left = 0
    Top = 26
    Width = 770
    Height = 0
    Align = alTop
    AutoSize = True
    DockType = 0
    OriginalWidth = 770
    OriginalHeight = 0
  end
  object dxDockSite4: TdxDockSite
    Left = 0
    Top = 422
    Width = 770
    Height = 0
    Align = alBottom
    AutoSize = True
    DockType = 0
    OriginalWidth = 770
    OriginalHeight = 0
  end
  object dxDockSite1: TdxDockSite
    Left = 0
    Top = 26
    Width = 204
    Height = 396
    Align = alLeft
    AutoSize = True
    DockType = 0
    OriginalWidth = 1
    OriginalHeight = 424
    object dxLayoutDockSite1: TdxLayoutDockSite
      Left = 0
      Top = 0
      Width = 204
      Height = 396
      DockType = 1
      OriginalWidth = 204
      OriginalHeight = 200
    end
    object dxDockPanel1: TdxDockPanel
      Left = 0
      Top = 0
      Width = 204
      Height = 396
      AllowFloating = True
      AutoHide = False
      Caption = '   '#1047#1072#1076#1072#1095#1080
      CaptionButtons = [cbMaximize, cbHide]
      DockType = 1
      OriginalWidth = 204
      OriginalHeight = 377
      object dxNavBar2: TdxNavBar
        Left = 0
        Top = 0
        Width = 200
        Height = 372
        Align = alClient
        ActiveGroupIndex = 0
        DragCopyCursor = -1119
        DragCursor = -1120
        DragDropFlags = [fAllowDragLink, fAllowDropLink, fAllowDragGroup, fAllowDropGroup]
        HotTrackedGroupCursor = crDefault
        HotTrackedLinkCursor = -1118
        View = 12
        object dxNavBarGroup1: TdxNavBarGroup
          Caption = #1052#1072#1082#1077#1090' 80020'
          LinksUseSmallImages = True
          SelectedLinkIndex = -1
          ShowAsIconView = False
          ShowControl = False
          TopVisibleLinkIndex = 0
          UseControl = False
          UseSmallImages = True
          Visible = True
          Links = <
            item
              Item = dxNavBarItem1
            end
            item
              Item = dxNavBarItem2
            end
            item
              Item = dxNavBar2Item2
            end
            item
              Item = dxNavBarItem3
            end>
        end
        object dxNavBarGroup2: TdxNavBarGroup
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
          Expanded = False
          LinksUseSmallImages = True
          SelectedLinkIndex = -1
          ShowAsIconView = False
          ShowControl = False
          TopVisibleLinkIndex = 0
          UseControl = False
          UseSmallImages = True
          Visible = True
          Links = <
            item
              Item = dxNavBarItem4
            end
            item
              Item = dxNavBarItem5
            end>
        end
        object dxNavBarGroup3: TdxNavBarGroup
          Caption = #1060#1072#1081#1083
          LinksUseSmallImages = True
          SelectedLinkIndex = -1
          ShowAsIconView = False
          ShowControl = False
          ShowCaption = False
          TopVisibleLinkIndex = 0
          UseControl = False
          UseSmallImages = True
          Visible = True
          Links = <
            item
              Item = dxNavBar2Item1
            end
            item
              Item = dxNavBarItem6
            end>
        end
        object dxNavBarItem1: TdxNavBarItem
          Action = aLogList
        end
        object dxNavBarItem2: TdxNavBarItem
          Action = aTestPost
        end
        object dxNavBarItem3: TdxNavBarItem
          Action = aSendMaket
        end
        object dxNavBarItem4: TdxNavBarItem
          Action = aOptionsSK
        end
        object dxNavBarItem5: TdxNavBarItem
          Action = aOptionsMaket
        end
        object dxNavBarItem6: TdxNavBarItem
          Action = aExit
        end
        object dxNavBar2Item1: TdxNavBarItem
          Action = aAbout
        end
        object dxNavBar2Item2: TdxNavBarItem
          Action = aPreview
        end
      end
    end
  end
  object dxDockingManager1: TdxDockingManager
    Color = clBtnFace
    DefaultHorizContainerSiteProperties.Dockable = True
    DefaultHorizContainerSiteProperties.ImageIndex = -1
    DefaultVertContainerSiteProperties.Dockable = True
    DefaultVertContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.Dockable = True
    DefaultTabContainerSiteProperties.ImageIndex = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    Options = [doActivateAfterDocking, doDblClickDocking, doFloatingOnTop, doTabContainerHasCaption, doTabContainerCanAutoHide, doSideContainerCanClose, doSideContainerCanAutoHide, doTabContainerCanInSideContainer]
    ViewStyle = vsOffice11
    Left = 312
    Top = 72
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        Caption = #1052#1077#1085#1102
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 695
        FloatTop = 301
        FloatClientWidth = 80
        FloatClientHeight = 76
        IsMainMenu = True
        ItemLinks = <
          item
            Item = dxBarSubItem1
            Visible = True
          end
          item
            Item = dxBarSubItem2
            Visible = True
          end
          item
            Item = dxBarSubItem3
            Visible = True
          end
          item
            Item = dxBarButton8
            Visible = True
          end>
        MultiLine = True
        Name = 'dbMainMenu'
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    MenuAnimations = maRandom
    PopupMenuLinks = <>
    Style = bmsOffice11
    UseSystemFont = True
    Left = 248
    Top = 72
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1060#1072#1081#1083
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Item = dxBarButton1
          Visible = True
        end>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #1047#1072#1076#1072#1095#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Item = dxBarButton4
          Visible = True
        end
        item
          Item = dxBarButton6
          Visible = True
        end
        item
          Item = dxBarButton9
          Visible = True
        end
        item
          Item = dxBarButton5
          Visible = True
        end
        item
          Item = dxBarButton10
          Visible = True
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Item = dxBarButton2
          Visible = True
        end
        item
          Item = dxBarButton3
          Visible = True
        end>
    end
    object dxBarSubItem4: TdxBarSubItem
      Action = aAbout
      Category = 0
      ItemLinks = <>
    end
    object dxBarButton1: TdxBarButton
      Action = aExit
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = aOptionsSK
      Category = 0
      Hint = #1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    end
    object dxBarButton3: TdxBarButton
      Action = aOptionsMaket
      Category = 0
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = 'New Item'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton4: TdxBarButton
      Action = aLogList
      Category = 0
      Hint = #1057#1087#1080#1089#1086#1082' '#1089#1086#1073#1099#1090#1080#1081
    end
    object dxBarButton5: TdxBarButton
      Action = aSendMaket
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = aTestPost
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = aAbout
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = aAbout
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = aPreview
      Category = 0
    end
    object dxBarSubItem6: TdxBarSubItem
      Caption = 'New Item'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton10: TdxBarButton
      Action = aLoadMaketToDisk
      Category = 0
    end
    object dxBarStatic1: TdxBarStatic
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
    end
  end
  object alMain: TActionList
    Left = 280
    Top = 72
    object aOptionsMaket: TAction
      Category = 'Options'
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1072#1082#1077#1090#1072
      OnExecute = aExecute
    end
    object aAbout: TAction
      Category = 'Options'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnExecute = aExecute
    end
    object aExit: TAction
      Category = 'Options'
      Caption = #1042#1099#1093#1086#1076
      OnExecute = aExecute
    end
    object aLogList: TAction
      Category = 'Work'
      Caption = #1057#1087#1080#1089#1086#1082' '#1089#1086#1073#1099#1090#1080#1081
      OnExecute = aExecute
    end
    object aTestPost: TAction
      Category = 'Work'
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1086#1095#1090#1091
      OnExecute = aExecute
    end
    object aSendMaket: TAction
      Category = 'Work'
      Caption = #1054#1090#1086#1089#1083#1072#1090#1100' '#1084#1072#1082#1077#1090
      OnExecute = aExecute
    end
    object aOptionsSK: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = #1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      OnExecute = aExecute
    end
    object aPreview: TAction
      Category = 'Work'
      Caption = #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088' '#1076#1072#1085#1085#1099#1093
      OnExecute = aExecute
    end
    object aLoadMaketToDisk: TAction
      Category = 'Work'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1084#1072#1082#1077#1090' '#1089' '#1076#1080#1089#1082#1072
      OnExecute = aExecute
    end
  end
  object aspParseM80020: TADOStoredProc
    Connection = dmData.adc80020
    CursorType = ctDynamic
    CommandTimeout = 900
    ProcedureName = 'm80020_Parse;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@maket'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1073741823
        Value = Null
      end
      item
        Name = '@filename'
        Attributes = [paNullable]
        DataType = ftString
        Size = 250
        Value = Null
      end
      item
        Name = '@error'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdInputOutput
        Size = 250
        Value = Null
      end>
    Prepared = True
    Left = 248
    Top = 112
  end
  object aspCreateMaket: TADOStoredProc
    Connection = dmData.adc80020
    CursorType = ctDynamic
    CommandTimeout = 300
    ProcedureName = 'm80020_CreateMaket;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@dt'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@paramID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@error'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 250
        Value = Null
      end>
    Prepared = True
    Left = 288
    Top = 112
  end
  object adsCreateMaket: TADODataSet
    Connection = dmData.adc80020
    CursorType = ctDynamic
    CommandText = 'm80020_CreateMaket;1'
    CommandTimeout = 300
    CommandType = cmdStoredProc
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@dt'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@paramID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@error'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 250
        Value = Null
      end>
    Prepared = True
    Left = 328
    Top = 112
  end
end
