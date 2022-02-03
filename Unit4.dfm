object FormularioDiario: TFormularioDiario
  Left = 0
  Top = 0
  Caption = 'FormularioDiario'
  ClientHeight = 498
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 48
    Width = 71
    Height = 18
    Caption = 'Habitaci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 120
    Width = 44
    Height = 18
    Caption = 'Fecha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 192
    Width = 47
    Height = 18
    Caption = 'Cliente:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 42
    Top = 264
    Width = 43
    Height = 18
    Caption = 'Precio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 128
    Top = 48
    Width = 50
    Height = 18
    Caption = 'numero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 128
    Top = 120
    Width = 39
    Height = 18
    Caption = 'Fecha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 124
    Top = 264
    Width = 38
    Height = 18
    Caption = 'Precio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RadioGroup1: TRadioGroup
    Left = 288
    Top = 49
    Width = 105
    Height = 89
    Caption = 'Estado'
    Items.Strings = (
      'libre'
      'reservada'
      'ocupada')
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 128
    Top = 193
    Width = 177
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 192
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Registar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
