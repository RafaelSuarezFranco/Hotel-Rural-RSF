unit Unit19;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,   System.Math,
  Vcl.StdCtrls, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdComponent, IdIOHandler,     IdEMailAddress, IdGlobal, IdAttachmentFile,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdMessage;

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
    Label5: TLabel;
    Label6: TLabel;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP1: TIdSMTP;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
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
    Unit1, Unit3, Unit18;

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


 //label registrarse
procedure TLogin.Label5Click(Sender: TObject);
begin
  AltaUsuario.permisos := 'cliente';
  AltaUsuario.showmodal;
end;

//recuperar contraseña
 procedure TLogin.Label6Click(Sender: TObject);
 var
 codigoVerificacion: string;
 codigoInput: string;
 correo: string;
 pswd1: string;
 pswd2: string;
 usuario : string;
begin


 IdMessage1.Clear;

// IO HANDLER SETTINGS //
  With IdSSLIOHandlerSocketOpenSSL1 do
  begin

    Destination := 'smtp.gmail.com:587';
    Host := 'smtp.gmail.com';
    MaxLineAction := maException;
    Port := 587;
    SSLOptions.Method := sslvTLSv1;
    SSLOptions.Mode := sslmUnassigned;
    SSLOptions.VerifyMode := [];
    SSLOptions.VerifyDepth := 0;
  end;
//SETTING SMTP COMPONENT DATA //
  IdSMTP1.Host := 'smtp.gmail.com';
  IdSMTP1.Port := 587;
  IdSMTP1.Username := 'hotelrafaelsuarezfranco@gmail.com'; // please change to your gmail address //
  IdSMTP1.Password := 'hotelrsf127';
  IdSMTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  //IdSMTP1.AuthType := satDefault;
  IdSMTP1.UseTLS := utUseExplicitTLS;



  codigoVerificacion := inttostr(RandomRange(100000, 999999));
  correo := inputbox('Introduzca su correo', 'Correo de la cuenta que desea recuperar:', '');
  if Tablas.FDTableUsuarios.Locate('correo', correo, []) then
    begin

      usuario := Tablas.FDTableUsuariosusuario.Value;

      IdMessage1.From.Address :=  'hotelrafaelsuarezfranco@gmail.com';
      IdMessage1.Recipients.EMailAddresses := correo;
      IdMessage1.Subject := 'Recuperar cuenta de Hotel RSF';
      IdMessage1.Body.Text := 'Buenos días, '+usuario+'. Su código de recuperación es: '+codigoVerificacion;

       TRY
          IdSMTP1.Connect();
          IdSMTP1.Send(IdMessage1);
          IdSMTP1.Disconnect();
       except on e:Exception do
          begin
            ShowMessage(e.Message);
            IdSMTP1.Disconnect();
          end;
       END;

      while codigoInput <> codigoVerificacion do
        begin
          codigoInput := inputbox('Introduzca el código de verificación', 'Hemos mandado un código a su correo.', '');
        end;

      if codigoinput = codigoVerificacion then
        begin
          while pswd1 = '' do
            begin
              pswd1 := inputbox('Nueva contraseña', #31'Introduzca la nueva contraseña.', '');
            end;
          while pswd1 <> pswd2 do
            begin
              pswd2 := inputbox('Repita contraseña', #31'Repita la nueva contraseña.', '');
            end;

          if pswd1 = pswd2 then
            begin

              Tablas.FDTableUsuarios.Locate('correo', correo, []);
              Tablas.FDTableUsuarios.Edit;
              Tablas.FDTableUsuariospassword.Value := Tablas.passwordHash(pswd1);
              Tablas.FDTableUsuarios.Post;
              showmessage('Contraseña cambiada con éxito');
            end;

        end;


    end else
    begin
      showmessage('No existe una cuenta con el correo introducido.');
    end;


end;





//efecto de hover
procedure TLogin.Label5MouseEnter(Sender: TObject);
begin
  TLabel(sender).StyleElements :=[seClient,seBorder];
end;

procedure TLogin.Label5MouseLeave(Sender: TObject);
begin
  TLabel(sender).StyleElements :=[seFont,seClient,seBorder];
end;




procedure TLogin.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
seleccion : integer;
begin
  if Key = VK_ESCAPE then Principal.Close;
end;


end.
