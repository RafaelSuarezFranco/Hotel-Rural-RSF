unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuickRpt, QRCtrls, Vcl.ExtCtrls, System.DateUtils,
  qrpctrls;

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
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Factura: TFactura;

implementation

{$R *.dfm}
  uses
    Unit3;

procedure TFactura.FormActivate(Sender: TObject);
begin
  Tablas.FDQuery2.Open;
  Tablas.FDQuery3.Open;
end;

procedure TFactura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Tablas.FDQuery2.close;
   Tablas.FDQuery3.close;
end;

procedure TFactura.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var
  fecha: TDate;
  habitacion: integer;
  diabusqueda: String;
  mesbusqueda: String;
  fechabusqueda: String;
begin
  fecha := Tablas.FDQuery2.FieldByName('fechaentrada').Value;
  habitacion := Tablas.FDQuery2.FieldByName('numero').Value;



  diabusqueda := IntToStr(DayOfTheMonth(fecha));
  mesbusqueda := IntToStr(MonthOfTheYear(fecha));
  if length(diabusqueda) < 2 then
    diabusqueda:= '0'+ diabusqueda;
    if length(mesbusqueda) < 2 then
    mesbusqueda:= '0'+ mesbusqueda;
  fechabusqueda:= IntToStr(YearOf(fecha))+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

  Tablas.FDQuery3.close;
  Tablas.FDQuery3.SQL.Text := 'SELECT numerohabitacion AS numerohservicio, fecha AS fechaservicio, e.nombreservicio, precioservicio FROM entradasservicios e, servicios s WHERE e.nombreservicio = s.nombreservicio';
  Tablas.FDQuery3.SQL.Text := Tablas.FDQuery3.SQL.Text + ' and numerohabitacion = '+inttostr(habitacion)+' and fecha = '+quotedstr(fechabusqueda);
  //showmessage(Tablas.FDQuery3.SQL.Text);

  //Tablas.FDQuery3.SQL.Text := 'SELECT numerohabitacion AS numerohservicio, fecha AS fechaservicio, e.nombreservicio, precioservicio FROM entradasservicios e, servicios s WHERE e.nombreservicio = s.nombreservicio  AND numerohabitacion = 3 and fecha = "2022-03-01"';



  Tablas.FDQuery3.open;

end;

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

end.
