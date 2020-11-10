object frmMain: TfrmMain
  Left = 470
  Top = 261
  Width = 544
  Height = 375
  Caption = 'frmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 40
    Top = 80
    Width = 313
    Height = 241
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = False
  end
  object Memo1: TMemo
    Left = 376
    Top = 72
    Width = 129
    Height = 145
    TabOrder = 1
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Top = 8
  end
  object zipText: TVCLZip
    Top = 40
  end
  object zipPics: TVCLZip
    Top = 72
  end
  object IdSMTP1: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    Left = 240
    Top = 107
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 272
    Top = 107
  end
  object conMultilinkDotCom: TMSConnection
    Database = 'Proplink'
    IsolationLevel = ilReadUnCommitted
    Options.NetworkLibrary = 'DBMSSOCN'
    Username = 'sa'
    Server = 'www.multilink.com.au'
    LoginPrompt = False
    Left = 36
    Top = 45
    EncryptedPassword = '95FFCCFF96FF98FFC6FFC8FFCBFF97FFCCFFCFFF'
  end
  object qryProp: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 84
    Top = 45
  end
  object qryPropDetail: TMSQuery
    Connection = conMultilinkDotCom
    Left = 116
    Top = 45
  end
  object qryExport: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 156
    Top = 45
  end
  object qryInsert: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 196
    Top = 45
  end
  object qryUpdate: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 233
    Top = 45
  end
  object qryDelete: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 265
    Top = 45
  end
  object qryPropSold: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 297
    Top = 45
  end
  object qryTranslatedAgentId: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 329
    Top = 45
  end
  object qryUsers: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 369
    Top = 45
  end
  object qryPropOFI: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 409
    Top = 45
  end
  object qryPropDistCategory: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 449
    Top = 45
  end
  object qryPropImage: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 449
    Top = 13
  end
  object qryPropImageFile: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 489
    Top = 13
  end
  object qryPropWebLinks: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 489
    Top = 45
  end
  object qryWorker: TMSQuery
    Connection = conMultilinkDotCom
    SQL.Strings = (
      'select * from dist_export')
    Left = 393
    Top = 229
  end
end
