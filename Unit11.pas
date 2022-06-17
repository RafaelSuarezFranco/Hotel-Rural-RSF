unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuickRpt, QRCtrls, Vcl.ExtCtrls, System.DateUtils,
  qrpctrls, SGExpBarChart, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.Series;

type
  TFactura = class(TForm)
    quickreport1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRPDBText2: TQRPDBText;
    QRGroup2: TQRGroup;
    QRPDBText1: TQRPDBText;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRShape2: TQRShape;
    QRLabel7: TQRLabel;
    QRBand5: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel8: TQRLabel;
    QRLabel11: TQRLabel;
    QRSysData2: TQRSysData;
    QRBand4: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure imprimirFechas(fecha1: TDate; fecha2: TDate);
    procedure imprimirCliente(cliente: string);

  private
    { Private declarations }
  public
    { Public declarations }
      CostoTotal: Double;
      CantidadDias: integer;
      Fechainicio: String;
      Fechafin: String;
  end;

var
  Factura: TFactura;

implementation

{$R *.dfm}
  uses
    Unit3;

procedure TFactura.FormActivate(Sender: TObject);
begin

end;


//este informe vale tanto para una factura de una habitaci�n como para el historial de un cliente


//para hacer agrupaciones, la idea es recorrer la tabla con los datos por los que vamos a agrupar, y por cada registro,
//con esos datos, hacemos una consulta para rellenar los subdetalles. Es un group by artesanal, por as� decirlo.

procedure TFactura.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var
  fecha: TDate;
  habitacion: integer;
  precio: double;
  fechabusqueda: String;
  estado: String;

  banda : TQRBand;
begin
  //la consulta principal viene dada desde fuera, pero la subconsulta la construimos aqu�, dado que debe
  //cambiar seg�n la informaci�n obtenida de la consulta principal

  fecha := Tablas.FDQuery2.FieldByName('fechaentrada').Value;
  habitacion := Tablas.FDQuery2.FieldByName('numero').Value;
  precio := Tablas.FDQuery2.FieldByName('preciofinal').Value;
  estado := Tablas.FDQuery2.FieldByName('estado').Value;

  CostoTotal:= CostoTotal + precio;
  CantidadDias:= CantidadDias + 1;

  QRLabel13.Caption := FloatToStr(Round(CostoTotal*100)/100);
  QRLabel15.Caption := inttostr(CantidadDias);

  fechabusqueda:= Tablas.formatearFechaSQL(fecha);

  Tablas.FDQuery3.close;
  Tablas.FDQuery3.SQL.Text := 'SELECT numerohabitacion AS numerohservicio, fecha AS fechaservicio, e.nombreservicio, precioservicio FROM entradasservicios e, servicios s WHERE e.nombreservicio = s.nombreservicio';
  Tablas.FDQuery3.SQL.Text := Tablas.FDQuery3.SQL.Text + ' and numerohabitacion = '+inttostr(habitacion)+' and fecha = '+quotedstr(fechabusqueda);

  Tablas.FDQuery3.open;


  //cambiar el color de la banda en funci�n de si est� ocupada o reservada

banda := TQRBand(Sender);
  if estado = 'reservada' then
    begin
      banda.Color:= TColor(RGB(252,252,166));
    end;
  if estado = 'ocupada' then
    begin
     banda.Color:=  TColor(RGB(255,150,150));
    end;



end;




//muestra un mensaje si una reserva/ocupaci�n no tiene servicios asociados

procedure TFactura.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var
  banda : TQRBand;
begin
banda := TQRBand(Sender);
   if Tablas.FDQuery3.RecordCount = 0 then
   begin
     QRLabel7.Caption := 'Sin servicios contratados';
     QRShape2.width := 0;
   end else
   begin
     QRLabel7.Caption := '';
     QRShape2.width := 433;
   end;


end;



//muestra las fechas seleccionadas

 procedure TFactura.imprimirFechas(fecha1: TDate; fecha2: TDate);
 begin
    QRLabel1.Caption := 'FACTURA - INFORME POR PERIODO';
    QRLabel16.Caption := 'Del d�a ' +  DatetoStr(fecha1) + ' al ' + DatetoStr(fecha2);
    CostoTotal := 0;
 end;

 //muestra el cliente seleccionado
  procedure TFactura.imprimirCliente(cliente: String);
 begin
    QRLabel1.Caption := 'HISTORIAL DE CLIENTE';
    QRLabel16.Caption := 'Del cliente: '+ cliente;
    CostoTotal := 0;
 end;

end.
