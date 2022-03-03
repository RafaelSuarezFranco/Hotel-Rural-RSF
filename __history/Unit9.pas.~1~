unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TAltaServicio = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AltaServicio: TAltaServicio;

implementation

{$R *.dfm}
  uses
    Unit3;

procedure TAltaServicio.Button1Click(Sender: TObject);
begin
  if (DBEdit1.Text = '') or (DBEdit2.Text = '') then
  begin
     showmessage('Por favor, introduce los dos campos.');
  end else
  begin
     Tablas.FDTableServicios.Post;
   AltaServicio.Close;
  end;


end;

procedure TAltaServicio.Button2Click(Sender: TObject);
begin
  Tablas.FDTableServicios.Cancel;
  AltaServicio.Close;
end;

procedure TAltaServicio.FormActivate(Sender: TObject);
begin
   Tablas.FDTableServicios.Append;
end;

end.
