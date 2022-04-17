unit Unit19;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TLogin = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Image1: TImage;
    Label4: TLabel;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}
  uses
    Unit1, Unit3;

procedure TLogin.Button1Click(Sender: TObject);
var
conNombreUsuario:boolean;
conCorreo:boolean;
usuarioValido:boolean;
password:string;

  //nota: el botón tiene default = true para que al pulsar enter, se ejecute lo mismo del botón.

begin
//comprobar si el usuario existe, ya sea por correo o nombre usuario.
conNombreUsuario := false;
conCorreo:= false;
usuarioValido:= false;
password := Tablas.passwordHash(Edit2.Text);


  Tablas.FDTableUsuarios.Filtered := true;
  Tablas.FDTableUsuarios.Filter := 'usuario='+quotedstr(Edit1.Text);
  if Tablas.FDTableUsuarios.RecordCount > 0 then
    begin
      conNombreUsuario := true;

      Tablas.FDTableUsuarios.First;
      while not Tablas.FDTableUsuarios.Eof do
        begin
          if Tablas.FDTableUsuariospassword.Value = password then
            begin
              usuarioValido := true;
              Tablas.perfil := Tablas.FDTableUsuariosperfil.Value;
              Tablas.cliente := Tablas.FDTableUsuarioscliente.Value;
              Tablas.usuario := Tablas.FDTableUsuarioscliente.Value;
            end;

          Tablas.FDTableUsuarios.next;
        end;
    end;

  Tablas.FDTableUsuarios.Filtered := false;

 Tablas.FDTableUsuarios.Filtered := true;
  Tablas.FDTableUsuarios.Filter := 'correo='+quotedstr(Edit1.Text);
  if Tablas.FDTableUsuarios.RecordCount > 0 then
    begin
      conCorreo := true;
      Tablas.FDTableUsuarios.First;
      while not Tablas.FDTableUsuarios.Eof do
        begin
          if Tablas.FDTableUsuariospassword.Value = password then
            begin
              usuarioValido := true;
              Tablas.perfil := Tablas.FDTableUsuariosperfil.Value;
              Tablas.cliente := Tablas.FDTableUsuarioscliente.Value;
              Tablas.usuario := Tablas.FDTableUsuarioscliente.Value;
            end;
          Tablas.FDTableUsuarios.next;
        end;
    end;

  Tablas.FDTableUsuarios.Filtered := false;


  if (conNombreUsuario = false) and (conCorreo = false) then
    begin
      showmessage('El correo u nombre de usuario introducido no está registrado.');
    end else
    begin
      Tablas.usuario := Edit1.Text;

      if not usuarioValido then showmessage('Contraseña incorrecta.');
    end;


   if usuarioValido then
    begin
      //showmessage('Acceso concedido.');
      Login.Close;
    end;

end;

procedure TLogin.Button2Click(Sender: TObject);
begin
  Principal.Close;
end;

procedure TLogin.FormActivate(Sender: TObject);
begin

 //apertura de tablas
    Tablas.FDTableHabitaciones.Open;
    Tablas.FDTableEntradas.Open;
    Tablas.FDQuery1.Open;
    Tablas.FDTableTemporadas.Open;
    Tablas.FDTableServicios.Open;
    Tablas.FDTableEntradasservicios.Open;
    Tablas.FDTableClientes.Open;
    Tablas.FDTableHistoricoentradas.Open;
    Tablas.FDTableUsuarios.Open;

    Tablas.FDQuery2.Open;
    Tablas.FDQuery3.Open;
    Tablas.FDQuery4.Open;
    Tablas.FDQuery5.Open;
    Tablas.FDQuery6.Open;
    Tablas.FDQuery7.Open;
    Tablas.FDQuery8.Open;
end;

end.
