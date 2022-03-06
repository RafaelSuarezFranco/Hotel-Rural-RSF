unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,   System.DateUtils,
  FireDAC.Comp.Client, Vcl.StdCtrls;

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
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FDQuery4: TFDQuery;
    FDQuery5: TFDQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    FDQuery6: TFDQuery;
    Label8: TLabel;
    FDQuery7: TFDQuery;
    Label9: TLabel;
    FDQuery8: TFDQuery;


    function formatearFechaSQL(fecha: TDate):String;
    function rellenarComboHabitaciones(combo: TComboBox):TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tablas: TTablas;

implementation

{$R *.dfm}

//formatea una fecha de tipo TDate a una String que se pueda usar en las FDQueries.

function TTablas.formatearFechaSQL(fecha: TDate): String;
  var
  diabusqueda: String;
  mesbusqueda: String;
  fechabusqueda: String;
begin
    diabusqueda := IntToStr(DayOfTheMonth(fecha));
    mesbusqueda := IntToStr(MonthOfTheYear(fecha));
    if length(diabusqueda) < 2 then
        diabusqueda:= '0'+ diabusqueda;
    if length(mesbusqueda) < 2 then
        mesbusqueda:= '0'+ mesbusqueda;
    fechabusqueda:= IntToStr(YearOf(fecha))+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

    formatearFechaSQL := fechabusqueda;
end;



//recibe un combobox a rellenar, lo vac�a y lo rellena con los n�meros de habitaci�n.

function TTablas.rellenarComboHabitaciones(combo: TComboBox):TComboBox;
  var
cantidadHabitaciones: integer;
i : integer;
begin
    i:=0;
    cantidadHabitaciones:= Tablas.FDTableHabitaciones.RecordCount;

    combo.Items.Clear; //vaciar el combobox para rellenarlo con las habitaciones
    Tablas.FDTableHabitaciones.First;
      while not  Tablas.FDTableHabitaciones.Eof do
        begin
          combo.Items.Add(IntToStr(Tablas.FDTableHabitacionesnumero.Value));
          i:=i+1;
          Tablas.FDTableHabitaciones.Next;
        end;

    combo.Style := csDropDownList; //readonly
    combo.ItemIndex := 0; //selecciona el primero

    rellenarComboHabitaciones := combo;
end;

end.
