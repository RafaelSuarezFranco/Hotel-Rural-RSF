object AltaHabitacion: TAltaHabitacion
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AltaHabitacion'
  ClientHeight = 252
  ClientWidth = 229
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
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 79
    Height = 13
    Caption = 'N'#186' de habitaci'#243'n'
  end
  object Label2: TLabel
    Left = 48
    Top = 80
    Width = 87
    Height = 13
    Caption = 'Tipo de habitaci'#243'n'
  end
  object Label3: TLabel
    Left = 48
    Top = 128
    Width = 133
    Height = 13
    Caption = 'Precio base de la habitaci'#243'n'
  end
  object Button1: TButton
    Left = 24
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Crear'
    TabOrder = 3
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 48
    Top = 52
    Width = 133
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object Edit1: TEdit
    Left = 48
    Top = 147
    Width = 133
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 48
    Top = 99
    Width = 133
    Height = 21
    TabOrder = 1
  end
  object Button2: TButton
    Left = 128
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = Button2Click
  end
end
