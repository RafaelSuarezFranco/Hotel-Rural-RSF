unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, System.DateUtils,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Samples.Spin;

type
  TFormularioDiario = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioGroup1: TRadioGroup;
    Edit1: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Label8: TLabel;
    Label9: TLabel;
    SpinEdit1: TSpinEdit;
    Label5: TLabel;
    Label10: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function actualizarServicios(): Boolean;
    procedure borrarServicios();
    procedure RecalcularPrecio(Sender: TObject);
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
  PrecioCalculado: Double;

  CheckboxServicios: Array of TCheckbox;
  NombresServicios: Array of String;
  ServiciosContratados: Array of Boolean;
  PreciosServicios: Array of Double;

implementation

{$R *.dfm}
 uses Unit1, Unit2, Unit3;

procedure TFormularioDiario.Button1Click(Sender: TObject);
var
seleccion: integer;
accionRealizada: boolean;
accionCancelada: boolean;
serviciosCambiados: boolean;
begin
  accionRealizada:= false;

 // ANULAR RESERVA (O BORRAR OCUPACIÓN) si vamos a liberar una habitacion, significa que vamos a borrar su registro
  if (RadioGroup1.ItemIndex = 0) and (Estado <> 'libre') then
    begin
    accionCancelada:=false;

      seleccion := messagedlg('Vas a dejar libre una habitación que estaba reservada/ocupada. Esto borrará su registro y los correspondientes datos. ¿Estás seguro?',mtWarning , mbOKCancel, 0);

      if seleccion = mrCancel then
      begin
       ShowMessage('Acción cancelada.');
      end;

       if seleccion = mrOK then
       begin

       BorrarServicios;

       Tablas.FDTableEntradas.Filtered:=True;
       Tablas.FDTableEntradas.Filter:='numerohabitacion='+IntToStr(Habitacion);
       Tablas.FDTableEntradas.First;

        while not Tablas.FDTableEntradas.eof do
         begin

          if Tablas.FDTableEntradasFecha.Value = Fecha then  //borramos las entradas de esta habitacion para esta fecha
            begin
            Tablas.FDTableEntradas.Delete;
            ShowMessage('El registo de esta habitación para la fecha concreta ha sido borrado.');
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
       //checkeamos que los necesarios estén rellenos
        if Edit1.Text = '' then
          begin
            Showmessage('El campo del cliente no puede estar vacío.')
          end
          else
          begin
            seleccion := messagedlg('¿Confirmar Reserva (u ocupación)?',mtConfirmation , mbOKCancel, 0);

            if seleccion = mrCancel then
             begin
              ShowMessage('Acción cancelada.');
              accionCancelada := true;  //AL CANCELAR ACCION (rserva/ocupar), AÚN SE GUARDAN LOS REGISTROS DE SERVICIOS!!
             end;

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

    //OCUPAR UNA HABITACION QUE ESTABA RESERVADA (¿hemos quedado en que crea un nuevo registro a parte del de la reserva?)


    //CAMBIAR SERVICIOS

    serviciosCambiados:= ActualizarServicios;
    if serviciosCambiados then accionRealizada := True;



    if accionRealizada then
    begin
     //cerramos y actualizamos la pantalla del mes (y la principal, si hemos actualizado el día de hoy).
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
año: integer;

servicioCheck: TCheckbox;

begin
  dia:= PantallaMes.DevolverDiaSeleccionado;
  mes:= MonthOfTheYear(PantallaMes.DevolverFechaSeleccionada1);
  año:= YearOf(PantallaMes.DevolverFechaSeleccionada1);
  Fecha:= EncodeDate(año, mes, dia); //Tdate del formulario

  diabusqueda := IntToStr(dia);
  mesbusqueda := IntToStr(mes);
  if length(diabusqueda) < 2 then
    diabusqueda:= '0'+ diabusqueda;
    if length(mesbusqueda) < 2 then
    mesbusqueda:= '0'+ mesbusqueda;
  fechabusqueda:= IntToStr(año)+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

  Habitacion:= PantallaMes.DevolverHabitacionSeleccionada1();
  //buscamos en la tabla con en nº y fecha seleccionados, con lo que vamos encontrando, vamos rellenando el formulario
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

    //si la habitación estaba libre, mostramos su precio base de la tabla de habitaciones.

    Tablas.FDTableHabitaciones.Filtered:=True;
    Tablas.FDTableHabitaciones.Filter:= 'numero='+IntTostr(Habitacion);
    PrecioBase:=Tablas.FDTableHabitacionespreciobase.Value; //en cualquier caso nos interesa guardar el precio base de la habitación
    Tablas.FDTableHabitaciones.Filtered:=False;

    PrecioCalculado := PrecioBase + TemporadaPrecio;

    if Estado = 'libre' then
     begin
        Label3.Caption:=FloatToStr(PrecioCalculado);
        SpinEdit1.Text:=FloatToStr(PrecioCalculado);
     end
     else
     begin
        Label3.Caption:=FloatToStr(PrecioFinal); //si no estaba libre, mostramos su precio final (que incluirá servicios o lo que hubiera)
        SpinEdit1.Text:=FloatToStr(PrecioFinal);
     end;

    Label6.Caption:= IntToStr(Habitacion);
    Label7.Caption:= DateToStr(Fecha);
    Edit1.Text:=Cliente;
    //Label3.Caption:=FloatToStr(Preciofinal);

    //showmessage(Estado+Cliente);

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
        servicioCheck.Parent:=FormularioDiario;

        servicioCheck.Tag:=i;
        servicioCheck.Top:=i*20+320;
        servicioCheck.Left:=55;
        servicioCheck.Caption:=nombresServicios[i] + ' ('+FloatToStr(Tablas.FDTableServiciosprecioservicio.Value)+'€)';

        PreciosServicios[i] := Tablas.FDTableServiciosprecioservicio.Value;
        CheckboxServicios[i]:= servicioCheck;

        CheckboxServicios[i].OnClick := RecalcularPrecio;

        Tablas.FDTableServicios.Next;
        i:=i+1;
       end;

       //hay que checkear aquellos que tengan un registro en la tabla entradasservicios

      Tablas.FDQuery1.Close;
      Tablas.FDQuery1.SQL.Text := 'select * from entradasservicios where fecha='+quotedStr(fechabusqueda)+' and numerohabitacion='+IntToStr(Habitacion);
      Tablas.FDQuery1.Open;

       for i := 0 to Length(nombresServicios)-1 do
        begin
           if Tablas.FDQuery1.locate('nombreservicio', nombresServicios[i], []) then
            begin
               serviciosContratados[i]:=True;
               //los que tuvieran un registro (estaban contratados) aparecerán checkeados.
               CheckboxServicios[i].Checked:=True;
            end
            else
            begin
               serviciosContratados[i]:=False;
            end;

        end;
      //de esta manera tenemos guardado el estado actual de los servicios, si cambiamos los checkbox, al salir, los
      //comparamos y sabemos cual tenemos que añadir o quitar de entradasservicios.

end;








//GESTIÓN DE SERVICIOS (borrarlos, crearlos)



procedure TFormularioDiario.BorrarServicios(); //este procedimiento es exclusivo para cuando vamos a liberar una habitación, dado que hay que borrar sus servicios
begin
  Tablas.FDTableEntradasservicios.Filtered:=True;
    Tablas.FDTableEntradasservicios.Filter:='numerohabitacion='+IntToStr(Habitacion);
    Tablas.FDTableEntradasservicios.First;
    while not Tablas.FDTableEntradasservicios.eof do
      begin
        if Tablas.FDTableEntradasserviciosfecha.Value = Fecha then
          begin
            Tablas.FDTableEntradasservicios.Delete; //borramos los registros de esta habitación para la fecha concreta.

          end
          else
          begin
            Tablas.FDTableEntradasservicios.next; //esto hay que meterlo en un else porque si borra algo, se salta el siguiente
          end;

      end;
    Tablas.FDTableEntradasservicios.Filtered:=False;

end;

function TFormularioDiario.ActualizarServicios(): Boolean;
var  //PROBABLEMENTE HAY QUE PULIR LAS OPCIONES DE ESTA FUNCIÓN
i: integer;
servicioscambiados: boolean;
begin
  servicioscambiados:= false;
  //solo daremos de alta servicios si la habitación no va a estar libre. Es decir, si el radio botón está en libre, (se encarga el procedimiento anterior)
  //borramos los registros, en caso contrario, borramos o creamos dependiendo de cada caso.
  if RadioGroup1.ItemIndex <> 0 then
 { begin
    Tablas.FDTableEntradasservicios.Filtered:=True;
    Tablas.FDTableEntradasservicios.Filter:='numerohabitacion='+IntToStr(Habitacion);
    Tablas.FDTableEntradasservicios.First;
    while not Tablas.FDTableEntradasservicios.eof do
      begin
        if Tablas.FDTableEntradasserviciosfecha.Value = Fecha then
          begin
            Tablas.FDTableEntradasservicios.Delete; //borramos los registros de esta habitación para la fecha concreta.

          end
          else
          begin
            Tablas.FDTableEntradasservicios.next; //esto hay que meterlo en un else porque si borra algo, se salta el siguiente
          end;

      end;
    Tablas.FDTableEntradasservicios.Filtered:=False;
    servicioscambiados := True;
  end


  else //si el estado quedará como reservado u ocupado.   }
  begin
    for i := 0 to Length(CheckboxServicios)-1 do
      begin
        if serviciosContratados[i] <> CheckboxServicios[i].Checked then //si lo que habia difiere de lo que el checkbox marca
           begin
             servicioscambiados := True;
            //caso 1: estaba contratado y vamos a borrarlo.
            if serviciosContratados[i] then
              begin
                 Tablas.FDTableEntradasservicios.Filtered:=True;
                 Tablas.FDTableEntradasservicios.Filter:='numerohabitacion='+IntToStr(Habitacion);
                 Tablas.FDTableEntradasservicios.First;
                  while not Tablas.FDTableEntradasservicios.eof do
                    begin
                      if (Tablas.FDTableEntradasserviciosfecha.Value = Fecha) and (Tablas.FDTableEntradasserviciosnombreservicio.Value = nombresServicios[i]) then
                        begin
                          Tablas.FDTableEntradasservicios.Delete; //borramos un registro con el nombre del servicio que queremos quitar.
                        end
                        else
                        begin
                          Tablas.FDTableEntradasservicios.next;
                        end;

                    end;
                  Tablas.FDTableEntradasservicios.Filtered:=False;

              end;
             //caso 2: no estaba contratado y vamos a darlo de alta.
            if not serviciosContratados[i] then
              begin
                Tablas.FDTableEntradasservicios.Append;
                Tablas.FDTableEntradasserviciosnumerohabitacion.Value := Habitacion;
                Tablas.FDTableEntradasserviciosfecha.Value := Fecha;
                Tablas.FDTableEntradasserviciosnombreservicio.Value := nombresServicios[i];
                Tablas.FDTableEntradasservicios.Post;
              end;

           end;
      end;

   if (RadioGroup1.ItemIndex <> 0) and (Estado = 'libre') and (Edit1.Text = '') then
      servicioscambiados:=false; //corrige un pequeño error por el cual si una habitacion libre se intenta
      //reservar con unos servicios pero no es mete el nombre de cliente, simplmente se guardan los servicios
      //(pero no se hace la reserva porque falta el cliente)

  end;
  ActualizarServicios := servicioscambiados;//devolvemos si hemos cambiado o no algo.

end;

procedure TFormularioDiario.RecalcularPrecio(Sender: TObject);
var
  i: integer;
 checkbox: TCheckbox;
begin
   checkbox := TCheckbox(Sender);
   i := checkbox.Tag;
   if  CheckboxServicios[i].Checked then
    begin
      PrecioCalculado := PrecioCalculado + PreciosServicios[i];
      SpinEdit1.Text := FloatToStr(PrecioCalculado);
    end;
     if  not CheckboxServicios[i].Checked then
    begin
      PrecioCalculado := PrecioCalculado - PreciosServicios[i];
      SpinEdit1.Text := FloatToStr(PrecioCalculado);
    end;
end;

end.
