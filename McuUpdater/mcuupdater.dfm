object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MCU Manager Updater'
  ClientHeight = 92
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 132
    Height = 13
    Caption = #1048#1076#1077#1090' '#1087#1088#1086#1094#1077#1089#1089' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
  end
  object ProgressBar1: TProgressBar
    Left = 40
    Top = 35
    Width = 377
    Height = 17
    TabOrder = 0
  end
  object IdHTTP1: TIdHTTP
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 384
    Top = 65528
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 288
    Top = 8
  end
end
