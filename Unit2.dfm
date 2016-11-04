object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '
  ClientHeight = 286
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 112
    Height = 13
    Caption = 'IP '#1072#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072' MCU'
  end
  object Label2: TLabel
    Left = 8
    Top = 35
    Width = 97
    Height = 13
    Caption = 'HTTP-'#1087#1086#1088#1090' '#1089#1077#1088#1074#1077#1088#1072
  end
  object Label3: TLabel
    Left = 8
    Top = 129
    Width = 102
    Height = 13
    Caption = 'Telnet-'#1087#1086#1088#1090' '#1089#1077#1088#1074#1077#1088#1072
  end
  object Label4: TLabel
    Left = 8
    Top = 163
    Width = 62
    Height = 13
    Caption = 'Telnet '#1083#1086#1075#1080#1085
  end
  object Label5: TLabel
    Left = 8
    Top = 190
    Width = 69
    Height = 13
    Caption = 'Telnet '#1087#1072#1088#1086#1083#1100
  end
  object Label6: TLabel
    Left = 8
    Top = 75
    Width = 58
    Height = 13
    Caption = 'HTTP-'#1083#1086#1075#1080#1085
  end
  object Label7: TLabel
    Left = 8
    Top = 102
    Width = 65
    Height = 13
    Caption = 'HTTP-'#1087#1072#1088#1086#1083#1100
  end
  object MaskEdit2: TMaskEdit
    Left = 126
    Top = 35
    Width = 118
    Height = 21
    EditMask = '9999;1;_'
    MaxLength = 4
    TabOrder = 0
    Text = '    '
  end
  object MaskEdit3: TMaskEdit
    Left = 126
    Top = 126
    Width = 118
    Height = 21
    EditMask = '9999;1;_'
    MaxLength = 4
    TabOrder = 1
    Text = '    '
  end
  object Edit1: TEdit
    Left = 126
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 126
    Top = 187
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 88
    Top = 247
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 126
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object Edit4: TEdit
    Left = 127
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object Edit5: TEdit
    Left = 127
    Top = 99
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 7
  end
end
