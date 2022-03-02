unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TAltaCliente = class(TForm)
    Label1: TLabel;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure ImportarIdentificador(id: String);
    function AltaEnCaliente(identificador: String): boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AltaCliente: TAltaCliente;

implementation

{$R *.dfm}
uses
  Unit3;



//botón único para dar de alta.

procedure TAltaCliente.Button1Click(Sender: TObject);
begin
  if (Edit1.Text <> '') and (DBEdit2.Text <> '') and (DBEdit3.Text <> '') then
    begin
      Tablas.FDTableClientesidentificador.Value := Edit1.Text;
      //como estamos usando un edit normal (para hacerlo readonly) debemos introducir el dato a mano.
      Tablas.FDTableClientes.Post;
      showmessage('Nuevo cliente dado de alta.');
      AltaCliente.Close;
    end else
    begin
      showmessage('Por favor, rellena todos los campos');
    end;


end;


// para mostrar el id que hemos introducido desde el formulario

procedure TAltaCliente.ImportarIdentificador(id: String);
begin
    Edit1.Text := id;
end;



//se llama desde los formularios, se encarga de consultar si el id de cliente introducido al hacer una
//reserva existe, y si no, da la opción de crear uno nuevo (lo cual da paso a abrir este formulario)

function TAltaCliente.AltaEnCaliente(identificador: String): boolean;
var
seleccion: integer;
begin
  if not Tablas.FDTableClientes.Locate('identificador', identificador, []) then
    begin
    seleccion := messagedlg('No existe un cliente con el identificador especificado. ¿Desea crear un nuevo cliente?',mtConfirmation , mbOKCancel, 0);
    if seleccion = mrCancel then
       begin
         AltaEnCaliente := false;
      end;

    if seleccion = mrOK then
      begin
        Tablas.FDTableClientes.Append;
        AltaCliente.ShowModal;
        AltaEnCaliente := true;
      end;

    end
    else
    begin
       AltaEnCaliente := true;
    end;

end;


end.
