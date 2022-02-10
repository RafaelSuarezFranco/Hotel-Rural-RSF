unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers,  System.DateUtils,
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
    procedure Button1Click(Sender: TObject);
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


procedure TFormularioPeriodo.Button1Click(Sender: TObject);
var
camposValidos: boolean;
registroValido: boolean;
fechaentrada: TDate;
PrecioBase: Double;
PrecioTemporada: Double;
PrecioFinal: Double;
fechabusqueda: String;


diabusqueda: String;
mesbusqueda: String;

dia: integer;
mes: integer;
año: integer;


begin
   camposValidos:= true;
   registroValido:= true;
   PrecioTemporada := 0;

   if DatePicker1.Date > DatePicker2.Date then
    begin
      showmessage('La fecha de inicio no puede ser mayor a la fecha de fin');
       camposValidos := false;
    end;

   if Edit1.Text = '' then
    begin
       showmessage('El campo de cliente no puede estar vacío');
       camposValidos := false;
    end;


   if camposValidos then
   begin
    //showmessage('Los campos son válidos.');
    //una vez los datos son correctos, hay que comprobar que no hayan reservas hechas entre las fechas selecconadas para la habitación
    Tablas.FDTableEntradas.Filtered := True;
    Tablas.FDTableEntradas.Filter := 'numerohabitacion='+ComboBox1.Items[Combobox1.ItemIndex];
    Tablas.FDTableEntradas.First;

    while not Tablas.FDTableEntradas.eof do
      begin
        if (Tablas.FDTableEntradasfecha.Value >= DatePicker1.Date) and (Tablas.FDTableEntradasfecha.Value <= DatePicker2.Date) then
        begin
          registroValido:= false;
        end;
        
        Tablas.FDTableEntradas.Next;
      end;

    Tablas.FDTableEntradas.Filtered := False;

    if registroValido = false then
      begin
         showmessage('Hay reservas/ocupaciones en el periodo seleccionado');
      end else
      begin
          fechaentrada:= DatePicker1.Date;
          while fechaentrada <= DatePicker2.Date do
            begin
              Tablas.FDTableEntradas.Append;
              Tablas.FDTableEntradasnumerohabitacion.Value := StrToInt(ComboBox1.Items[Combobox1.ItemIndex]);
              Tablas.FDTableEntradasfecha.Value := fechaentrada;
              Tablas.FDTableEntradasestado.Value := 'reservada';
              Tablas.FDTableEntradascliente.Value := Edit1.Text;

              //precio base
              Tablas.FDTableHabitaciones.Filtered:=True;
              Tablas.FDTableHabitaciones.Filter:= 'numero='+(ComboBox1.Items[Combobox1.ItemIndex]);
              PrecioBase := Tablas.FDTableHabitacionespreciobase.Value; //necesitamos calcular el precio día a día, por si cambia por la temporada.
              Tablas.FDTableHabitaciones.Filtered:=False;

              //precio temporada
              dia:= DayOfTheMonth(fechaentrada);
              mes:= MonthOfTheYear(fechaentrada);
              año:= YearOf(fechaentrada);
             

              diabusqueda := IntToStr(dia);
              mesbusqueda := IntToStr(mes);
              if length(diabusqueda) < 2 then
                diabusqueda:= '0'+ diabusqueda;
              if length(mesbusqueda) < 2 then
                  mesbusqueda:= '0'+ mesbusqueda;
              fechabusqueda:= IntToStr(año)+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

              Tablas.FDQuery1.Close;
              Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedStr(fechabusqueda)+' and fechafin>='+quotedStr(fechabusqueda);
              Tablas.FDQuery1.Open;
              
              PrecioTemporada:=Tablas.FDQuery1.FieldByName('precioadicional').AsFloat;
              
              PrecioFinal := PrecioBase + PrecioTemporada;
              
              //precio servicios
              



              Tablas.FDTableEntradasPrecioFinal.Value := PrecioFinal;
              Tablas.FDTableEntradas.Post;

              fechaentrada := IncDay(fechaentrada, 1); //incrementar la fecha

            end;
          
      end;
    



   end;

end;

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
    Combobox1.Items.Clear; //vaciar el combobox para rellenarlo con las habitaciones
    Tablas.FDTableHabitaciones.First;
      while not  Tablas.FDTableHabitaciones.Eof do
        begin
          Habitacionescombo[i]:= Tablas.FDTableHabitacionesnumero.Value;
          Combobox1.Items.Add(IntToStr(Tablas.FDTableHabitacionesnumero.Value));
          i:=i+1;
          Tablas.FDTableHabitaciones.Next;
        end;

   Combobox1.ItemIndex := 0;

   DatePicker1.Date := Now; //resetear el formulario al dia de hoy, sin cliente especificado.
   DatePicker2.Date := Now;
   Edit1.Text:= '';


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
