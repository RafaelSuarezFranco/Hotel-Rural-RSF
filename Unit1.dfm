object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Principal'
  ClientHeight = 577
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 400
    Top = 32
    Width = 169
    Height = 23
    Caption = 'Fecha seleccionada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 200
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
    Left = 200
    Top = 120
    Width = 577
    Height = 385
    PopupMenu = PopupMenu2
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 864
    Top = 272
    Width = 75
    Height = 73
    Caption = 'D'#237'a siguiente'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 48
    Top = 272
    Width = 75
    Height = 73
    Caption = 'D'#237'a anterior'
    TabOrder = 1
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
    TabOrder = 4
    OnChange = DatePicker1Change
  end
  object Button1: TButton
    Left = 192
    Top = 72
    Width = 137
    Height = 25
    Caption = 'Volver al d'#237'a de hoy'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 424
    Width = 129
    Height = 49
    Caption = 'Reservar periodo'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 48
    Top = 488
    Width = 129
    Height = 49
    Caption = 'Anular periodo'
    TabOrder = 6
    OnClick = Button3Click
  end
  object PopupMenu1: TPopupMenu
    Left = 912
    Top = 392
    object administrarpopup: TMenuItem
      Caption = 'Administrar'
      OnClick = administrarpopupClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 912
    Top = 456
    object CrearHabitacin1: TMenuItem
      Caption = 'Crear Habitaci'#243'n'
      OnClick = CrearHabitacin1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 40
    object CrearTemporada1: TMenuItem
      Caption = 'Crear'
      object Habitacin1: TMenuItem
        Caption = 'Habitaci'#243'n'
        OnClick = Habitacin1Click
      end
      object creartemp: TMenuItem
        Caption = 'Temporada'
        OnClick = creartempClick
      end
      object Servicio1: TMenuItem
        Caption = 'Servicio'
        OnClick = Servicio1Click
      end
    end
    object Creartemp1: TMenuItem
      Caption = 'Borrar'
    end
  end
end
