object PantallaMes: TPantallaMes
  Left = 0
  Top = 193
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'PantallaMes'
  ClientHeight = 804
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 139
    Height = 19
    Caption = 'Fecha seleccionada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 360
    Top = 24
    Width = 175
    Height = 19
    Caption = 'Habitaci'#243'n Seleccionada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 104
    Top = 109
    Width = 665
    Height = 13
    Caption = 
      '            Lunes                      Martes                   ' +
      ' Mi'#233'rcoles                  Jueves                       Viernes' +
      '                     S'#225'bado                      Domingo'
  end
  object Label4: TLabel
    Left = 644
    Top = 48
    Width = 60
    Height = 13
    Caption = 'Saltar al d'#237'a:'
  end
  object Label5: TLabel
    Left = 376
    Top = 69
    Width = 95
    Height = 13
    Caption = 'Cambiar habitaci'#243'n:'
  end
  object Panel1: TPanel
    Left = 96
    Top = 136
    Width = 700
    Height = 600
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
  object DatePicker1: TDatePicker
    Left = 710
    Top = 39
    Date = 44593.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 3
    OnChange = DatePicker1Change
  end
  object ComboBox1: TComboBox
    Left = 488
    Top = 66
    Width = 81
    Height = 21
    TabOrder = 4
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
  end
end
