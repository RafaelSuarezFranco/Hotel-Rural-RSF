object AltaServicio: TAltaServicio
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AltaServicio'
  ClientHeight = 220
  ClientWidth = 261
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
    Top = 24
    Width = 177
    Height = 18
    Caption = 'Nombre del nuevo servicio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 88
    Width = 118
    Height = 18
    Caption = 'Precio del servicio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 32
    Top = 160
    Width = 89
    Height = 41
    Caption = 'Aceptar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 134
    Top = 160
    Width = 91
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 48
    Width = 177
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 32
    Top = 112
    Width = 177
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
end
