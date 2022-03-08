unit Unit17;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.StdCtrls, VCLTee.TeeEdiGene, //ChartPreview
  Vcl.WinXCalendars;

type
  TGraficosServicios = class(TForm)
    Chart1: TChart;
    Series1: TPieSeries;
    ComboBox1: TComboBox;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    CalendarView1: TCalendarView;
    CalendarView2: TCalendarView;
    CheckBox1: TCheckBox;
    Button1: TButton;

    procedure actualizarGrafico();
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CalendarView1Change(Sender: TObject);
    procedure CalendarView2Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GraficosServicios: TGraficosServicios;
  habitacion : string;
  estado : string;
  fechainicio: TDate;
  fechafin: TDate;
  primeraejecucion : boolean;
  todashabitaciones : boolean;

implementation

{$R *.dfm}

Uses
  Unit3;

procedure TGraficosServicios.FormActivate(Sender: TObject);
begin
    primeraejecucion:= true;

    Combobox1 := Tablas.rellenarComboHabitaciones(Combobox1);
    habitacion := combobox1.items[0];
    estado := 'ocupada';
    fechainicio := IncMonth(Now(),-1);    //inicializamos el gráfico con fecha de hoy a un mes en adelante
    fechafin :=  IncMonth(Now(), 1);
    CalendarView1.Date :=  fechainicio;
    CalendarView2.Date :=  fechafin;
    todashabitaciones := false;

   actualizarGrafico();
   primeraejecucion:= false;
end;



procedure TGraficosServicios.Button1Click(Sender: TObject);
begin
  try
      ChartPreview(Self,Chart1);
     //Chart1.print;

  except
    showmessage('No se ha guardado el gráfico.');
  end;
end;


procedure TGraficosServicios.CalendarView1Change(Sender: TObject);
var
fecharespaldo: TDate;
begin

  fecharespaldo :=  fechainicio;
  try
    fechainicio:= CalendarView1.Date;

     if fechainicio > fechafin then
      begin
         showmessage('Fecha inicio no debería ser mayor que fecha fin');
      end else
      begin
        actualizarGrafico();
      end;
  except
    fechainicio:= fecharespaldo;
    actualizarGrafico();
    //si clickamos en el mismo día, esto da un error, es como si se deseleccionase el día y por
    //tanto la fecha selecionada es igual a 00/00/0000
  end;
end;


procedure TGraficosServicios.CalendarView2Change(Sender: TObject);
var
fecharespaldo: TDate;
begin

  fecharespaldo :=  fechafin;
  try
    fechafin:= CalendarView2.Date;

    if fechafin < fechainicio then
      begin
        showmessage('Fecha fin no debería ser menor que fecha inicio');
      end else
      begin
        actualizarGrafico();
      end;

  except
    fechafin:= fecharespaldo;
    actualizarGrafico();
  end;
end;

procedure TGraficosServicios.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
      begin
        todashabitaciones := true;
        actualizarGrafico();
      end
  else todashabitaciones := false;

end;

procedure TGraficosServicios.ComboBox1Change(Sender: TObject);
begin
   habitacion := combobox1.items[combobox1.Itemindex];
   actualizarGrafico();
   Checkbox1.Checked := false;
end;


procedure TGraficosServicios.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    begin
      estado := 'reservada';
    end;
  if RadioGroup1.ItemIndex = 1 then
    begin
     estado := 'ocupada';
    end;
  actualizarGrafico();
end;

procedure TGraficosServicios.actualizarGrafico();
var
nombreservicio: string;
total :double;
fechai : string;
fechaf: string;
sql : string;
  begin
     Chart1.Series[0].Clear;

     fechai := Tablas.formatearFechaSQL(fechainicio);
    fechaf := Tablas.formatearFechaSQL(fechafin);

    Tablas.FDQuery8.Close;
    sql := 'SELECT SUM(s.precioservicio) AS total, es.nombreservicio AS servicio FROM '+
    'entradasservicios es, servicios s, entradas e WHERE es.nombreservicio = s.nombreservicio AND es.fecha = e.fecha '+
    'AND es.numerohabitacion = e.numerohabitacion AND  ' +
    'es.fecha >= ' + quotedstr(fechai) + ' AND es.fecha <= '+ quotedstr(fechaf);

    if not todashabitaciones then
      begin
        sql := sql +  ' AND es.numerohabitacion = '+habitacion;
      end;

    sql := sql + ' AND e.estado = '+ quotedstr(estado)+ ' GROUP BY es.nombreservicio ORDER BY  SUM(s.precioservicio)';

    Tablas.FDQuery8.SQL.Text := sql;
    Tablas.FDQuery8.Open;


   if Tablas.FDQuery8.RecordCount = 0 then
    begin
      if not primeraejecucion then  showmessage('No se han encontrado registros con los parámetros especificados.');
    end else
    begin
       Tablas.FDQuery8.first;
       while not Tablas.FDQuery8.eof do
          begin
            nombreservicio := Tablas.FDQuery8.FieldByName('servicio').Value;
            total := Tablas.FDQuery8.FieldByName('total').Value;


            Chart1.Series[0].Add(total, nombreservicio); //ingresos por habitación específica
            Tablas.FDQuery8.next;
          end;
    end;


  end;



end.
