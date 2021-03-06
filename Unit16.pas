unit Unit16;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Data.DB, VCLTee.TeeEdiGene, //ChartPreview
  Vcl.Grids, Vcl.DBGrids, Vcl.WinXCalendars, Vcl.StdCtrls, System.DateUtils;

type
  TGraficosReservas = class(TForm)
    Chart1: TChart;
    CalendarView1: TCalendarView;
    Label1: TLabel;
    Label2: TLabel;
    CalendarView2: TCalendarView;
    Series1: TBarSeries;
    RadioGroup1: TRadioGroup;
    Series2: TBarSeries;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure CalendarView1Change(Sender: TObject);
    procedure CalendarView2Change(Sender: TObject);
    procedure actualizarGrafico();
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GraficosReservas: TGraficosReservas;
  fechainicio: TDate;
  fechafin: TDate;
  estado: string;
  colorbarra: Tcolor;
  primeraejecucion : boolean;

implementation

{$R *.dfm}

uses
  Unit3;

  {
  Series[0] -> gr?fico de ingresos (color azul)
  Series[1] -> gr?fico de reservas (amarillo) u ocupaciones (rojo)
  }


  //permite imprimir el gr?fico (pdf)

procedure TGraficosReservas.Button1Click(Sender: TObject);
begin
  try
      ChartPreview(Self,Chart1);
     //Chart1.print;

  except
    showmessage('No se ha guardado el gr?fico.');
  end;
end;



//procedimientos para cambiar las fechas l?mites de la consulta del gr?fico, con las validaciones pertientes

procedure TGraficosReservas.CalendarView1Change(Sender: TObject);
var
fecharespaldo: TDate;
begin

  fecharespaldo :=  fechainicio;
  try
    fechainicio:= CalendarView1.Date;

     if fechainicio > fechafin then
      begin
         showmessage('Fecha inicio no deber?a ser mayor que fecha fin');
      end else
      begin
        actualizarGrafico();
      end;
  except
    fechainicio:= fecharespaldo;
    actualizarGrafico();
    //si clickamos en el mismo d?a, esto da un error, es como si se deseleccionase el d?a y por
    //tanto la fecha selecionada es igual a 00/00/0000
  end;
end;


procedure TGraficosReservas.CalendarView2Change(Sender: TObject);
var
fecharespaldo: TDate;
begin

  fecharespaldo :=  fechafin;
  try
    fechafin:= CalendarView2.Date;

    if fechafin < fechainicio then
      begin
        showmessage('Fecha fin no deber?a ser menor que fecha inicio');
      end else
      begin
        actualizarGrafico();
      end;

  except
    fechafin:= fecharespaldo;
    actualizarGrafico();
  end;
end;



//inicializar variables por defecto y algunas propiedades para que el gr?fico funcione bien

procedure TGraficosReservas.FormActivate(Sender: TObject);
 var
 cantidadhabitaciones :integer;
begin
  cantidadhabitaciones := Tablas.FDTableHabitaciones.RecordCount;
  primeraejecucion:= true;

  estado := 'reservada';
  colorbarra := clYellow;
  fechainicio := IncMonth(Now(),-1);    //inicializamos el gr?fico con fecha de hoy a un mes en adelante
  fechafin :=  IncMonth(Now(), 1);
  CalendarView1.Date :=  fechainicio;
  CalendarView2.Date :=  fechafin;

  //hay un peque?o error por el cual si hacemos zoom en el gr?fico (en delphi) se desactivan estas propiedades, que son
  //necesarias para visualizar el gr?fico.
  Chart1.BottomAxis.Automatic := true;
  Chart1.LeftAxis.Automatic := true;
  Chart1.RightAxis.Automatic := true;

  Chart1.RightAxis.Minimum := 0;
  Chart1.RightAxis.Maximum := cantidadhabitaciones;


   Chart1.Series[0].VertAxis := aLeftAxis;
   Chart1.Series[1].VertAxis := aRightAxis;

  actualizarGrafico();
  primeraejecucion:= false;
end;



  //muestra ocupaciones o reservas en el gr?fico

procedure TGraficosReservas.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    begin
      estado := 'reservada';
      colorbarra := clYellow;
    end;
  if RadioGroup1.ItemIndex = 1 then
    begin
     estado := 'ocupada';
     colorbarra := clRed;

    end;
  actualizarGrafico();
end;



//refresca el gr?fico con los par?metros que vamos cambiando en la interfaz

procedure TGraficosReservas.actualizarGrafico();
var
fecha: TDate;
total: double;
habitaciones: integer;
fechai : string;
fechaF: string;
begin
    Chart1.Series[0].Clear;
    Chart1.Series[1].Clear;

    fechai := Tablas.formatearFechaSQL(fechainicio);
    fechaf := Tablas.formatearFechaSQL(fechafin);

   Tablas.FDQuery7.Close;
   Tablas.FDQuery7.SQL.Text := 'SELECT SUM(preciofinal) AS total, count(*) as habitaciones, fecha FROM entradas '+
   ' WHERE estado = '+quotedstr(estado)+' and fecha >='+quotedstr(fechai)+' and fecha <= '+quotedstr(fechaf)
   +' GROUP BY fecha ORDER BY fecha';
   Tablas.FDQuery7.Open;

   if Tablas.FDQuery7.RecordCount = 0 then
    begin
       if not primeraejecucion then  showmessage('No se han encontrado registros con los par?metros especificados.');
    end else
    begin
       Tablas.FDQuery7.first;
       while not Tablas.FDQuery7.eof do
          begin
            fecha := Tablas.FDQuery7.FieldByName('fecha').Value;
            total := Tablas.FDQuery7.FieldByName('total').Value;
            habitaciones := Tablas.FDQuery7.FieldByName('habitaciones').Value;

            Chart1.Series[0].AddXY(fecha, total, datetostr(fecha), clTeeColor); //ingresos
            Chart1.Series[1].AddXY(fecha, habitaciones, datetostr(fecha), colorbarra);   //reservas/ocupaciones
            Tablas.FDQuery7.next;
          end;
    end;



end;


procedure TGraficosReservas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_ESCAPE then  GraficosReservas.Close;
end;

end.
