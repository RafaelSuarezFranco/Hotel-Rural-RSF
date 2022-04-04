unit Unit18;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Mask;

type
  TAltaUsuario = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    Label4: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AltaUsuario: TAltaUsuario;

implementation

{$R *.dfm}

uses
  Unit3, Unit6;

procedure TAltaUsuario.Button1Click(Sender: TObject);
var
clienteValido: boolean;
clienteTieneUsuario: boolean; //no queremos que un cliente tenga varios usuarios.
registroValido: boolean;
correoValido: boolean;
begin
  registroValido := true;
  clienteValido := false;
  clienteTieneUsuario := false;

  Tablas.FDQuery1.Close;
  Tablas.FDQuery1.SQL.Text := 'select * from usuarios where cliente='+quotedstr(DBEdit3.Text);
  Tablas.FDQuery1.Open;

   if Tablas.FDQuery1.RecordCount > 0 then
    begin
      showmessage('El cliente especificado ya tiene un usuario en el sistema.');
      clienteTieneUsuario := true;
      registroValido := false;
    end;


  if (DBEdit1.Text = '') or (DBEdit2.Text = '') or (DBEdit3.Text = '') or
    (DBEdit5.Text = '') then
  begin
    showmessage('Por favor, rellena todos los campos');
    registroValido := false;
  end
  else
  begin

    if RadioGroup1.ItemIndex = 0 then Tablas.FDTableUsuariosperfil.Value := 'cliente';
    if RadioGroup1.ItemIndex = 1 then Tablas.FDTableUsuariosperfil.Value := 'admin';

    AltaCliente.ImportarIdentificador(DBEdit3.Text); //preventivamente, mandamos el identificador al formulario.
    clienteValido := AltaCliente.AltaEnCaliente(DBEdit3.Text); //abre el alta de cliente si no existe.

  if(clienteTieneUsuario = false) then
    begin
     //si sabemos que no tiene usuario y que hemos introducido un cliente válido (ya sea creado o no) entonces seguimos.

    if (clienteValido = true) then
      begin

      //validar formato de correo.
        correoValido := Tablas.emailFormatoValido(DBEdit2.Text);
         if not correoValido then
          begin
            showmessage('El formato del correo no es válido.');
            registroValido := false;
          end;

      //validar si el correo o el usuario están repetidos.

        Tablas.FDQuery1.Close;
        Tablas.FDQuery1.SQL.Text := 'select * from usuarios where correo='+quotedstr(DBEdit2.Text);
        Tablas.FDQuery1.Open;

         if Tablas.FDQuery1.RecordCount > 0 then
          begin
            showmessage('Ya existe un usuario con el correo introducido.');
            registroValido := false;
          end;


        Tablas.FDQuery1.Close;
        Tablas.FDQuery1.SQL.Text := 'select * from usuarios where usuario='+quotedstr(DBEdit1.Text);
        Tablas.FDQuery1.Open;

         if Tablas.FDQuery1.RecordCount > 0 then
          begin
            showmessage('Ya existe un usuario con el nombre de usuario introducido.');
            registroValido := false;
          end;

      //comprobar que las contraseñas coinciden.
      if DBEdit5.Text <> Edit1.Text then
        begin
          showmessage('Las contraseñas no coinciden.');
          registroValido := false;
        end;

      end else
      begin
          //si no aceptamos crear un nuevo usuario (necesario).
         showmessage('Acción cancelada. No se puede completar la reserva con el identificador de un cliente inexistente');
         registroValido := false;
      end;

    end else
    begin
       registroValido := false;
    end;


  end;

  if registroValido then
    begin
      // convertimos la passwd en hash md5
      Tablas.FDTableUsuarioscontraseña.value:= Tablas.passwordHash(Edit1.Text);

      Tablas.FDTableUsuarios.Post;
      showmessage('Usuario creado con éxito.');
      AltaUsuario.Close;
    end;

end;

procedure TAltaUsuario.Button2Click(Sender: TObject);
begin
  Tablas.FDTableUsuarios.cancel;
  AltaUsuario.Close;
end;

procedure TAltaUsuario.FormActivate(Sender: TObject);
begin
  Tablas.FDTableUsuarios.append;
  Edit1.Text := '';
end;

end.
