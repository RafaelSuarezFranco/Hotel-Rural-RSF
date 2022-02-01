object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 608
  ClientWidth = 1005
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
    Left = 464
    Top = 40
    Width = 97
    Height = 13
    Caption = 'Fecha seleccionada:'
  end
  object Label2: TLabel
    Left = 232
    Top = 40
    Width = 65
    Height = 13
    Caption = 'Fecha actual:'
  end
  object Label3: TLabel
    Left = 829
    Top = 24
    Width = 60
    Height = 13
    Caption = 'Saltar al d'#237'a:'
  end
  object ScrollBox1: TScrollBox
    Left = 208
    Top = 120
    Width = 561
    Height = 329
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 864
    Top = 272
    Width = 75
    Height = 73
    Caption = 'D'#237'a siguiente'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 48
    Top = 272
    Width = 75
    Height = 73
    Caption = 'D'#237'a anterior'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object DatePicker1: TDatePicker
    Left = 789
    Top = 56
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
  object Button1: TButton
    Left = 192
    Top = 72
    Width = 137
    Height = 25
    Caption = 'Volver al d'#237'a de hoy'
    TabOrder = 4
    OnClick = Button1Click
  end
end
