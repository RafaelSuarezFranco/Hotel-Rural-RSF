object CrearTemporada: TCrearTemporada
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'CrearTemporada'
  ClientHeight = 285
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 27
    Width = 132
    Height = 23
    Caption = 'Fecha de inicio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 296
    Top = 27
    Width = 111
    Height = 23
    Caption = 'Fecha de fin:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 296
    Top = 107
    Width = 136
    Height = 23
    Caption = 'Precio adicional:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DatePicker1: TDatePicker
    Left = 48
    Top = 56
    Date = 44609.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 0
  end
  object DatePicker2: TDatePicker
    Left = 296
    Top = 56
    Date = 44609.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 40
    Top = 107
    Width = 185
    Height = 81
    Caption = 'Tipo de temporada'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Media'
      'Alta')
    ParentFont = False
    TabOrder = 2
  end
  object SpinEdit1: TSpinEdit
    Left = 296
    Top = 136
    Width = 150
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 10
  end
  object Button1: TButton
    Left = 104
    Top = 208
    Width = 121
    Height = 41
    Caption = 'Crear'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 208
    Width = 123
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = Button2Click
  end
end
