object Principal: TPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Principal'
  ClientHeight = 646
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  StyleElements = [seClient, seBorder]
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
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
    Left = 864
    Top = 46
    Width = 60
    Height = 13
    Caption = 'Saltar al d'#237'a:'
  end
  object Label4: TLabel
    Left = 8
    Top = 592
    Width = 40
    Height = 13
    Caption = 'Usuario:'
  end
  object Label5: TLabel
    Left = 8
    Top = 609
    Width = 28
    Height = 13
    Caption = 'Perfil:'
  end
  object Label6: TLabel
    Left = 54
    Top = 592
    Width = 31
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 54
    Top = 609
    Width = 31
    Height = 13
    Caption = 'Label7'
  end
  object Label8: TLabel
    Left = 8
    Top = 625
    Width = 37
    Height = 13
    Caption = 'Cliente:'
  end
  object Label9: TLabel
    Left = 54
    Top = 625
    Width = 31
    Height = 13
    Caption = 'Label9'
  end
  object ScrollBox1: TScrollBox
    Left = 183
    Top = 120
    Width = 577
    Height = 449
    PopupMenu = PopupMenu2
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 864
    Top = 287
    Width = 75
    Height = 73
    Caption = 'D'#237'a siguiente'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 48
    Top = 287
    Width = 75
    Height = 73
    Caption = 'D'#237'a anterior'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object DatePicker1: TDatePicker
    Left = 575
    Top = 29
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
    Top = 408
    Width = 129
    Height = 49
    Caption = '&Reservar periodo'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 48
    Top = 463
    Width = 129
    Height = 49
    Caption = '&Anular periodo'
    TabOrder = 6
    OnClick = Button3Click
  end
  object CalendarView1: TCalendarView
    Left = 799
    Top = 65
    Width = 200
    Height = 203
    Date = 44621.000000000000000000
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
    HeaderInfo.DaysOfWeekFont.Color = clWindowText
    HeaderInfo.DaysOfWeekFont.Height = -13
    HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
    HeaderInfo.DaysOfWeekFont.Style = []
    HeaderInfo.Font.Charset = DEFAULT_CHARSET
    HeaderInfo.Font.Color = clWindowText
    HeaderInfo.Font.Height = -15
    HeaderInfo.Font.Name = 'Segoe UI'
    HeaderInfo.Font.Style = []
    OnChange = CalendarView1Change
    ParentFont = False
    TabOrder = 7
  end
  object Button4: TButton
    Left = 10
    Top = 561
    Width = 63
    Height = 25
    Caption = 'Logout'
    TabOrder = 8
    OnClick = Button4Click
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
    object CrearEntidades: TMenuItem
      Caption = '&Crear'
      object Habitacin1: TMenuItem
        Caption = 'Habitaci'#243'n'
        OnClick = Habitacin1Click
      end
      object Servicio1: TMenuItem
        Caption = 'Servicio'
        OnClick = Servicio1Click
      end
      object creartemp: TMenuItem
        Caption = 'Temporada'
        OnClick = creartempClick
      end
      object Usuario1: TMenuItem
        Caption = 'Usuario'
        OnClick = Usuario1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
    end
    object EditarEntidades: TMenuItem
      Caption = '&Editar'
      OnClick = EditarEntidadesClick
      object Habitacin2: TMenuItem
        Caption = 'Habitaci'#243'n'
        OnClick = Habitacin2Click
      end
      object Servicio2: TMenuItem
        Caption = 'Servicio'
        OnClick = Servicio2Click
      end
      object emporada1: TMenuItem
        Caption = 'Temporada'
        OnClick = emporada1Click
      end
      object Usuario2: TMenuItem
        Caption = 'Usuario'
        OnClick = Usuario2Click
      end
    end
    object Creartemp1: TMenuItem
      Caption = '&Informes'
      object Factura1: TMenuItem
        Caption = '&Factura'
        OnClick = Factura1Click
      end
      object ItinerariodeServicios1: TMenuItem
        Caption = '&Itinerario de Servicios'
        OnClick = ItinerariodeServicios1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object TodosClientes: TMenuItem
        Caption = '&Clientes'
        OnClick = TodosClientesClick
      end
      object historialCliente: TMenuItem
        Caption = '&Historial por cliente'
        OnClick = historialClienteClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Informedinmico1: TMenuItem
        Caption = 'Informe din'#225'mico'
        OnClick = Informedinmico1Click
      end
    end
    object graficos: TMenuItem
      Caption = '&Gr'#225'ficos'
      object IngresosReservas1: TMenuItem
        Caption = 'Ingresos - &Reservas'
        OnClick = IngresosReservas1Click
      end
      object IngresosServicios1: TMenuItem
        Caption = 'Ingresos - &Servicios'
        OnClick = IngresosServicios1Click
      end
    end
  end
end
