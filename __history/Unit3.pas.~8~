unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TTablas = class(TForm)
    FDConnection1: TFDConnection;
    FDTableHabitaciones: TFDTable;
    DataSource1: TDataSource;
    FDTableEntradas: TFDTable;
    FDTableEntradasid: TFDAutoIncField;
    FDTableEntradasnumerohabitacion: TIntegerField;
    FDTableEntradasfecha: TDateField;
    FDTableEntradasestado: TStringField;
    FDTableEntradascliente: TStringField;
    FDTableEntradaspreciofinal: TSingleField;
    DataSource2: TDataSource;
    FDTableHabitacionesid: TFDAutoIncField;
    FDTableHabitacionesnumero: TIntegerField;
    FDTableHabitacionestipo: TStringField;
    FDTableHabitacionespreciobase: TSingleField;
    FDQuery1: TFDQuery;
    DataSourceQuery: TDataSource;
    FDTableTemporadas: TFDTable;
    DataSource3: TDataSource;
    FDTableTemporadasid: TFDAutoIncField;
    FDTableTemporadasfechainicio: TDateField;
    FDTableTemporadasfechafin: TDateField;
    FDTableTemporadasprecioadicional: TFloatField;
    FDTableTemporadasnombretemporada: TStringField;
    FDTableServicios: TFDTable;
    DataSource4: TDataSource;
    FDTableEntradasservicios: TFDTable;
    DataSource5: TDataSource;
    FDTableServiciosid: TFDAutoIncField;
    FDTableServiciosnombreservicio: TStringField;
    FDTableServiciosprecioservicio: TFloatField;
    FDTableEntradasserviciosid: TFDAutoIncField;
    FDTableEntradasserviciosnumerohabitacion: TIntegerField;
    FDTableEntradasserviciosfecha: TDateField;
    FDTableEntradasserviciosnombreservicio: TStringField;
    FDTableHistoricoentradas: TFDTable;
    DataSource6: TDataSource;
    FDTableHistoricoentradasid: TFDAutoIncField;
    FDTableHistoricoentradasnumerohabitacion: TIntegerField;
    FDTableHistoricoentradasfecha: TDateField;
    FDTableHistoricoentradascliente: TStringField;
    FDTableHistoricoentradaspreciofinal: TSingleField;
    FDTableHistoricoentradasestado: TStringField;
    FDTableClientes: TFDTable;
    FDTableClientesid: TFDAutoIncField;
    FDTableClientesidentificador: TStringField;
    FDTableClientesnombre: TStringField;
    FDTableClientesapellidos: TStringField;
    DataSource7: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tablas: TTablas;

implementation

{$R *.dfm}

end.
