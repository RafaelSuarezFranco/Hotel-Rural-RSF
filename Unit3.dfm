object Tablas: TTablas
  Left = 0
  Top = 0
  Caption = 'Tablas'
  ClientHeight = 661
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 480
    Top = 152
    Width = 70
    Height = 13
    Caption = 'factura detalle'
  end
  object Label2: TLabel
    Left = 480
    Top = 216
    Width = 87
    Height = 13
    Caption = 'factura subdetalle'
  end
  object Label3: TLabel
    Left = 480
    Top = 288
    Width = 42
    Height = 13
    Caption = 'itinerario'
  end
  object Label4: TLabel
    Left = 456
    Top = 368
    Width = 94
    Height = 13
    Caption = 'itinerario subdetalle'
  end
  object Label5: TLabel
    Left = 472
    Top = 56
    Width = 75
    Height = 13
    Caption = 'query multiusos'
  end
  object Label6: TLabel
    Left = 120
    Top = 24
    Width = 74
    Height = 23
    Caption = 'TABLAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 472
    Top = 16
    Width = 88
    Height = 23
    Caption = 'QUERIES'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 467
    Top = 456
    Width = 80
    Height = 13
    Caption = 'informe din'#225'mico'
  end
  object Label9: TLabel
    Left = 457
    Top = 544
    Width = 117
    Height = 13
    Caption = 'queries para los gr'#225'ficos'
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=hotelrsf'
      'User_Name=root'
      'Password=Sevilla1%'
      'Server=torredelrey.ddns.net'
      'Port=4006')
    LoginPrompt = False
    Left = 32
    Top = 32
  end
  object FDTableHabitaciones: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.habitaciones'
    TableName = 'hotelrsf.habitaciones'
    Left = 40
    Top = 112
    object FDTableHabitacionesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDTableHabitacionesnumero: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numero'
      Origin = 'numero'
    end
    object FDTableHabitacionestipo: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'tipo'
      Origin = 'tipo'
      Size = 50
    end
    object FDTableHabitacionespreciobase: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'preciobase'
      Origin = 'preciobase'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDTableHabitaciones
    Left = 144
    Top = 112
  end
  object FDTableEntradas: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.entradas'
    TableName = 'hotelrsf.entradas'
    Left = 40
    Top = 200
    object FDTableEntradasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDTableEntradasnumerohabitacion: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numerohabitacion'
      Origin = 'numerohabitacion'
    end
    object FDTableEntradasfecha: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDTableEntradasestado: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'estado'
      Origin = 'estado'
      Size = 50
    end
    object FDTableEntradascliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cliente'
      Origin = 'cliente'
      Size = 50
    end
    object FDTableEntradaspreciofinal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'preciofinal'
      Origin = 'preciofinal'
    end
  end
  object DataSource2: TDataSource
    DataSet = FDTableEntradas
    Left = 144
    Top = 192
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from entradas;')
    Left = 584
    Top = 32
  end
  object DataSourceQuery: TDataSource
    DataSet = FDQuery1
    Left = 664
    Top = 32
  end
  object FDTableTemporadas: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.temporadas'
    TableName = 'hotelrsf.temporadas'
    Left = 40
    Top = 280
    object FDTableTemporadasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object FDTableTemporadasfechainicio: TDateField
      FieldName = 'fechainicio'
      Origin = 'fechainicio'
      Required = True
    end
    object FDTableTemporadasfechafin: TDateField
      FieldName = 'fechafin'
      Origin = 'fechafin'
      Required = True
    end
    object FDTableTemporadasprecioadicional: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'precioadicional'
      Origin = 'precioadicional'
    end
    object FDTableTemporadasnombretemporada: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombretemporada'
      Origin = 'nombretemporada'
      Size = 50
    end
  end
  object DataSource3: TDataSource
    DataSet = FDTableTemporadas
    Left = 144
    Top = 280
  end
  object FDTableServicios: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.servicios'
    TableName = 'hotelrsf.servicios'
    Left = 40
    Top = 352
    object FDTableServiciosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object FDTableServiciosnombreservicio: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombreservicio'
      Origin = 'nombreservicio'
      Size = 50
    end
    object FDTableServiciosprecioservicio: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'precioservicio'
      Origin = 'precioservicio'
    end
  end
  object DataSource4: TDataSource
    DataSet = FDTableServicios
    Left = 144
    Top = 352
  end
  object FDTableEntradasservicios: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.entradasservicios'
    TableName = 'hotelrsf.entradasservicios'
    Left = 40
    Top = 432
    object FDTableEntradasserviciosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDTableEntradasserviciosnumerohabitacion: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numerohabitacion'
      Origin = 'numerohabitacion'
    end
    object FDTableEntradasserviciosfecha: TDateField
      FieldName = 'fecha'
      Origin = 'fecha'
      Required = True
    end
    object FDTableEntradasserviciosnombreservicio: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombreservicio'
      Origin = 'nombreservicio'
      Size = 50
    end
  end
  object DataSource5: TDataSource
    DataSet = FDTableEntradasservicios
    Left = 144
    Top = 432
  end
  object FDTableHistoricoentradas: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.historicoentradas'
    TableName = 'hotelrsf.historicoentradas'
    Left = 40
    Top = 512
    object FDTableHistoricoentradasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object FDTableHistoricoentradasnumerohabitacion: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'numerohabitacion'
      Origin = 'numerohabitacion'
    end
    object FDTableHistoricoentradasfecha: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDTableHistoricoentradascliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cliente'
      Origin = 'cliente'
      Size = 50
    end
    object FDTableHistoricoentradaspreciofinal: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'preciofinal'
      Origin = 'preciofinal'
    end
    object FDTableHistoricoentradasestado: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'estado'
      Origin = 'estado'
      Size = 50
    end
  end
  object DataSource6: TDataSource
    DataSet = FDTableHistoricoentradas
    Left = 144
    Top = 512
  end
  object FDTableClientes: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.clientes'
    TableName = 'hotelrsf.clientes'
    Left = 40
    Top = 592
    object FDTableClientesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object FDTableClientesidentificador: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'identificador'
      Origin = 'identificador'
      Size = 50
    end
    object FDTableClientesnombre: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 100
    end
    object FDTableClientesapellidos: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'apellidos'
      Origin = 'apellidos'
      Size = 150
    end
  end
  object DataSource7: TDataSource
    DataSet = FDTableClientes
    Left = 144
    Top = 592
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select numerohabitacion as numero, fecha as fechaentrada, estado' +
        ', cliente, preciofinal from entradas where fecha > '#39'2022-01-01'#39' ' +
        'and fecha < '#39'2022-03-02'#39' and numerohabitacion = 1')
    Left = 584
    Top = 128
  end
  object FDQuery3: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT numerohabitacion AS numerohservicio, fecha AS fechaservic' +
        'io, e.nombreservicio, precioservicio FROM entradasservicios e, s' +
        'ervicios s WHERE e.nombreservicio = s.nombreservicio')
    Left = 584
    Top = 208
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select nombreservicio as nombre from servicios;')
    Left = 584
    Top = 280
  end
  object FDQuery5: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select numerohabitacion as numero from entradasservicios where f' +
        'echa = '#39'2022-03-02'#39)
    Left = 584
    Top = 352
  end
  object FDQuery6: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from entradas')
    Left = 584
    Top = 440
  end
  object FDQuery7: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT SUM(preciofinal) AS total, fecha as fechaentrada FROM ent' +
        'radas WHERE estado = "ocupada" GROUP BY fecha ORDER BY fecha LIM' +
        'IT 6')
    Left = 608
    Top = 520
  end
  object FDQuery8: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT SUM(s.precioservicio) AS total, es.nombreservicio AS serv' +
        'icio FROM entradasservicios es, servicios s '
      'WHERE es.nombreservicio = s.nombreservicio AND '
      
        'numerohabitacion = 5 GROUP BY es.nombreservicio ORDER BY  SUM(s.' +
        'precioservicio)')
    Left = 680
    Top = 520
  end
  object FDTableUsuarios: TFDTable
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.usuarios'
    TableName = 'hotelrsf.usuarios'
    Left = 232
    Top = 592
    object FDTableUsuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ReadOnly = True
    end
    object FDTableUsuariosusuario: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'usuario'
      Origin = 'usuario'
      Size = 50
    end
    object FDTableUsuarioscorreo: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'correo'
      Origin = 'correo'
      Size = 50
    end
    object FDTableUsuarioscliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cliente'
      Origin = 'cliente'
      Size = 50
    end
    object FDTableUsuariosperfil: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'perfil'
      Origin = 'perfil'
      Size = 50
    end
    object FDTableUsuariospassword: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'password'
      Origin = '`password`'
      Size = 50
    end
  end
end
