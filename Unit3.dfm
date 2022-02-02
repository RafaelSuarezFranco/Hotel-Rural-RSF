object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
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
end
