object AltaCliente: TAltaCliente
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AltaCliente'
  ClientHeight = 305
  ClientWidth = 283
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
    Left = 17
    Top = 40
    Width = 94
    Height = 13
    Caption = 'Identificador (DNI):'
  end
  object Label2: TLabel
    Left = 17
    Top = 93
    Width = 41
    Height = 13
    Caption = 'Nombre:'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 17
    Top = 149
    Width = 46
    Height = 13
    Caption = 'Apellidos:'
    FocusControl = DBEdit3
  end
  object DBEdit2: TDBEdit
    Left = 17
    Top = 112
    Width = 240
    Height = 21
    DataField = 'nombre'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 17
    Top = 168
    Width = 240
    Height = 21
    DataField = 'apellidos'
    DataSource = DataSource1
    TabOrder = 2
  end
  object Button1: TButton
    Left = 89
    Top = 224
    Width = 105
    Height = 41
    Caption = 'Dar de alta'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 17
    Top = 59
    Width = 240
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'Edit1'
  end
  object DataSource1: TDataSource
    DataSet = Tablas.FDTableClientes
    Left = 200
    Top = 8
  end
end
