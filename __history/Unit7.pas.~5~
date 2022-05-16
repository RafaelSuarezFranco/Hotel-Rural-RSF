unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Mask, Vcl.DBCtrls;

type
  TNuevaHabitacion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NuevaHabitacion: TNuevaHabitacion;

implementation

{$R *.dfm}
  uses
   Unit1, Unit3;



//botón para confirmar la creación de la habitación.

procedure TNuevaHabitacion.Button1Click(Sender: TObject);
var
nhabitacion: integer;
precio: double;
registroValido: boolean;
begin
  registroValido:=true;

  nhabitacion:= strtoint(SpinEdit1.Text);
  try

   //validaciones pertinentes

    precio:= strtofloat(Edit1.Text);
    if precio < 0 then
      begin
        showmessage('El precio no puede ser negativo.');
        registroValido := false;
      end;
    if edit2.Text = '' then
      begin
        registroValido := false;
        showmessage('Por favor, introduce un tipo de habitación.')
      end;
    if nhabitacion < 1 then
      begin
         registroValido := false;
         showmessage('El nº de habitación no debería ser negativo o cero.');
      end;
  except
    registroValido:=false;
    showmessage('El precio debe ser un dato numérico.');
  end;

  if Tablas.FDTableHabitaciones.Locate('numero', nhabitacion, []) then
    begin
       registroValido:=false;
        showmessage('El nº de habitación ya existe, por favor, escoge otro.');
    end;


  //una vez hemos comprobado que todo está correcto, creamos el registro
  if registroValido then
    begin
      Tablas.FDTableHabitaciones.Append;
      Tablas.FDTableHabitacionesnumero.value := nhabitacion;
      Tablas.FDTableHabitacionestipo.Value := Edit2.Text;
      Tablas.FDTableHabitacionespreciobase.Value := precio;
      Tablas.FDTableHabitaciones.Post;
      NuevaHabitacion.Close;
      //refrescamos la pantalla principal para que se vea la nueva habitación
      Principal.CrearPanelesHabitaciones;
      Principal.CargarDia;
    end;

end;

procedure TNuevaHabitacion.Button2Click(Sender: TObject);
begin
     NuevaHabitacion.Close;
end;


procedure TNuevaHabitacion.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_ESCAPE then  NuevaHabitacion.Close;
end;

end.
