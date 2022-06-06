unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, System.DateUtils,
  Vcl.ExtCtrls, Vcl.WinXPickers, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TAltaTemporada = class(TForm)
    DatePicker1: TDatePicker;
    DatePicker2: TDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AltaTemporada: TAltaTemporada;

implementation

{$R *.dfm}
uses
  Unit3;




//botón para confirmar la creación de temporada

procedure TAltaTemporada.Button1Click(Sender: TObject);
var
fechainicio: TDate;
fechafin: TDate;
nombre: string;
precio: double;

iteradorfecha: TDate;
stringFecha: String;

registroValido: boolean;

begin
  registroValido := true;

  fechainicio:= Datepicker1.Date;
  fechafin:= Datepicker2.Date;
  if RadioGroup1.ItemIndex = 0 then nombre := 'media';
  if RadioGroup1.ItemIndex = 1 then nombre := 'alta';
  precio := StrToFloat(SpinEdit1.Text);

    //validaciones pertinentes

  if fechainicio > fechafin then
    begin
       showmessage('La fecha de inicio no puede ser mayor a la fecha de fin');
       registroValido := false;
    end;
     //comprobamos que el periodo indicado no se solapa con otro ya existente.

     //debemos ir dia por dia comprobando si alguno coincide dentro de alguna temporada.

    iteradorfecha:= fechainicio;
  if registroValido then
  begin


    while iteradorfecha <= fechafin do
      begin

        stringFecha := Tablas.formatearFechaSQL(iteradorfecha);

        Tablas.FDQuery1.Close;
        Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedStr(stringFecha)+' and fechafin>='+quotedStr(stringFecha);
        Tablas.FDQuery1.Open;

        if Tablas.FDQuery1.RecordCount > 0 then registroValido:= false;


        iteradorfecha := IncDay(iteradorfecha, 1);
      end;

  end;

  //si la temporada es válida

  if registroValido then
    begin
      showmessage('Se ha creado la temporada.');
      Tablas.FDTableTemporadas.Append;
      Tablas.FDTableTemporadasfechainicio.Value := fechainicio;
      Tablas.FDTableTemporadasfechafin.Value := fechafin;
      Tablas.FDTableTemporadasnombretemporada.Value := nombre;
      Tablas.FDTableTemporadasprecioadicional.Value := precio;
      Tablas.FDTableTemporadas.Post;

      AltaTemporada.Close;
    end else
    begin
      showmessage('El periodo introducido se cruza con una temporada existente.');
    end;

end;





procedure TAltaTemporada.Button2Click(Sender: TObject);
begin
  AltaTemporada.Close;
end;

procedure TAltaTemporada.FormActivate(Sender: TObject);
begin
  Datepicker1.Date := Now();
  Datepicker2.Date := Now();
end;

procedure TAltaTemporada.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then  AltaTemporada.Close;
end;

end.
