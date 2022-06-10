unit Unit18;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,   IdEMailAddress, IdGlobal, IdAttachmentFile,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,   System.Math,
  Data.DB, Vcl.Mask, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP;

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
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;   // to allow SSL authenticate //
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    permisos: string;
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

codigoVerificacion : string;
codigoInput: string;

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
  IdSMTP1.Password :=  Tablas.DesencriptarString(Tablas.passwordcorreo, 127);//'hotelrsf127'  'zytizzgexjyeqzcx'; //
  IdSMTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  //IdSMTP1.AuthType := satDefault;
  IdSMTP1.UseTLS := utUseExplicitTLS;
// SETTING email MESSAGE DATA //


  //Attachmentfile := TIdAttachmentFile.Create(IdMessage1.MessageParts,'C:\File1.txt');
  {
  IdMessage1.From.Address :=  'hotelrafaelsuarezfranco@gmail.com'; // please change to your gmail address //;
  IdMessage1.Recipients.EMailAddresses := 'rafasuarezfranco127@gmail.com';
  IdMessage1.Subject := 'Test Email Subject';
  IdMessage1.Body.Text := 'Test Email Body';
  }
  //IdMessage1.Priority := mpHigh;
  {
  TRY
    IdSMTP1.Connect();
    IdSMTP1.Send(IdMessage1);
    ShowMessage('Email sent');
    IdSMTP1.Disconnect();
  except on e:Exception do
    begin
      ShowMessage(e.Message);
      IdSMTP1.Disconnect();
    end;
  END;
  }
//  AttachmentFile.Free;






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
      if permisos = 'cliente' then
        begin
          codigoVerificacion := inttostr(RandomRange(100000, 999999));

          IdMessage1.From.Address :=  'hotelrafaelsuarezfranco@gmail.com';
          IdMessage1.Recipients.EMailAddresses := DBEdit2.Text;
          IdMessage1.Subject := 'Confirmar cuenta de Hotel RSF';
          IdMessage1.Body.Text := 'Bienvenido al Hotel RSF, '+DBEdit1.Text+'. Su código de verificación es: '+codigoVerificacion;


          TRY
            IdSMTP1.Connect();
            IdSMTP1.Send(IdMessage1);
            //ShowMessage('Email sent');

            while codigoInput <> codigoVerificacion do
              begin
                codigoInput := inputbox('Introduzca el código de verificación', 'Hemos mandado un código a su correo.', '');
              end;

            if codigoInput = codigoVerificacion then
              begin
                Tablas.FDTableUsuariospassword.value:= Tablas.passwordHash(Edit1.Text);

                Tablas.FDTableUsuarios.Post;
                showmessage('Usuario creado con éxito.');
                AltaUsuario.Close;

              end;


            IdSMTP1.Disconnect();
          except on e:Exception do
            begin
               //ShowMessage(e.Message);
              Showmessage('No se ha podido enviar el correo.');
              IdSMTP1.Disconnect();
            end;
          END;

           //codigoVerificacion := inttostr(RandomRange(100000, 999999));
           //codigoInput := inputbox('Introduzca el código de verificación', 'Hemos mandado un código a su correo.', codigoVerificacion);
           //showmessage(codigoVerificacion);
        end;

          // convertimos la passwd en hash md5
          {
          Tablas.FDTableUsuariospassword.value:= Tablas.passwordHash(Edit1.Text);

          Tablas.FDTableUsuarios.Post;
          showmessage('Usuario creado con éxito.');
          AltaUsuario.Close;
          }
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

  if permisos = 'cliente' then
    begin
      RadioGroup1.Enabled := false;
    end;

  if permisos = 'admin' then
    begin
      RadioGroup1.Enabled := true;
    end;
end;

end.
