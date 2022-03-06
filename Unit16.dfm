object GraficosReservas: TGraficosReservas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'GraficosReservas'
  ClientHeight = 587
  ClientWidth = 1044
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
    Left = 841
    Top = 20
    Width = 105
    Height = 23
    Caption = 'Fecha inicio:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 841
    Top = 242
    Width = 84
    Height = 23
    Caption = 'Fecha fin:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Chart1: TChart
    Left = 24
    Top = 8
    Width = 795
    Height = 549
    ScrollMouseButton = mbLeft
    Title.Text.Strings = (
      'Ingresos por d'#237'a')
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 6.790576147851185000
    BottomAxis.Minimum = -1.790576147851186000
    BottomAxis.Title.Caption = 'fecha (diario)'
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 248.018875165607000000
    LeftAxis.Minimum = -38.840977591459860000
    LeftAxis.Title.Caption = 'ingresos (ocupaciones)'
    Panning.MouseWheel = pmwNone
    RightAxis.Automatic = False
    RightAxis.AutomaticMaximum = False
    RightAxis.AutomaticMinimum = False
    RightAxis.Maximum = 18.360520776853680000
    RightAxis.MaximumRound = True
    RightAxis.Minimum = 1.639479223146331000
    RightAxis.MinimumRound = True
    RightAxis.Title.Caption = 'cantidad de habitaciones'
    TopAxis.Automatic = False
    TopAxis.AutomaticMaximum = False
    TopAxis.AutomaticMinimum = False
    TopAxis.Maximum = 0.002645263871662107
    TopAxis.Minimum = -0.002645263871662107
    Zoom.MouseButton = mbMiddle
    Zoom.MouseWheel = pmwNormal
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      21
      15
      21)
    ColorPaletteIndex = 13
    object Series1: TBarSeries
      BarBrush.BackColor = clDefault
      Marks.Visible = False
      Marks.Callout.Length = 8
      Title = 'Gr'#225'fico ingresos'
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
    object Series2: TBarSeries
      HorizAxis = aBothHorizAxis
      Marks.Visible = False
      PercentFormat = '0'
      Title = 'Grafico reservas'
      ValueFormat = '0'
      VertAxis = aRightAxis
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Bar'
      YValues.Order = loNone
    end
  end
  object CalendarView1: TCalendarView
    Left = 841
    Top = 49
    Width = 184
    Height = 184
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
    TabOrder = 1
  end
  object CalendarView2: TCalendarView
    Left = 836
    Top = 279
    Width = 184
    Height = 184
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
    OnChange = CalendarView2Change
    ParentFont = False
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 841
    Top = 469
    Width = 195
    Height = 53
    Caption = 'Estado'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'reservado'
      'ocupado')
    ParentFont = False
    TabOrder = 3
    OnClick = RadioGroup1Click
  end
  object Button1: TButton
    Left = 871
    Top = 528
    Width = 122
    Height = 51
    Caption = 'Exportar a PDF'
    TabOrder = 4
    OnClick = Button1Click
  end
end
