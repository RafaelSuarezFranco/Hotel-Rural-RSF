object FormularioPeriodo: TFormularioPeriodo
  Left = 0
  Top = 0
  Caption = 'FormularioPeriodo'
  ClientHeight = 567
  ClientWidth = 409
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
    Left = 56
    Top = 40
    Width = 88
    Height = 19
    Caption = 'Fecha inicio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 112
    Width = 69
    Height = 19
    Caption = 'Fecha fin:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 56
    Top = 192
    Width = 80
    Height = 19
    Caption = 'Habitaci'#243'n:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 56
    Top = 264
    Width = 54
    Height = 19
    Caption = 'Cliente:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 56
    Top = 336
    Width = 68
    Height = 19
    Caption = 'Servicios:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DatePicker1: TDatePicker
    Left = 184
    Top = 40
    Date = 44601.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 0
  end
  object DatePicker2: TDatePicker
    Left = 184
    Top = 112
    Date = 44601.000000000000000000
    DateFormat = 'dd/MM/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 184
    Top = 194
    Width = 150
    Height = 21
    TabOrder = 2
    Text = 'ComboBox1'
  end
  object Edit1: TEdit
    Left = 184
    Top = 262
    Width = 150
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 144
    Top = 512
    Width = 91
    Height = 33
    Caption = 'Confirmar'
    TabOrder = 4
  end
  object Panel1: TPanel
    Left = 184
    Top = 328
    Width = 150
    Height = 153
    TabOrder = 5
  end
end
