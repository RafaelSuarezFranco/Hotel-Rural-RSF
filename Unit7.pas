unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Mask, Vcl.DBCtrls;

type
  TAltaHabitacion = class(TForm)
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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    modo: string;
    habitacionEdit: string;
  end;

var
  AltaHabitacion: TAltaHabitacion;

implementation

{$R *.dfm}
  uses
   Unit1, Unit3;



//botón para confirmar la creación de la habitación.

procedure TAltaHabitacion.Button1Click(Sender: TObject);
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

  if Tablas.FDTableHabitaciones.Locate('numero', nhabitacion, []) and (modo = 'crear') then
    begin
       registroValido:=false;
        showmessage('El nº de habitación ya existe, por favor, escoge otro.');
    end;


  //una vez hemos comprobado que todo está correcto, creamos el registro
  if (registroValido = true) and (modo = 'crear') then
    begin
      Tablas.FDTableHabitaciones.Append;
      Tablas.FDTableHabitacionesnumero.value := nhabitacion;
      Tablas.FDTableHabitacionestipo.Value := Edit2.Text;
      Tablas.FDTableHabitacionespreciobase.Value := precio;
      Tablas.FDTableHabitaciones.Post;
      AltaHabitacion.Close;
      //refrescamos la pantalla principal para que se vea la nueva habitación
      Principal.CrearPanelesHabitaciones;
      Principal.CargarDia;
    end;

    //si estamos editando
    if (registroValido = true) and (modo = 'editar') then
      begin
        Tablas.FDTableHabitaciones.Locate('numero', habitacionEdit, []);
        Tablas.FDTableHabitaciones.Edit;
        Tablas.FDTableHabitacionespreciobase.Value := StrToInt(Edit1.Text);
        Tablas.FDTableHabitacionestipo.Value := Edit2.Text;
        Tablas.FDTableHabitaciones.Post;
        AltaHabitacion.Close;
        Principal.CrearPanelesHabitaciones;
        Principal.CargarDia;
      end;


end;

procedure TAltaHabitacion.Button2Click(Sender: TObject);
begin
     AltaHabitacion.Close;
end;


procedure TAltaHabitacion.FormActivate(Sender: TObject);
begin
    if modo = 'editar' then
      begin
         Button1.Caption := 'Editar';
         SpinEdit1.Value := StrToInt(habitacionEdit);
         SpinEdit1.ReadOnly := True;

          Tablas.FDQuery1.Close;
          Tablas.FDQuery1.SQL.Text := 'select * from habitaciones where numero='+habitacionEdit;
          Tablas.FDQuery1.Open;

          Edit1.Text := Tablas.FDQuery1.FieldByName('preciobase').Value;
          Edit2.Text := Tablas.FDQuery1.FieldByName('tipo').Value;
      end else
      begin
         Button1.Caption := 'Crear';
         SpinEdit1.Value := 0;
         SpinEdit1.ReadOnly := False;
         Edit1.Text := '';
         Edit2.Text := '';
      end;
end;

procedure TAltaHabitacion.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_ESCAPE then  AltaHabitacion.Close;
end;

end.
