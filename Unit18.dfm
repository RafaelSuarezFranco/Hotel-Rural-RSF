object AltaUsuario: TAltaUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'AltaUsuario'
  ClientHeight = 398
  ClientWidth = 303
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
    Left = 24
    Top = 93
    Width = 94
    Height = 13
    Caption = 'Nombre de usuario:'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 24
    Top = 45
    Width = 92
    Height = 13
    Caption = 'Correo electr'#243'nico:'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 24
    Top = 144
    Width = 107
    Height = 13
    Caption = 'Cliente (identificador):'
    FocusControl = DBEdit3
  end
  object Label5: TLabel
    Left = 24
    Top = 240
    Width = 60
    Height = 13
    Caption = 'Contrase'#241'a:'
    FocusControl = DBEdit5
  end
  object Label4: TLabel
    Left = 24
    Top = 285
    Width = 92
    Height = 13
    Caption = 'Repite contrase'#241'a:'
  end
  object DBEdit1: TDBEdit
    Left = 24
    Top = 109
    Width = 249
    Height = 21
    DataField = 'usuario'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 24
    Top = 58
    Width = 249
    Height = 21
    DataField = 'correo'
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBEdit3: TDBEdit
    Left = 24
    Top = 160
    Width = 249
    Height = 21
    DataField = 'cliente'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBEdit5: TDBEdit
    Left = 24
    Top = 256
    Width = 249
    Height = 21
    DataField = 'password'
    DataSource = DataSource1
    PasswordChar = '*'
    TabOrder = 4
  end
  object Button1: TButton
    Left = 50
    Top = 336
    Width = 89
    Height = 41
    Caption = 'Aceptar'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 336
    Width = 91
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 7
    OnClick = Button2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 193
    Width = 249
    Height = 41
    Caption = 'Perfil:'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'cliente'
      'admin')
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 24
    Top = 304
    Width = 249
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
  end
  object DataSource1: TDataSource
    DataSet = Tablas.FDTableUsuarios
    Left = 232
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 112
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 168
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 48
  end
end
