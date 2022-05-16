unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TAltaServicio = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    modo: string;
    servicioEdit: string;
    precioEdit: string;
  end;

var
  AltaServicio: TAltaServicio;

implementation

{$R *.dfm}
  uses
    Unit3;



 //botón para realizar un insert o edit

procedure TAltaServicio.Button1Click(Sender: TObject);
var
n: double;
existe: integer;
begin
  existe := 0;


  if (Edit1.Text = '') or (Edit2.Text = '') then
  begin
     showmessage('Por favor, introduce los dos campos.');
  end else
  begin

    try
      n := strtofloat(Edit2.Text);

    if modo = 'crear' then
     begin

          Tablas.FDTableServicios.Filtered := true;
          Tablas.FDTableServicios.Filter:= 'nombreservicio='+quotedstr(Edit1.Text);
          existe  := Tablas.FDTableServicios.RecordCount;
          Tablas.FDTableServicios.Filtered := false;

     if existe > 0 then
        begin
          showmessage('Ya existe un servicio con ese nombre, por favor, escoge otro.');
        end;

      if existe = 0 then
        begin
            Tablas.FDTableServicios.Append;
            Tablas.FDTableServiciosnombreservicio.Value := Edit1.Text;
            Tablas.FDTableServiciosprecioservicio.Value := StrToFloat(Edit2.Text);
            Tablas.FDTableServicios.Post;
            AltaServicio.Close;
        end;

     end;
    if modo = 'editar' then
      begin
         Tablas.FDTableServicios.Locate('nombreservicio', servicioEdit, []);
         Tablas.FDTableServicios.Edit;
         Tablas.FDTableServiciosprecioservicio.Value := StrToFloat(Edit2.Text);
         Tablas.FDTableServicios.Post;
         AltaServicio.Close;
      end;

    except
       showmessage('Introduce un número en el precio, por favor.')
    end;
  end;


end;






procedure TAltaServicio.Button2Click(Sender: TObject);
begin
  Tablas.FDTableServicios.Cancel;
  AltaServicio.Close;
end;

procedure TAltaServicio.FormActivate(Sender: TObject);
begin
    if modo = 'editar' then
      begin
          Edit1.Text := servicioEdit;
          Edit2.Text := precioEdit;
          Edit1.ReadOnly := true;
      end;

    if modo = 'crear' then
      begin

          Edit1.Text := '';
          Edit2.Text := '';
          Edit1.ReadOnly := false;
      end;


end;

procedure TAltaServicio.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
    begin
      Tablas.FDTableServicios.Cancel;
      AltaServicio.Close;
    end;
end;

end.
