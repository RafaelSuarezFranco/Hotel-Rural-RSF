unit Unit12;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers, System.DateUtils,
  Vcl.ExtCtrls;

type
  TFacturaParametros = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    DatePicker1: TDatePicker;
    DatePicker2: TDatePicker;
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FacturaParametros: TFacturaParametros;

implementation

{$R *.dfm}
uses
  Unit3, Unit11;


  //valida los parámetros utilizamos y construye la consulta principal de la factura

procedure TFacturaParametros.Button1Click(Sender: TObject);
var
camposValidos: boolean;
fechabusqueda1: String;
fechabusqueda2: String;
estadoseleccionado: String;
begin
 camposValidos := true;

 if DatePicker1.Date > DatePicker2.Date then
    begin
      showmessage('La fecha de inicio no puede ser mayor a la fecha de fin');
       camposValidos := false;
    end;

  //abrir informe de factura

    if camposValidos then
      begin
      //construimos la consulta principal desde aquí, dado que no podemos usar el activate del informe para
      //ese propósito o para inicializar las variables que vienen a continuación.

        Factura.CostoTotal:=0;
        Factura.CantidadDias:=0;

        if RadioGroup1.ItemIndex = 0 then estadoseleccionado:= 'reservada';
        if RadioGroup1.ItemIndex = 1 then estadoseleccionado:= 'ocupada';

        fechabusqueda1:= Tablas.formatearFechaSQL(DatePicker1.Date);
        fechabusqueda2:= Tablas.formatearFechaSQL(DatePicker2.Date);

        Factura.imprimirFechas(DatePicker1.Date, DatePicker2.Date);

          Tablas.FDQuery2.close;
          Tablas.FDQuery2.SQL.Text := 'select numerohabitacion as numero, fecha as fechaentrada, estado, cliente, preciofinal from entradas where fecha >= '
          +quotedStr(fechabusqueda1)+' and fecha <= ' + quotedStr(fechabusqueda2) + ' and numerohabitacion = :numeroh and estado = :estado order by fecha';
          Tablas.FDQuery2.ParamByName('numeroh').AsInteger := StrToInt(Combobox1.Items[Combobox1.ItemIndex]);
          Tablas.FDQuery2.ParamByName('estado').AsString := estadoseleccionado;
          Tablas.FDQuery2.open;

          if Tablas.FDQuery2.RecordCount <> 0 then
            begin
              FacturaParametros.Close;
              Factura.quickreport1.preview;
            end else
            begin
              showmessage('No se han encontrado registros para los parámetros especificados');
            end;


      end;

end;

procedure TFacturaParametros.Button2Click(Sender: TObject);
begin
  FacturaParametros.Close;
end;


//como siempre, rellenamos el combobox con las habitaciones existentes y ponemos valores por defecto.

procedure TFacturaParametros.FormActivate(Sender: TObject);
var
i: integer;
cantidadHabitaciones: integer;
begin
   Combobox1 := Tablas.rellenarComboHabitaciones(Combobox1);

   DatePicker1.Date := Now();
   DatePicker2.Date := Now();
end;

end.
