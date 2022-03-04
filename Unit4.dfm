object FormularioDiario: TFormularioDiario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FormularioDiario'
  ClientHeight = 508
  ClientWidth = 460
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
    Left = 32
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
    Left = 31
    Top = 112
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
    Left = 32
    Top = 176
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
    Top = 112
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
    Left = 123
    Top = 240
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
  object Label5: TLabel
    Left = 31
    Top = 240
    Width = 86
    Height = 18
    Caption = 'Precio actual:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RadioGroup1: TRadioGroup
    Left = 288
    Top = 48
    Width = 136
    Height = 96
    Caption = 'Estado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'libre'
      'reservada'
      'ocupada')
    ParentFont = False
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 128
    Top = 177
    Width = 177
    Height = 21
    MaxLength = 50
    TabOrder = 1
  end
  object Button1: TButton
    Left = 168
    Top = 440
    Width = 113
    Height = 41
    Caption = 'Registar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ScrollBox1: TScrollBox
    Left = 32
    Top = 279
    Width = 362
    Height = 146
    TabOrder = 3
    object Label10: TLabel
      Left = 213
      Top = 19
      Width = 73
      Height = 18
      Caption = 'Precio final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 8
      Width = 55
      Height = 18
      Caption = 'Servicios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Edit2: TEdit
      Left = 213
      Top = 56
      Width = 113
      Height = 21
      TabOrder = 0
    end
  end
end
