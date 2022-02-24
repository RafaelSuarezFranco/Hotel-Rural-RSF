object AltaServicio: TAltaServicio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
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
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 24
    Width = 177
    Height = 18
    Caption = 'Nombre del nuevo servicio:'
    FocusControl = DBEdit1
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
    FocusControl = DBEdit2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBEdit1: TDBEdit
    Left = 32
    Top = 48
    Width = 193
    Height = 21
    DataField = 'nombreservicio'
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 32
    Top = 120
    Width = 193
    Height = 21
    DataField = 'precioservicio'
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 32
    Top = 160
    Width = 89
    Height = 41
    Caption = 'Aceptar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 134
    Top = 160
    Width = 91
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = Tablas.FDTableServicios
    Left = 184
    Top = 72
  end
end
