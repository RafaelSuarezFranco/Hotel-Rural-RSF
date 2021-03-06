unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers,  System.DateUtils,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

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
    Label5: TLabel;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ModoReserva();
    procedure ModoAnular();
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormularioPeriodo: TFormularioPeriodo;

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

  ModoDeFormulario: String;

implementation

{$R *.dfm}
 uses Unit1, Unit2, Unit3, Unit6;



 //bot?n ?nico del formulario, ya sea para reservar u anular

procedure TFormularioPeriodo.Button1Click(Sender: TObject);
var
camposValidos: boolean;
registroValido: boolean;
clienteValido: boolean;
fechaentrada: TDate;
PrecioBase: Double;
PrecioTemporada: Double;
PrecioFinal: Double;
PrecioServiciosTotal: Double;
fechabusqueda: String;

borrarServicioCliente: boolean; //si un cliente anula sus reservas, tenemos que controlar que servicios anular

fecha1: TDate;
fecha2: TDate;

seleccion: integer;
i: integer;
begin
  StatusBar1.SimpleText := 'Procesando la orden...';

   camposValidos:= true;
   registroValido:= true;
   clienteValido := true;
   PrecioTemporada := 0;
   PrecioServiciosTotal := 0;

   fecha1:= IncDay(DatePicker1.Date, -1); //hab?a un problema a la hora de comparar fechas, tuve que ampliar el marco por arriba y por abajo para que funcione correctamente.
   fecha2:= IncDay(DatePicker2.Date, 1);

   //validaciones pertinentes

   if DatePicker1.Date > DatePicker2.Date then
    begin
      showmessage('La fecha de inicio no puede ser mayor a la fecha de fin');
       camposValidos := false;
       registroValido := false;
    end;

    if DatePicker1.Date < IncDay(Now(), -1) then //esto impedir? reservar o anular fechas pasadas (podemos reservar anular de hoy en adelante).
    begin
       showmessage('Solo se pueden reservar/anular reservas para el d?a de hoy en adelante.');
       camposValidos := false;
       registroValido := false;
    end;


   if (Edit1.Text = '') and (ModoDeFormulario = 'reserva') then
    begin
       showmessage('El campo de cliente no puede estar vac?o');
       camposValidos := false;
       registroValido := false;
    end;

    if (Edit1.Text <> '') and (ModoDeFormulario = 'reserva') and (camposValidos = true) then
    begin
      AltaCliente.ImportarIdentificador(Edit1.Text); //preventivamente, mandamos el identificador al formulario.
      clienteValido := AltaCliente.AltaEnCaliente(Edit1.Text); //abre el alta de cliente si no existe.

    end;


  if not clienteValido then
    begin
      showmessage('Acci?n cancelada. No se puede completar la reserva con el identificador de un cliente inexistente');
       camposValidos := false;
       registroValido := false;
    end;

   if (not camposValidos) then StatusBar1.SimpleText := 'Error: algunos campos no son v?lidos.';

   //MODO RESERVA

   if (camposValidos) and (ModoDeFormulario = 'reserva') then
   begin
    StatusBar1.SimpleText := 'Comprobando las fechas especificadas...';
    //showmessage('Los campos son v?lidos.');
    //una vez los datos son correctos, hay que comprobar que no hayan reservas hechas entre las fechas selecconadas para la habitaci?n
    Tablas.FDTableEntradas.Filtered := True;
    Tablas.FDTableEntradas.Filter := 'numerohabitacion='+ComboBox1.Items[Combobox1.ItemIndex];
    Tablas.FDTableEntradas.First;


    while not Tablas.FDTableEntradas.eof do
      begin

      if (Tablas.FDTableEntradasfecha.Value > fecha1) and (Tablas.FDTableEntradasfecha.Value < fecha2) then
        begin
             registroValido:= false;  //si hay alguna fecha ya reservada/ocupada
              StatusBar1.SimpleText := 'Atenci?n, se han encontrado d?as ya reservados en el periodo especificado';
         end;


        Tablas.FDTableEntradas.Next;
      end;

    Tablas.FDTableEntradas.Filtered := False;

     //comprobar qu? servicios vamos a dar de alta
    for i := 0 to Length(CheckboxServicios)-1 do
      begin
        if CheckboxServicios[i].Checked then
          begin
            ServiciosContratados[i] := true;
            PrecioServiciosTotal:= PrecioServiciosTotal + PreciosServicios[i];
          end
          else
          begin
            ServiciosContratados[i] := false;
          end;
      end;

    if registroValido = false then
      begin
         showmessage('Hay reservas/ocupaciones en el periodo seleccionado');
      end
      else
      begin
       StatusBar1.SimpleText := 'Reservando d?as y servicios para la habitaci?n '+ComboBox1.Items[Combobox1.ItemIndex]+'...';
          fechaentrada:= DatePicker1.Date;
          while fechaentrada < fecha2 do
            begin
              Tablas.FDTableEntradas.Append;
              Tablas.FDTableEntradasnumerohabitacion.Value := StrToInt(ComboBox1.Items[Combobox1.ItemIndex]);
              Tablas.FDTableEntradasfecha.Value := fechaentrada;
              Tablas.FDTableEntradasestado.Value := 'reservada';
              Tablas.FDTableEntradascliente.Value := Edit1.Text;

              //precio base
              Tablas.FDTableHabitaciones.Filtered:=True;
              Tablas.FDTableHabitaciones.Filter:= 'numero='+(ComboBox1.Items[Combobox1.ItemIndex]);
              PrecioBase := Tablas.FDTableHabitacionespreciobase.Value; //necesitamos calcular el precio d?a a d?a, por si cambia por la temporada.
              Tablas.FDTableHabitaciones.Filtered:=False;

              //precio temporada

              fechabusqueda:= Tablas.formatearFechaSQL(fechaentrada);

              Tablas.FDQuery1.Close;
              Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedStr(fechabusqueda)+' and fechafin>='+quotedStr(fechabusqueda);
              Tablas.FDQuery1.Open;
              
              PrecioTemporada:=Tablas.FDQuery1.FieldByName('precioadicional').AsFloat;
              
              PrecioFinal := PrecioBase + PrecioTemporada + PrecioServiciosTotal;


              Tablas.FDTableEntradasPrecioFinal.Value := PrecioFinal;
              Tablas.FDTableEntradas.Post;

              //crear registros de los servicios (seguimos dentro de registroValido = true)
              for i := 0 to Length(ServiciosContratados)-1 do  //por cada dia, a?adimos un registro por cada servicio marcado.
                begin
                  if ServiciosContratados[i] then
                    begin
                      Tablas.FDTableEntradasservicios.append;
                      Tablas.FDTableEntradasserviciosnumerohabitacion.Value := StrToInt(ComboBox1.Items[Combobox1.ItemIndex]);
                      Tablas.FDTableEntradasserviciosfecha.Value := fechaentrada;
                      Tablas.FDTableEntradasserviciosnombreservicio.Value := NombresServicios[i];
                      Tablas.FDTableEntradasservicios.post;
                    end;

                end;


              fechaentrada := IncDay(fechaentrada, 1); //incrementar la fecha para iterar el bucle
            end;



          StatusBar1.SimpleText := 'Reserva completada con ?xito';
          showmessage('Se ha reservado con ?xito el periodo especificado.');
      end;

   end;

   //MODO ANULAR RESERVA
 if (camposValidos) and (ModoDeFormulario = 'anular') then
   begin
     seleccion := messagedlg('?Seguro que quieres anular todas las reservas/ocupaciones entre las fechas especificadas?',mtWarning , mbOKCancel, 0);

      if seleccion = mrCancel then
      begin
        StatusBar1.SimpleText :=  'No se ha anulado ninguna reserva';
       ShowMessage('Acci?n cancelada.');
       registroValido := false;
      end;

      if seleccion = mrOK then
       begin

          Tablas.FDTableEntradas.Filtered := True;
          Tablas.FDTableEntradas.Filter := 'numerohabitacion='+ComboBox1.Items[Combobox1.ItemIndex];



 //borrar los servicios contratados  HAY QUE BORRAR SERVICIOS PRIMERO PORQUE HAY QUE CONSULTAR LAS ENTRADAS ANTES DE BORRARLAS
                Tablas.FDTableentradasservicios.Filtered:= True;
                Tablas.FDTableentradasservicios.Filter:= 'numerohabitacion='+ComboBox1.Items[Combobox1.ItemIndex];
                Tablas.FDTableentradasservicios.First;
                while not Tablas.FDTableentradasservicios.eof do
                  begin

                    borrarServicioCliente := false;
                    fechabusqueda := Tablas.formatearFechaSQL(Tablas.FDTableEntradasserviciosfecha.Value);

                    Tablas.FDQuery1.Close;
                    Tablas.FDQuery1.SQL.Text := 'select * from entradas where fecha='+quotedStr(fechabusqueda)+
                    ' and numerohabitacion='+inttostr(Tablas.FDTableEntradasserviciosnumerohabitacion.Value)+
                    ' and cliente=' + quotedstr(Tablas.cliente);
                    Tablas.FDQuery1.Open;
                    if Tablas.FDQuery1.RecordCount > 0 then borrarServicioCliente := true;




                    StatusBar1.SimpleText := 'Anulando servicios...';
                     if (Tablas.FDTableentradasserviciosfecha.Value > fecha1) and (Tablas.FDTableentradasserviciosfecha.Value < fecha2) then
                      begin   //si la fecha est? dentro del periodo de anulaci?n (para la habitaci?n concreta)
                      if ((Tablas.perfil = 'cliente') and (borrarServicioCliente = true)) or (Tablas.perfil = 'admin') then
                          begin
                             Tablas.FDTableentradasservicios.Delete;
                          end else
                          begin
                             Tablas.FDTableentradasservicios.Next;
                          end;

                      end else
                      begin
                        Tablas.FDTableentradasservicios.Next;
                      end;

                  end;

                Tablas.FDTableentradasservicios.Filtered:= false;




          //BORRAR ENTRADAS
          Tablas.FDTableEntradas.First;
           StatusBar1.SimpleText := 'Anulando reservas...';
          //fechaentrada:= DatePicker1.Date;

          while not Tablas.FDTableEntradas.eof do
                begin

                if (Tablas.FDTableEntradasfecha.Value > fecha1) and (Tablas.FDTableEntradasfecha.Value < fecha2) then
                       begin
                        //si es un cliente anulando, solo anula las que estan a su nombre. si es admin, anula todo lo que haya.
                        if ((Tablas.perfil = 'cliente') and (Tablas.FDTableEntradascliente.value = Tablas.cliente)) or (Tablas.perfil = 'admin') then
                          begin
                            Tablas.FDTableHistoricoentradas.Append;  //a?adir al hist?rico
                            Tablas.FDTableHistoricoentradasnumerohabitacion.value := StrToInt(ComboBox1.Items[Combobox1.ItemIndex]);
                            Tablas.FDTableHistoricoentradasfecha.Value := Tablas.FDTableEntradasfecha.Value;
                            Tablas.FDTableHistoricoentradascliente.Value := Tablas.FDTableEntradascliente.Value;
                            Tablas.FDTableHistoricoentradaspreciofinal.Value := Tablas.FDTableEntradaspreciofinal.Value;
                            Tablas.FDTableHistoricoentradasestado.Value := Tablas.FDTableEntradasestado.Value;
                            Tablas.FDTableHistoricoentradas.Post;


                            Tablas.FDTableEntradas.Delete;
                          end else
                          begin
                           Tablas.FDTableEntradas.Next;
                          end;

                       end else
                       begin
                        Tablas.FDTableEntradas.Next;
                       end;


                end;
          {
          //borrar los servicios contratados
          Tablas.FDTableentradasservicios.Filtered:= True;
          Tablas.FDTableentradasservicios.Filter:= 'numerohabitacion='+ComboBox1.Items[Combobox1.ItemIndex];
          Tablas.FDTableentradasservicios.First;
          while not Tablas.FDTableentradasservicios.eof do
            begin

              borrarServicioCliente := false;
              fechabusqueda := Tablas.formatearFechaSQL(Tablas.FDTableEntradasserviciosfecha.Value);

              Tablas.FDQuery1.Close;
              Tablas.FDQuery1.SQL.Text := 'select * from entradas where fecha='+quotedStr(fechabusqueda)+
              ' and numerohabitacion='+inttostr(Tablas.FDTableEntradasserviciosnumerohabitacion.Value)+
              ' and cliente=' + quotedstr(Tablas.cliente);
              Tablas.FDQuery1.Open;
              if Tablas.FDQuery1.RecordCount > 0 then borrarServicioCliente := true;




              StatusBar1.SimpleText := 'Anulando servicios...';
               if (Tablas.FDTableentradasserviciosfecha.Value > fecha1) and (Tablas.FDTableentradasserviciosfecha.Value < fecha2) then
                begin   //si la fecha est? dentro del periodo de anulaci?n (para la habitaci?n concreta)
                if ((Tablas.perfil = 'cliente') and (borrarServicioCliente = true)) or (Tablas.perfil = 'admin') then
                    begin
                       Tablas.FDTableentradasservicios.Delete;
                    end else
                    begin
                       Tablas.FDTableentradasservicios.Next;
                    end;

                end else
                begin
                  Tablas.FDTableentradasservicios.Next;
                end;

            end;

          Tablas.FDTableentradasservicios.Filtered:= false;
           }

          Tablas.FDTableEntradas.Filtered := False;
          StatusBar1.SimpleText := 'Reservas y servicios anulados.';
          if Tablas.perfil = 'cliente' then showmessage('Las reservas del cliente '+Tablas.cliente+' se han anulado.');
          if Tablas.perfil = 'admin' then showmessage('Todas las reservas y ocupaciones del periodo especificado se han anulado');
          registroValido := true;
       end;

   end;

   if registroValido then
    begin
      FormularioPeriodo.Close;  //cerramos y refrescamos todo
      Principal.cargarDia;
    end;


end;



//parecido al formulario diario, creamos los servicios, creamos combo de habitaciones, etc

procedure TFormularioPeriodo.FormActivate(Sender: TObject);
var
i: integer;
cantidadHabitaciones: integer;
servicioCheck: TCheckbox;
begin

    Edit1.ReadOnly := False;
    Edit1.Text:= '';

    StatusBar1.SimpleText := '';
//hay algunos elementos que no hace falta mostrar si estamos en modo de anular reservas
  if ModoDeFormulario = 'reserva' then
    begin
      Label5.Visible := True;
      Scrollbox1.Visible := True;
      Label4.Visible := True;
      Edit1.Visible := True;
    end;
  if ModoDeFormulario = 'anular' then
    begin
      Label5.Visible := False;
      Scrollbox1.Visible := False;
      Label4.Visible := False;
      Edit1.Visible := False;
    end;


 if Tablas.perfil = 'cliente' then
  begin
    Edit1.Text := Tablas.cliente;
    Edit1.ReadOnly := True;
  end;


//COMBO HABITACIONES

  Combobox1 := Tablas.rellenarComboHabitaciones(Combobox1);

   DatePicker1.Date := Now; //resetear el formulario al dia de hoy, sin cliente especificado.
   DatePicker2.Date := Now;



    //SERVICIOS

    //borrar preventivamente los checkbox para que no se repitan
    if Length(CheckboxServicios) > 0 then
      begin
       for i := 0 to Length(CheckboxServicios)-1 do
          begin
          CheckboxServicios[i].Free;
          end;
      end;


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
        servicioCheck.Parent:=Scrollbox1;

        servicioCheck.Tag:=i;
        servicioCheck.Top:=i*20+5;
        servicioCheck.Left:=5;
        servicioCheck.Caption:=nombresServicios[i] + ' ('+FloatToStr(Tablas.FDTableServiciosprecioservicio.Value)+'? al d?a)';
        servicioCheck.Width:= 250;
        PreciosServicios[i] := Tablas.FDTableServiciosprecioservicio.Value;
        CheckboxServicios[i]:= servicioCheck;


        Tablas.FDTableServicios.Next;
        i:=i+1;
       end;


    if ModoDeFormulario = 'anular' then Button1.Caption:= 'Anular';
    if ModoDeFormulario = 'reserva' then Button1.Caption:= 'Reservar';

end;



//altera el prop?sito de este formulario

procedure TFormularioPeriodo.ModoReserva();
begin
  ModoDeFormulario:= 'reserva';
end;

procedure TFormularioPeriodo.ModoAnular();
begin
  ModoDeFormulario:= 'anular';
end;




 //atajo teclado
procedure TFormularioPeriodo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_ESCAPE then
    begin
      FormularioPeriodo.Close;
    end;
end;

end.
