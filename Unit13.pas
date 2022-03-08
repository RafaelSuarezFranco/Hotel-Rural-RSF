unit Unit13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QRCtrls, QuickRpt, qrpctrls,
  Vcl.ExtCtrls;

type
  TItinerarioServicios = class(TForm)
    quickreport1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRBand3: TQRBand;
    QRSubDetail1: TQRSubDetail;
    QRShape2: TQRShape;
    QRLabel7: TQRLabel;
    QRGroup2: TQRGroup;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRBand5: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel8: TQRLabel;
    QRLabel11: TQRLabel;
    QRSysData2: TQRSysData;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel3: TQRLabel;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
      procedure imprimirFechas(fecha1: TDate);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    fecha : TDate;
  end;

var
  ItinerarioServicios: TItinerarioServicios;

implementation

{$R *.dfm}
uses
  Unit3;



  //nota: este informe de itinerario se genera para la fecha seleccionada en la pantalla principal.
  //si queremos generar este informe para un día concreto, debemos navegar a ese día primero.

  //de la misma manera que con el informe de factura, recorremos la tabla servicios y con el nombre que
  //rescatamos hacemos búsquedas en entradasservicios para la fecha concreta.

procedure TItinerarioServicios.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  nombre : string;
  fechabusqueda : string;
begin

  nombre := Tablas.FDQuery4.FieldByName('nombre').Value;
  fechabusqueda := Tablas.formatearFechaSQL(fecha);

  Tablas.FDQuery5.close;
  Tablas.FDQuery5.SQL.Text := 'SELECT numerohabitacion AS numero from entradasservicios where nombreservicio = '
   + quotedstr(nombre) +  ' and fecha = ' + quotedstr(fechabusqueda) + ' order by numerohabitacion';
  Tablas.FDQuery5.open;

  QRLabel17.Caption := fechabusqueda;
end;



// Si algún servicio no se lleva a cabo en ninguna habitación cierto día, lo mostramos de la siguiente manera

 procedure TItinerarioServicios.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin

if Tablas.FDQuery5.RecordCount = 0 then
   begin
     QRLabel7.Caption := 'Sin habitaciones para este día.';
     QRShape2.width := 0;
   end else
   begin
     QRLabel7.Caption := 'Habitación ';
     QRShape2.width := 211;
   end;

end;


//mostramos la fecha del itinerario

procedure TItinerarioServicios.imprimirFechas(fecha1: TDate);
 begin
    QRLabel17.Caption := DatetoStr(fecha1);
 end;


end.
