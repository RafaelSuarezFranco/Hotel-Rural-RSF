unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers,
  Vcl.ExtCtrls;

type
  TFormularioPeriodo = class(TForm)
    DatePicker1: TDatePicker;
    DatePicker2: TDatePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Panel1: TPanel;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormularioPeriodo: TFormularioPeriodo;
  Habitacionescombo : Array of Integer; //contiene los nº de habitaciones

  Estado: String;
  Fechafin: TDate;
  Fechaicion: TDate;
  Habitacion: Integer;
  Cliente: String;
  {
  Preciofinal: Double;
  fechabusqueda: String;
  PrecioBase: Double;
  TemporadaPrecio: Double;
  PrecioCalculado: Double;
   }
  CheckboxServicios: Array of TCheckbox;
  NombresServicios: Array of String;
  ServiciosContratados: Array of Boolean;
  PreciosServicios: Array of Double;

implementation

{$R *.dfm}
 uses Unit1, Unit3;


procedure TFormularioPeriodo.FormActivate(Sender: TObject);
var
i: integer;
cantidadHabitaciones: integer;
servicioCheck: TCheckbox;
begin

//COMBO HABITACIONES

  ComboBox1.Style := csDropDownList;
   i:=0;
    cantidadHabitaciones:= Tablas.FDTableHabitaciones.RecordCount;
    SetLength(Habitacionescombo, cantidadHabitaciones);

    Tablas.FDTableHabitaciones.First;
      while not  Tablas.FDTableHabitaciones.Eof do
        begin
          Habitacionescombo[i]:= Tablas.FDTableHabitacionesnumero.Value;
          Combobox1.Items.Add(IntToStr(Tablas.FDTableHabitacionesnumero.Value));
          i:=i+1;
          Tablas.FDTableHabitaciones.Next;
        end;

   Combobox1.ItemIndex := 0;



    //SERVICIOS

      SetLength(CheckboxServicios, Tablas.FDTableServicios.RecordCount);
      SetLength(nombresServicios, Tablas.FDTableServicios.RecordCount);
      SetLength(serviciosContratados, Tablas.FDTableServicios.RecordCount);
      SetLength(PreciosServicios, Tablas.FDTableServicios.RecordCount);
    //crear checkboxs de servicios.
    i:=0;
    Tablas.FDTableServicios.First;
    while not Tablas.FDTableServicios.Eof do
       begin
        nombresServicios[i] := Tablas.FDTableServiciosnombreservicio.Value;

        servicioCheck:=TCheckbox.create(self);
        servicioCheck.Parent:=Panel1;

        servicioCheck.Tag:=i;
        servicioCheck.Top:=i*20+5;
        servicioCheck.Left:=5;
        servicioCheck.Caption:=nombresServicios[i] + ' ('+FloatToStr(Tablas.FDTableServiciosprecioservicio.Value)+'€ al día)';
        servicioCheck.Width:= 120;
        PreciosServicios[i] := Tablas.FDTableServiciosprecioservicio.Value;
        CheckboxServicios[i]:= servicioCheck;

        //CheckboxServicios[i].OnClick := RecalcularPrecio;

        Tablas.FDTableServicios.Next;
        i:=i+1;
       end;




end;

end.
