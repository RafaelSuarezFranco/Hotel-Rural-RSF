object Tablas: TTablas
  Left = 0
  Top = 0
  Caption = 'Tablas'
  ClientHeight = 531
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
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=hotelrsf'
      'User_Name=root'
      'Password=admin')
    Connected = True
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
    Active = True
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
    Active = True
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
    Active = True
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
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.historicoentradas'
    TableName = 'hotelrsf.historicoentradas'
    Left = 240
    Top = 120
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
    Left = 344
    Top = 120
  end
  object FDTableClientes: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'hotelrsf.clientes'
    TableName = 'hotelrsf.clientes'
    Left = 240
    Top = 200
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
    Left = 344
    Top = 200
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select numerohabitacion as numero, fecha as fechaentrada, estado' +
        ', cliente, preciofinal from entradas where fecha > '#39'2022-01-01'#39' ' +
        'and fecha < '#39'2022-03-01'#39)
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
    Top = 200
  end
end
