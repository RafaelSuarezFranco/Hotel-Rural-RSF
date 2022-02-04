unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, System.DateUtils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormularioDiario = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Label8: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormularioDiario: TFormularioDiario;
  Estado: String;
  Fecha: TDate;
  Habitacion: Integer;
  Cliente: String;
  Preciofinal: Double;
  fechabusqueda: String;
  PrecioBase: Double;
  TemporadaPrecio: Double;

  CheckboxServicios: Array of TCheckbox;
  NombresServicios: Array of String;

implementation

{$R *.dfm}
 uses Unit1, Unit2, Unit3;

procedure TFormularioDiario.Button1Click(Sender: TObject);
var
seleccion: integer;
accionRealizada: boolean;
begin
  accionRealizada:= false;

 // ANULAR RESERVA (O BORRAR OCUPACI�N) si vamos a liberar una habitacion, significa que vamos a borrar su registro
  if (RadioGroup1.ItemIndex = 0) and (Estado <> 'libre') then
    begin
      seleccion := messagedlg('Vas a dejar libre una habitaci�n que estaba reservada/ocupada. Esto borrar� su registro y los correspondientes datos. �Est�s seguro?',mtWarning , mbOKCancel, 0);

      if seleccion = mrCancel then ShowMessage('Acci�n cancelada.');
       if seleccion = mrOK then
       begin

       Tablas.FDTableEntradas.Filtered:=True;
       Tablas.FDTableEntradas.Filter:='numerohabitacion='+IntToStr(Habitacion);
       Tablas.FDTableEntradas.First;

        while not Tablas.FDTableEntradas.eof do
         begin

          if Tablas.FDTableEntradasFecha.Value = Fecha then  //borramos las entradas de esta habitacion para esta fecha
            begin
            Tablas.FDTableEntradas.Delete;
            ShowMessage('El registo de esta habitaci�n para la fecha concreta ha sido borrado.');
            end;
          Tablas.FDTableEntradas.Next;
          end;
        Tablas.FDTableEntradas.Filtered:=False;
        accionRealizada := true;
       end;
    end;
    // RESERVAR UNA HABITACION QUE ESTABA LIBRE  (caso contrario al anterior)
    if (RadioGroup1.ItemIndex <> 0) and (Estado = 'libre') then
      begin
       //checkeamos que los necesarios est�n rellenos
        if Edit1.Text = '' then
          begin
            Showmessage('El campo del cliente no puede estar vac�o.')
          end
          else
          begin
            seleccion := messagedlg('�Confirmar Reserva (u ocupaci�n)?',mtConfirmation , mbOKCancel, 0);

            if seleccion = mrCancel then ShowMessage('Acci�n cancelada.');
            if seleccion = mrOK then
            begin
               Tablas.FDTableEntradas.append;
               Tablas.FDTableEntradasnumerohabitacion.Value := Habitacion;
               Tablas.FDTableEntradasfecha.Value := Fecha;
               if RadioGroup1.ItemIndex = 1 then
                  Tablas.FDTableEntradasestado.Value:= 'reservada';
               if RadioGroup1.ItemIndex = 2 then
                  Tablas.FDTableEntradasestado.Value:= 'ocupada';

               Tablas.FDTableEntradascliente.Value:= Edit1.Text;
               PrecioFinal:= PrecioBase + TemporadaPrecio; //calcular el precio final con servicios, etc.
               Tablas.FDTableEntradaspreciofinal.Value := PrecioFinal;

               Tablas.FDTableEntradas.post;

               accionRealizada:= True;
            end;
          end;

      end;

    //OCUPAR UNA HABITACION QUE ESTABA RESERVADA (�hemos quedado en que crea un nuevo registro a parte del de la reserva?)



    if accionRealizada then
    begin
     //cerramos y actualizamos la pantalla del mes (y la principal, si hemos actualizado el d�a de hoy).
     FormularioDiario.Close;
     PantallaMes.cargarMes;
     Principal.cargarDia;
    end;

end;

procedure TFormularioDiario.FormActivate(Sender: TObject);
var
i: integer;

diabusqueda: String;
mesbusqueda: String;

dia: integer;
mes: integer;
a�o: integer;

servicioCheck: TCheckbox;

begin
  dia:= PantallaMes.DevolverDiaSeleccionado;
  mes:= MonthOfTheYear(PantallaMes.DevolverFechaSeleccionada1);
  a�o:= YearOf(PantallaMes.DevolverFechaSeleccionada1);
  Fecha:= EncodeDate(a�o, mes, dia); //Tdate del formulario

  diabusqueda := IntToStr(dia);
  mesbusqueda := IntToStr(mes);
  if length(diabusqueda) < 2 then
    diabusqueda:= '0'+ diabusqueda;
    if length(mesbusqueda) < 2 then
    mesbusqueda:= '0'+ mesbusqueda;
  fechabusqueda:= IntToStr(a�o)+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

  Habitacion:= PantallaMes.DevolverHabitacionSeleccionada1();
  //buscamos en la tabla con en n� y fecha seleccionados, con lo que vamos encontrando, vamos rellenando el formulario
  Tablas.FDQuery1.Close;
  Tablas.FDQuery1.SQL.Text:= 'Select * from entradas where numerohabitacion='+IntToStr(Habitacion)+' and fecha = '+quotedStr(fechabusqueda);
  Tablas.FDQuery1.Open;

  Estado:= 'libre';
  Cliente:= '';

  Preciofinal:=Tablas.FDQuery1.FieldByName('preciofinal').AsFloat;

  if Tablas.FDQuery1.Locate('estado', 'reservada', []) then
    begin
    Estado := 'reservada';
    Cliente:= Tablas.FDQuery1.FieldByName('cliente').AsString;
    end;
  if Tablas.FDQuery1.Locate('estado', 'ocupada', []) then
    begin
     Estado := 'ocupada';
      Cliente:= Tablas.FDQuery1.FieldByName('cliente').AsString;
    end;

    //sacamos el precio adicional por temporada
    TemporadaPrecio:=0; //por defecto es baja y no sumamos nada.
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedStr(fechabusqueda)+' and fechafin>='+quotedStr(fechabusqueda);
    Tablas.FDQuery1.Open;
      if Tablas.FDQuery1.Locate('nombretemporada', 'alta', []) then
      begin
         TemporadaPrecio:=Tablas.FDQuery1.FieldByName('precioadicional').AsFloat;
      end;
       if Tablas.FDQuery1.Locate('nombretemporada', 'media', []) then
      begin
         TemporadaPrecio:=Tablas.FDQuery1.FieldByName('precioadicional').AsFloat;
      end;

    if Estado = 'libre' then
      RadioGroup1.ItemIndex:=0;
    if Estado = 'reservada' then
      RadioGroup1.ItemIndex:=1;
    if Estado = 'ocupada' then
      RadioGroup1.ItemIndex:=2;

    //si la habitaci�n estaba libre, mostramos su precio base de la tabla de habitaciones.

    Tablas.FDTableHabitaciones.Filtered:=True;
    Tablas.FDTableHabitaciones.Filter:= 'numero='+IntTostr(Habitacion);
    PrecioBase:=Tablas.FDTableHabitacionespreciobase.Value; //en cualquier caso nos interesa guardar el precio base de la habitaci�n
    Tablas.FDTableHabitaciones.Filtered:=False;

    if Estado = 'libre' then
     begin
        Label3.Caption:=FloatToStr(PrecioBase + TemporadaPrecio);
     end
     else
     begin
        Label3.Caption:=FloatToStr(PrecioFinal); //si no estaba libre, mostramos su precio final (que incluir� servicios)
     end;

    Label6.Caption:= IntToStr(Habitacion);
    Label7.Caption:= DateToStr(Fecha);
    Edit1.Text:=Cliente;
    //Label3.Caption:=FloatToStr(Preciofinal);

    //showmessage(Estado+Cliente);

    //SERVICIOS

      SetLength(CheckboxServicios, Tablas.FDTableServicios.RecordCount);
      SetLength(nombresServicios, Tablas.FDTableServicios.RecordCount);

    //crear checkboxs de servicios.
    i:=0;
    Tablas.FDTableServicios.First;
    while not Tablas.FDTableServicios.Eof do
       begin
        nombresServicios[i] := Tablas.FDTableServiciosnombreservicio.Value;

        servicioCheck:=TCheckbox.create(self);
        servicioCheck.Parent:=FormularioDiario;

        servicioCheck.Tag:=HabitacionesBD[i];
        servicioCheck.Top:=i*20+320;
        servicioCheck.Left:=55;
        servicioCheck.Caption:=nombresServicios[i] + ' ('+FloatToStr(Tablas.FDTableServiciosprecioservicio.Value)+'�)';

        CheckboxServicios[i]:= servicioCheck;

        Tablas.FDTableServicios.Next;
        i:=i+1;
       end;

       //hay que checkear aquellos que tengan un registro en la tabla entradasservicios

end;

end.
