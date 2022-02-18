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
    Panel1: TPanel;
    Label12: TLabel;
    SpinEdit1: TSpinEdit;
    Label10: TLabel;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function actualizarServicios(): Boolean;
    procedure borrarServicios();
    procedure RecalcularPrecio(Sender: TObject);
    procedure ActualizarPrecioTabla();
  private
    { Private declarations }
  public
    { Public declarations }
    dia: integer;
    mes: integer;
    a�o: integer;
    Habitacion: Integer;
  end;

var
  FormularioDiario: TFormularioDiario;
  Estado: String;
  Fecha: TDate;
  //Habitacion: Integer;
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

  DiaPasado: Boolean;

implementation

{$R *.dfm}
 uses Unit1, Unit2, Unit3, Unit6;

procedure TFormularioDiario.Button1Click(Sender: TObject);
var
seleccion: integer;
accionRealizada: boolean;
accionCancelada: boolean;
serviciosCambiados: boolean;
clienteValido: boolean;
accionValida: boolean;
begin
  accionRealizada:= false;
  clienteValido:= true;
  accionValida:= true;

 // ANULAR RESERVA (O BORRAR OCUPACI�N) si vamos a liberar una habitacion, significa que vamos a borrar su registro
 // a la vez, copiaremos el registro en el historico de entradas
  if (RadioGroup1.ItemIndex = 0) and (Estado <> 'libre') then
    begin
      accionCancelada:=false;
      // en primer lugar, si es una ocupaci�n, solo podemos borrarla si es del d�a de hoy  (o futura)
    if (Estado = 'ocupada') and (DiaPasado = true) then
     begin
          showmessage('No se puede borrar una ocupaci�n que ya ha ocurrido en el pasado.')
     end else
     begin  //por el contrario, las reservas pasadas si se pueden anular (o marcar como ocupadas


      seleccion := messagedlg('Vas a dejar libre una habitaci�n que estaba reservada/ocupada. Esto borrar� su registro y los correspondientes datos. �Est�s seguro?',mtWarning , mbOKCancel, 0);

      if seleccion = mrCancel then
      begin
       ShowMessage('Acci�n cancelada.');
      end;

       if seleccion = mrOK then
       begin

       BorrarServicios;

       //en caso de que tengamos reserva y ocupaci�n, habr�a que migrar los dos registros al hist�rico.
       Tablas.FDQuery1.Close;
       Tablas.FDQuery1.SQL.Text:= 'Select * from entradas where numerohabitacion='+IntToStr(Habitacion)+' and fecha = '+quotedStr(fechabusqueda);
       Tablas.FDQuery1.Open;

       Tablas.FDQuery1.First;
       while not Tablas.FDQuery1.Eof do
        begin       //a�adir al hist�rico
          Tablas.FDTableHistoricoentradas.Append; 
          Tablas.FDTableHistoricoentradasnumerohabitacion.value := Habitacion;
          Tablas.FDTableHistoricoentradasfecha.Value := Fecha;
          Tablas.FDTableHistoricoentradascliente.Value := Cliente;
          Tablas.FDTableHistoricoentradaspreciofinal.Value := PrecioFinal;
          Tablas.FDTableHistoricoentradasestado.Value := Tablas.FDQuery1.FieldByName('estado').AsString;
          Tablas.FDTableHistoricoentradas.Post;

          Tablas.FDQuery1.Next;
        end;


        //borrar de la tabla

       Tablas.FDTableEntradas.Filtered:=True;
       Tablas.FDTableEntradas.Filter:='numerohabitacion='+IntToStr(Habitacion);
       Tablas.FDTableEntradas.First;

        while not Tablas.FDTableEntradas.eof do
         begin

          if Tablas.FDTableEntradasFecha.Value = Fecha then  //borramos las entradas de esta habitacion para esta fecha
            begin
            Tablas.FDTableEntradas.Delete;
            end
            else
            begin
              Tablas.FDTableEntradas.Next;
            end;
          
          end;
        ShowMessage('El registo de esta habitaci�n para la fecha concreta ha sido borrado.');
        Tablas.FDTableEntradas.Filtered:=False;
        accionRealizada := true;
       end;

      end;

    end;




    
    // RESERVAR/0CUPAR UNA HABITACION QUE ESTABA LIBRE  (caso contrario al anterior)
    if (RadioGroup1.ItemIndex <> 0) and (Estado = 'libre') then
      begin
       //checkeamos que los necesarios est�n rellenos
        if Edit1.Text = '' then
          begin
            Showmessage('El campo del cliente no puede estar vac�o.');
            accionValida := false;
          end;

        if (RadioGroup1.ItemIndex = 1) and (DiaPasado = True) then
          begin
            Showmessage('No se puede reservar en un d�a pasado');
            accionValida := false;
          end;

       //vamos a ser generosos y pensar que al usuario se le podr�a haber olvidado marcar una ocupaci�n que ya ha pasado
       //con una semana de margen. Por tanto, solo podemos marcar de libre a ocupada si es hoy, o como mucho, hace 7 d�as
        if (RadioGroup1.ItemIndex = 2) then
          begin
            if (Fecha > Now()) or (Fecha < IncDay(Now(), -8)) then
            begin
            Showmessage('Solo se puede marcar una habitaci�n libre como ocupada en el d�a presente, o como muy tarde, con 7 d�as de retraso');
            accionValida := false;
            end;
          end;
        // esta condici�n no va en perjuicio de que cualquier reserva que quede en el pasado pueda ser marcada como libre u ocupada.



        if accionValida then
          begin

          AltaCliente.ImportarIdentificador(Edit1.Text); //preventivamente, mandamos el identificador al formulario.
          clienteValido := AltaCliente.AltaEnCaliente(Edit1.Text); //abre el alta de cliente si no existe.


          if not clienteValido then
            begin
              showmessage('Acci�n cancelada. No se puede completar la reserva con el identificador de un cliente inexistente');
              accionRealizada:= false;
            end
            else  //si el cliente es v�lido (exist�a o lo acabamos de crear)
            begin

            seleccion := messagedlg('�Confirmar Reserva (u ocupaci�n)?',mtConfirmation , mbOKCancel, 0);

            if seleccion = mrCancel then
              begin
                ShowMessage('Acci�n cancelada.');
                accionCancelada := true;
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
               Tablas.FDTableEntradaspreciofinal.Value := StrToInt(SpinEdit1.Text); //el precio es lo que aparezca en el spinner,
               // que de base es el precio final calculado, pero puede ser cambiado manualmente.

               if StrToInt(SpinEdit1.Text) < 0 then //si se intenta guardar el registro con precio menor o igual a 0
                 begin
                   showmessage('Error: El precio final no puede ser menor que 0');
                 end
                 else
                 begin
                   Tablas.FDTableEntradas.post;

                   accionRealizada:= True;
                 end;


              end;
             end;

          end;

      end;

    //OCUPAR UNA HABITACION QUE ESTABA RESERVADA (�hemos quedado en que crea un nuevo registro a parte del de la reserva?)
    //tambien hemos establecido que solo podemos pasar de reservada o ocupada si es hoy, o pasado.
    if (RadioGroup1.ItemIndex = 2) and (Estado = 'reservada') and (Fecha < Now()) then
      begin
          Tablas.FDTableEntradas.append;

          Tablas.FDTableEntradasnumerohabitacion.Value := Habitacion;
          Tablas.FDTableEntradasfecha.Value := Fecha;
          Tablas.FDTableEntradasestado.Value:= 'ocupada';

          Tablas.FDTableEntradascliente.Value:= Cliente; //usamos el cliente almacenado, en caso de que escribamos algo distinto.
          PrecioFinal:= PrecioBase + TemporadaPrecio; //calcular el precio final con servicios, etc.
          Tablas.FDTableEntradaspreciofinal.Value := StrToInt(SpinEdit1.Text);
          
          Tablas.FDTableEntradas.post;
          
          accionRealizada:= true;
      end;
    if (RadioGroup1.ItemIndex = 2) and (Estado = 'reservada') and (Fecha > Now()) then
      begin
         showmessage('No se puede marcar como ocupada una reserva que est� en el futuro.  ');
      end;


    //PASAR DE OCUPACION A RESERVA? no lo creo
    if (RadioGroup1.ItemIndex = 1) and (Estado = 'ocupada') then
    begin
      showmessage('Est�s intentado reservar una habitaci�n ocupada. Si quieres reservar la habitaci�n, lib�rala primero (Marca "libre")');
    end;


    //CAMBIAR SERVICIOS

    serviciosCambiados:= ActualizarServicios;
    if serviciosCambiados then accionRealizada := True;

    ActualizarPrecioTabla(); //siempre que pulsemos el boton, el precio se actualizar� con lo que haya en el spinner

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

//dia: integer;
//mes: integer;
//a�o: integer;

servicioCheck: TCheckbox;

begin
  //dia:= PantallaMes.DevolverDiaSeleccionado;
  //mes:= MonthOfTheYear(PantallaMes.DevolverFechaSeleccionada1);
  //a�o:= YearOf(PantallaMes.DevolverFechaSeleccionada1);
  Fecha:= EncodeDate(a�o, mes, dia); //Tdate del formulario

  if Fecha < IncDay(Now(), -1) then
  begin
    DiaPasado:= True;
  end else
  begin
    DiaPasado:= False;
  end;

  diabusqueda := IntToStr(dia);
  mesbusqueda := IntToStr(mes);
  if length(diabusqueda) < 2 then
    diabusqueda:= '0'+ diabusqueda;
    if length(mesbusqueda) < 2 then
    mesbusqueda:= '0'+ mesbusqueda;
  fechabusqueda:= IntToStr(a�o)+'-'+mesbusqueda+'-'+diabusqueda;  //fecha formateada para buscarla con SQL

  //Habitacion:= PantallaMes.DevolverHabitacionSeleccionada1();

  //buscamos en la tabla con en n� y fecha seleccionados, con lo que vamos encontrando, vamos rellenando el formulario

  //la idea de este formulario es guardar el estado actual cuando se ejecuta el activate (en funci�n de fecha y habitaci�n seleccionada)
  //y luego al pulsar el bot�n, comparar ese estado con lo que se ha seleccionado en el formulario.
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
  if Tablas.FDQuery1.Locate('estado', 'ocupada', []) then  //si hay dos registros, uno de reserva y otro de ocupacion, consideramos el de ocupaci�n
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
    begin
      RadioGroup1.ItemIndex:=0;
      Panel1.Visible := False;
    end
    else
    begin
      Panel1.Visible := True;
    end;

    if Estado = 'reservada' then
      RadioGroup1.ItemIndex:=1;
    if Estado = 'ocupada' then
      RadioGroup1.ItemIndex:=2;



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
        servicioCheck.Parent:=Panel1;

        servicioCheck.Tag:=i;
        servicioCheck.Top:=i*20+30;
        servicioCheck.Left:=15;
        servicioCheck.Caption:=nombresServicios[i] + ' ('+FloatToStr(Tablas.FDTableServiciosprecioservicio.Value)+'�)';

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
               //los que tuvieran un registro (estaban contratados) aparecer�n checkeados.
               CheckboxServicios[i].Checked:=True;
            end
            else
            begin
               serviciosContratados[i]:=False;
            end;

        end;
      //de esta manera tenemos guardado el estado actual de los servicios, si cambiamos los checkbox, al salir, los
      //comparamos y sabemos cual tenemos que a�adir o quitar de entradasservicios.





   //si la habitaci�n estaba libre, mostramos su precio base de la tabla de habitaciones.

    Tablas.FDTableHabitaciones.Filtered:=True;
    Tablas.FDTableHabitaciones.Filter:= 'numero='+IntTostr(Habitacion);
    PrecioBase:=Tablas.FDTableHabitacionespreciobase.Value; //en cualquier caso nos interesa guardar el precio base de la habitaci�n
    Tablas.FDTableHabitaciones.Filtered:=False;

    PrecioCalculado := PrecioBase + TemporadaPrecio;

    if Estado = 'libre' then
     begin
        Label3.Caption:=FloatToStr(PrecioCalculado);
        SpinEdit1.Text:=FloatToStr(PrecioCalculado);
        PrecioCalculado := PrecioBase + TemporadaPrecio;
     end
     else
     begin
        Label3.Caption:=FloatToStr(PrecioFinal); //si no estaba libre, mostramos su precio final (que incluir� servicios o lo que hubiera)
        SpinEdit1.Text:=FloatToStr(PrecioFinal);
        PrecioCalculado := PrecioFinal;
     end;

end;








//GESTI�N DE SERVICIOS (borrarlos, crearlos)



procedure TFormularioDiario.BorrarServicios(); //este procedimiento es exclusivo para cuando vamos a liberar una habitaci�n, dado que hay que borrar sus servicios
begin
  Tablas.FDTableEntradasservicios.Filtered:=True;
    Tablas.FDTableEntradasservicios.Filter:='numerohabitacion='+IntToStr(Habitacion);
    Tablas.FDTableEntradasservicios.First;
    while not Tablas.FDTableEntradasservicios.eof do
      begin
        if Tablas.FDTableEntradasserviciosfecha.Value = Fecha then
          begin
            Tablas.FDTableEntradasservicios.Delete; //borramos los registros de esta habitaci�n para la fecha concreta.

          end
          else
          begin
            Tablas.FDTableEntradasservicios.next; //esto hay que meterlo en un else porque si borra algo, se salta el siguiente
          end;

      end;
    Tablas.FDTableEntradasservicios.Filtered:=False;

end;

function TFormularioDiario.ActualizarServicios(): Boolean;
var  //PROBABLEMENTE HAY QUE PULIR LAS OPCIONES DE ESTA FUNCI�N
i: integer;
servicioscambiados: boolean;
begin
  servicioscambiados:= false;
  //solo daremos de alta servicios si la habitaci�n no va a estar libre. Es decir, si el radio bot�n est� en libre, (se encarga el procedimiento anterior)
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
            Tablas.FDTableEntradasservicios.Delete; //borramos los registros de esta habitaci�n para la fecha concreta.

          end
          else
          begin
            Tablas.FDTableEntradasservicios.next; //esto hay que meterlo en un else porque si borra algo, se salta el siguiente
          end;

      end;
    Tablas.FDTableEntradasservicios.Filtered:=False;
    servicioscambiados := True;
  end


  else //si el estado quedar� como reservado u ocupado.   }
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
      servicioscambiados:=false; //corrige un peque�o error por el cual si una habitacion libre se intenta
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


procedure TFormularioDiario.ActualizarPrecioTabla();
//var
begin
  if StrToFloat(SpinEdit1.Text) <> Preciofinal then  //si hemos cambiado el precio de alguna manera, hay que actualizarlo.
   if StrToInt(SpinEdit1.Text) >= 0 then //si se intenta guardar el registro con precio menor o igual a 0, no dejamos
   begin
    begin
      Tablas.FDTableEntradas.Filtered := True;
      Tablas.FDTableEntradas.Filter := 'numerohabitacion='+IntToStr(Habitacion);
      Tablas.FDTableEntradas.First;
      while not  Tablas.FDTableEntradas.eof do
        begin
          if Tablas.FDTableEntradasfecha.Value = Fecha then
          begin
            Tablas.FDTableEntradas.Edit;
            Tablas.FDTableEntradaspreciofinal.Value := StrToFloat(SpinEdit1.Text);
            Tablas.FDTableEntradas.Post;
          end;

           Tablas.FDTableEntradas.Next;
        end;
      Tablas.FDTableEntradas.Filtered := False;
    end;
   end
   else
   begin
     showmessage('El precio no puede ser menor que 0');
   end;
end;



end.
