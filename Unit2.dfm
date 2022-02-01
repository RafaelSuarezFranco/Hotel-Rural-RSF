object Form2: TForm2
  Left = 0
  Top = 193
  Caption = 'Form2'
  ClientHeight = 715
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 288
    Top = 24
    Width = 97
    Height = 13
    Caption = 'Fecha seleccionada:'
  end
  object Label2: TLabel
    Left = 520
    Top = 24
    Width = 119
    Height = 13
    Caption = 'Habitaci'#243'n Seleccionada:'
  end
  object Panel1: TPanel
    Left = 96
    Top = 64
    Width = 700
    Height = 600
    Caption = 'Panel1'
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 240
    Width = 75
    Height = 73
    Caption = 'Mes anterior'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 802
    Top = 240
    Width = 75
    Height = 73
    Caption = 'Mes siguiente'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
