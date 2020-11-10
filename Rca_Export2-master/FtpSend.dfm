object Form1: TForm1
  Left = 356
  Top = 111
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 64
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 140
    Top = 96
  end
end
