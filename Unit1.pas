unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.DateUtils,    ShellAPI ,
  Vcl.WinXPickers, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.WinXCalendars;

type
  TPrincipal = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DatePicker1: TDatePicker;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    administrarpopup: TMenuItem;
    PopupMenu2: TPopupMenu;
    CrearHabitacin1: TMenuItem;
    MainMenu1: TMainMenu;
    CrearEntidades: TMenuItem;
    Creartemp1: TMenuItem;
    creartemp: TMenuItem;
    Servicio1: TMenuItem;
    Habitacin1: TMenuItem;
    CalendarView1: TCalendarView;
    TodosClientes: TMenuItem;
    Factura1: TMenuItem;
    N1: TMenuItem;
    ItinerariodeServicios1: TMenuItem;
    historialCliente: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Informedinmico1: TMenuItem;
    graficos: TMenuItem;
    IngresosReservas1: TMenuItem;
    IngresosServicios1: TMenuItem;
    Usuario1: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button4: TButton;
    Label8: TLabel;
    Label9: TLabel;
    EditarEntidades: TMenuItem;
    Habitacin2: TMenuItem;
    Servicio2: TMenuItem;
    emporada1: TMenuItem;
    Usuario2: TMenuItem;



    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CargarDia();
    procedure PulsarBotonHabitacion(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DatePicker1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActualizarColores();
    function DevolverFechaSeleccionada():TDate;
    function DevolverHabitacionSeleccionada():Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure administrarpopupClick(Sender: TObject);
    procedure CrearHabitacin1Click(Sender: TObject);
    procedure CrearPanelesHabitaciones();
    procedure creartempClick(Sender: TObject);
    procedure Habitacin1Click(Sender: TObject);
    procedure Servicio1Click(Sender: TObject);
    procedure CalendarView1Change(Sender: TObject);
    procedure TodosClientesClick(Sender: TObject);
    procedure Factura1Click(Sender: TObject);
    procedure ItinerariodeServicios1Click(Sender: TObject);
    procedure historialClienteClick(Sender: TObject);
    procedure Informedinmico1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IngresosReservas1Click(Sender: TObject);
    procedure IngresosServicios1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditarEntidadesClick(Sender: TObject);
    procedure Habitacin2Click(Sender: TObject);
    procedure Servicio2Click(Sender: TObject);
    procedure emporada1Click(Sender: TObject);
    procedure Usuario2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  var
    Principal: TPrincipal;
    FechaActual: TDate;
    FechaSeleccionada: TDate;
    //arLbl : Array[1..8] of TLabel;
    PanelesHabitaciones : Array of TPanel;
    BotonesHabitaciones : Array of TButton;
    HabitacionSeleccionada: integer;
    HabitacionesBD : Array of integer; //contiene los n? de habitaciones

    login1 : boolean;  //controlar si se ha producido un login
implementation

{$R *.dfm}
 uses
  Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11, Unit12, Unit13, Unit14, Unit16, Unit17, Unit18, Unit19;





//procedimientos del men? superior



//CREAR HABITACION, ETC
procedure TPrincipal.Habitacin1Click(Sender: TObject);
begin
  AltaHabitacion.modo := 'crear';
  AltaHabitacion.ShowModal;
end;

  procedure TPrincipal.creartempClick(Sender: TObject);
begin
   AltaTemporada.showmodal;
end;

procedure TPrincipal.Servicio1Click(Sender: TObject);
begin
  AltaServicio.modo := 'crear';
  AltaServicio.showmodal;
end;


procedure TPrincipal.Usuario1Click(Sender: TObject);
begin
  AltaUsuario.permisos := 'admin';
  AltaUsuario.showmodal;
end;






//INFORMES
procedure TPrincipal.Factura1Click(Sender: TObject);
begin
  FacturaParametros.showmodal;
end;


procedure TPrincipal.historialClienteClick(Sender: TObject);
var
idcliente: string;
nombre: string;
apellido: string;
stringcliente: string;
  begin
  //la idea es reutilizar factura, para ello vamos a cambiar la consulta 'fdquery2' para filtrar por cliente
     if Tablas.perfil = 'admin' then
      begin
        idcliente := inputbox('ID cliente', 'Introduzca el ID del cliente', '');
      end;
     if Tablas.perfil = 'cliente' then      //si un cliente esta logeado, solo puede ver su propio historial.
      begin
        idcliente := Tablas.cliente;
      end;


     if idcliente <> '' then
     begin

       if Tablas.FDTableClientes.Locate('identificador', idcliente, []) then
          begin
            nombre:= Tablas.FDTableClientesnombre.Value;
            apellido:= Tablas.FDTableClientesapellidos.Value;
            stringcliente := nombre + ' '+ apellido;

            Factura.imprimirCliente(stringcliente);

             Tablas.FDQuery2.close;
             Tablas.FDQuery2.SQL.Text := 'select numerohabitacion as numero, fecha as fechaentrada, estado, cliente, preciofinal from entradas where cliente = '
             + quotedstr(idcliente) + ' order by fecha';
             Tablas.FDQuery2.open;

             //ho haremos m?s filtros, mostramos cualquier fecha, cualquier habitaci?n y cualquier estado.
             Factura.quickreport1.Preview;

          end else
          begin
            showmessage('El ID introducido no coincide con el de ning?n cliente existente');
          end;

     end;




end;

procedure TPrincipal.Informedinmico1Click(Sender: TObject);
begin
  InformeDinamicoGenerador.ShowModal;
end;



procedure TPrincipal.ItinerariodeServicios1Click(Sender: TObject);
begin

  ItinerarioServicios.fecha := FechaSeleccionada;
  ItinerarioServicios.imprimirFechas(FechaSeleccionada);
  ItinerarioServicios.quickreport1.Preview;
end;




procedure TPrincipal.TodosClientesClick(Sender: TObject);
begin
  Tablas.FDTableClientes.IndexFieldNames := 'apellidos';
  InformeClientes.QuickRep1.Preview;
end;


//GRAFICOS

 procedure TPrincipal.IngresosReservas1Click(Sender: TObject);
begin
   GraficosReservas.ShowModal;
end;


procedure TPrincipal.IngresosServicios1Click(Sender: TObject);
begin
   GraficosServicios.ShowModal;
end;




//EDITAR HABITACIONES, ETC

procedure TPrincipal.Habitacin2Click(Sender: TObject);
var
 numero: string;
begin
    numero := inputbox('N? Habitaci?n', 'Introduzca el n?mero de la habitaci?n a editar', '');
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from habitaciones where numero='+numero;
    Tablas.FDQuery1.Open;

    if Tablas.FDQuery1.RecordCount = 1 then
    begin
      AltaHabitacion.modo := 'editar';
      AltaHabitacion.habitacionEdit := numero;
      AltaHabitacion.ShowModal;
    end
    else showmessage('No existe una habitaci?n con ese n?mero.');

end;

procedure TPrincipal.Servicio2Click(Sender: TObject);
var
nombre: string;
begin
    nombre := inputbox('Nombre de servicio', 'Introduzca el nombre del servicio a editar', '');
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from servicios where nombreservicio='+quotedstr(nombre);
    Tablas.FDQuery1.Open;

if Tablas.FDQuery1.RecordCount = 1 then
    begin
      AltaServicio.modo := 'editar';
      AltaServicio.servicioEdit := nombre;
      AltaServicio.precioEdit := Tablas.FDQuery1.FieldByName('precioservicio').Value;
      AltaServicio.showmodal;
    end
    else showmessage('No existe un servicio con ese nombre.');


end;


procedure TPrincipal.emporada1Click(Sender: TObject);
var
fecha: Tdate;
begin
  try
    fecha := strToDate(inputbox('Fecha de temporada', 'Introduzca una fecha para borrar la temporada a la que pertenece', '01/01/2000'));


     Tablas.FDQuery1.Close;
      Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedstr(Tablas.formatearFechaSQL(fecha))+
            ' and fechafin>='+quotedstr(Tablas.formatearFechaSQL(fecha));
      Tablas.FDQuery1.Open;

      if fecha <> strToDate('01/01/2000') then
        begin
         if Tablas.FDTableTemporadas.Locate('fechainicio', Tablas.FDQuery1.FieldByName('fechainicio').Value,[]) then
         begin
             Tablas.FDTableTemporadas.Delete;
             showmessage('Se ha borrado la temporada a la que pertenece la fecha indicada.');
         end else
         begin
          showmessage('No se ha encontrado una temporada para le fecha indicada');
         end;

        end;

  except
    showmessage('Formato de fecha incorrecto.');
  end;

end;

procedure TPrincipal.Usuario2Click(Sender: TObject);
var
dni: string;
nombre: string;
apellidos: string;
begin
  dni := inputbox('Identificador de cliente', 'Introduzca el ID del cliente a editar', '');
  if Tablas.FDTableClientes.Locate('identificador', dni, []) then
    begin
       nombre := inputbox('Nombre', 'Nuevo nombre', Tablas.FDTableClientesnombre.Value);
       apellidos := inputbox('Apellidos', 'Nuevos apellidos', Tablas.FDTableClientesapellidos.Value);

       Tablas.FDTableClientes.Edit;
       Tablas.FDTableClientesnombre.Value := nombre;
       Tablas.FDTableClientesapellidos.Value:= apellidos;
       Tablas.FDTableClientes.Post;

       showmessage('Se ha editado el cliente.');
    end else
    begin
      showmessage('No se ha encontrado un cliente con el ID especificado.');
    end;
end;







procedure TPrincipal.FormCreate(Sender: TObject);
begin
   login1 := false;
end;


//abrimos las tablas e inicializamos las fechas, creamos los paneles y los coloreamos

procedure TPrincipal.FormActivate(Sender: TObject);
begin

  Tablas.passwordcorreo := '7ABBAA0B9ADCBFC92EDAAB4B75B2E7CA';

    if login1 = false then
      begin
        //para ense?ar el login primero de todo, lo mostramos con showmodal mientras se activa el principal. Hay que meterlo en esta
        //condicion porque al cerrar algunas ventanas de informes,se reactiva el principal y por tanto se muestra el login otra vez.
         Login.ShowModal;
         login1 := true;
      end;




 //apertura de tablas
    Tablas.FDTableHabitaciones.Open;
    Tablas.FDTableEntradas.Open;
    Tablas.FDQuery1.Open;
    Tablas.FDTableTemporadas.Open;
    Tablas.FDTableServicios.Open;
    Tablas.FDTableEntradasservicios.Open;
    Tablas.FDTableClientes.Open;
    Tablas.FDTableHistoricoentradas.Open;
    Tablas.FDTableUsuarios.Open;

    Tablas.FDQuery2.Open;
    Tablas.FDQuery3.Open;
    Tablas.FDQuery4.Open;
    Tablas.FDQuery5.Open;
    Tablas.FDQuery6.Open;
    Tablas.FDQuery7.Open;
    Tablas.FDQuery8.Open;

    FechaActual := Now();
    FechaSeleccionada:= Now();

    CrearPanelesHabitaciones();
    CargarDia();

    Label6.Caption := Tablas.usuario;
    Label7.Caption := Tablas.perfil;
    Label9.Caption := Tablas.cliente;

    //escondemos o mostramos el menu en funci?n del perfil.
    if Tablas.perfil = 'cliente' then
      begin
        CrearEntidades.Visible := false;
        graficos.Visible := false;
        ItinerariodeServicios1.Visible := false;
        TodosClientes.Visible :=false;
        Informedinmico1.Visible :=false;
        EditarEntidades.Visible := false;
      end;

    if Tablas.perfil = 'admin' then
      begin
        CrearEntidades.Visible := true;
        graficos.Visible := true;
        ItinerariodeServicios1.Visible := true;
        TodosClientes.Visible :=true;
        Informedinmico1.Visible := true;
        EditarEntidades.Visible := true;
      end;
end;


//crea los paneles de las habitaciones. se llama desde el activate y tras crear una habitaci?n nueva

procedure TPrincipal.CrearPanelesHabitaciones();
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
LabelHabitacion: TLabel;
i: integer;    //ser? el n? de habitaci?n
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
tipohabitacion: string;

begin
  //primero borrar los paneles, vaciar el array.
  if Length(PanelesHabitaciones) > 0 then
      begin
       for i := 0 to Length(PanelesHabitaciones)-1 do
          begin
          PanelesHabitaciones[i].Free;
          end;
      end;

   //guardar los n? de habitaciones
    i:=0;
    cantidadHabitaciones:= Tablas.FDTableHabitaciones.RecordCount;  //esta variable recogera la cantidad de habitaciones de la bbdd
    SetLength(HabitacionesBD, cantidadHabitaciones);

    Tablas.FDTableHabitaciones.First;
      while not  Tablas.FDTableHabitaciones.Eof do //guardamos los numero de habitacion para ponerselo a los paneles y botones
        begin
          HabitacionesBD[i]:= Tablas.FDTableHabitacionesnumero.Value;
          i:=i+1;
          Tablas.FDTableHabitaciones.Next;
        end;


    //creaci?n de las habitaciones
     i:= 1;
     columna := 1;
     fila := 0;


     SetLength(PanelesHabitaciones, cantidadHabitaciones);
     SetLength(BotonesHabitaciones, cantidadHabitaciones);


    for i:=0 to (cantidadHabitaciones-1) do   //la cantidad de habitaciones se especifica aqu?
     begin
      if (i mod 5 = 0) and (i <> 0) then
        begin
          fila:= fila + 1;
          columna:= 1 ;
        end;

        Tablas.FDQuery1.Close;
        Tablas.FDQuery1.SQL.Text := 'select * from habitaciones where numero='+Inttostr(HabitacionesBD[i]);
        Tablas.FDQuery1.Open;
        tipohabitacion:= Tablas.FDQuery1.FieldByName('tipo').AsString;

        //crear paneles
        PanelHabitacion:=TPanel.create(self);
        PanelHabitacion.Parent:=ScrollBox1;
        PanelHabitacion.Width := 100;
        PanelHabitacion.Height := 150;
        PanelHabitacion.Tag:=HabitacionesBD[i];
        PanelHabitacion.Top:=fila*155+5;
        PanelHabitacion.Left:=columna+5;
        PanelHabitacion.Caption:='Habitaci?n '+Inttostr(HabitacionesBD[i]);
        PanelHabitacion.ParentBackground:=false;
        PanelHabitacion.StyleElements := [seBorder];
        PanelHabitacion.Color:=clGreen;
        PanelHabitacion.PopupMenu:= PopupMenu1;

        //crear botones
        BotonHabitacion:=TButton.Create(self);
        BotonHabitacion.Parent:=PanelHabitacion;
        BotonHabitacion.Top:=1;
        BotonHabitacion.Tag:=HabitacionesBD[i];
        BotonHabitacion.Left:=1;
        BotonHabitacion.Width:=98;
        BotonHabitacion.Height:=50;
        BotonHabitacion.Caption:= 'Abrir mes'; //'Habitaci?n'+Inttostr(HabitacionesBD[i]);

        //crear etiquetas
        LabelHabitacion:=TLabel.Create(self);
        LabelHabitacion.Parent:=PanelHabitacion;
        LabelHabitacion.Top:=90;
        LabelHabitacion.Caption:= '('+tipohabitacion+')';
        LabelHabitacion.Left:=30;
        LabelHabitacion.StyleElements := [seBorder];
        LabelHabitacion.Font.Color := clblack;

        columna := columna + 105;
        //guardamos los paneles y botones en un arrays globales
        PanelesHabitaciones[i]:= PanelHabitacion;
        BotonesHabitaciones[i]:=BotonHabitacion;
    end;


    //cada bot?n abrir? la pantalla mes con la habitaci?n seleccionada
    for i := 0 to (Length(BotonesHabitaciones) - 1) do
      begin
         BotonesHabitaciones[i].OnClick := PulsarBotonHabitacion;
      end;

    CargarDia();  //coloreamos los paneles.
end;


//cierre al salir, se?or?a.

procedure TPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Tablas.FDTableHabitaciones.Close;
    Tablas.FDTableEntradas.Close;
    Tablas.FDQuery1.Close;
    Tablas.FDTableTemporadas.Close;
    Tablas.FDTableServicios.Close;
    Tablas.FDTableEntradasservicios.Close;
    Tablas.FDTableClientes.Close;
    Tablas.FDTableHistoricoentradas.Close;
end;







procedure TPrincipal.CalendarView1Change(Sender: TObject);
var
fecharespaldo: TDate;
begin
  fecharespaldo :=  FechaSeleccionada;
  try
    FechaSeleccionada:= CalendarView1.Date;
    CargarDia();
  except
    FechaSeleccionada:= fecharespaldo;
    CargarDia();
    //si clickamos en el mismo d?a, esto da un error, es como si se deseleccionase el d?a y por
    //tanto la fecha selecionada es igual a 00/00/0000
  end;
end;




//popup de creaci?n de habitaciones

procedure TPrincipal.CrearHabitacin1Click(Sender: TObject);
var
seleccion: integer;
begin
    seleccion := messagedlg('?Quieres dar de alta una nueva habitaci?n?',mtConfirmation, mbOKCancel, 0);

       if seleccion = mrOK then
       begin
          AltaHabitacion.ShowModal;
       end;
    //crear habitaci?n
end;


//popup que permite abrir el FormularioDiario desde la pantalla principal

procedure TPrincipal.administrarpopupClick(Sender: TObject); //popup para abrir formulario de reserva de un dia concreto
var Caller: TObject;
var i: integer;
var j: integer;
var etiqueta: integer;
var dia: integer;
begin

    Caller := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
    //label1.Caption:=(Caller as Tpanel).name + ' ' +inttostr((Caller as Tpanel).tag);
    etiqueta := (Caller as Tpanel).tag;
    dia := DayOfTheMonth(FechaSeleccionada);

  FormularioDiario.dia:= dia;
  FormularioDiario.mes:= MonthOfTheYear(FechaSeleccionada);
  FormularioDiario.a?o:= YearOf(FechaSeleccionada);
  FormularioDiario.Habitacion := etiqueta;
  FormularioDiario.origen := 'principal';
  FormularioDiario.showmodal();


end;



//al pulsar el bot?n que abre la pantalla de mes, guardamos la habitaci?n seleccionada y abrimos dicha pantalla,

procedure TPrincipal.PulsarBotonHabitacion(Sender: TObject);
var
boton : TButton;
begin
  boton := TButton(Sender);
  //Showmessage('Has clickado la habitacion'+ IntToStr(boton.Tag));
  HabitacionSeleccionada := boton.Tag;
  PantallaMes.showmodal();
end;



//todas estas funciones sirven para navegar entre fechas con los distintos componentes.
//todas ellas deben actualizar la pantalla principal.

procedure TPrincipal.BitBtn1Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, 1); //nos permite navegar al d?a siguente
  CargarDia();
end;

procedure TPrincipal.BitBtn2Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, -1); //nos permite navegar al d?a anterior
  CargarDia();
end;



procedure TPrincipal.Button1Click(Sender: TObject);
begin
  FechaSeleccionada:= FechaActual;
  CargarDia();
end;

procedure TPrincipal.DatePicker1Change(Sender: TObject);
begin
   FechaSeleccionada:= DatePicker1.Date;
   CargarDia();
end;


//abren el formulario de periodo, ya sea para reservar o para anular reservas

procedure TPrincipal.Button2Click(Sender: TObject);
begin
  FormularioPeriodo.ModoReserva;
  FormularioPeriodo.showmodal;
end;

procedure TPrincipal.Button3Click(Sender: TObject);
begin
  FormularioPeriodo.ModoAnular;
  FormularioPeriodo.showmodal;
end;

 //b?sicamente, reinicia la aplicaci?n.
procedure TPrincipal.Button4Click(Sender: TObject);
begin
  ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
  Application.Terminate; // or, if this is the main form, simply Close;
end;




//usamos estas funciones para pasar la habitacion y fecha al otro form (pantalla mes)

function TPrincipal.DevolverFechaSeleccionada(): TDate;
begin
    DevolverFechaSeleccionada := FechaSeleccionada;
end;

function TPrincipal.DevolverHabitacionSeleccionada(): Integer;
begin
    DevolverHabitacionSeleccionada := HabitacionSeleccionada;
end;


procedure TPrincipal.EditarEntidadesClick(Sender: TObject);
begin

end;


//se encarga tanto de actualizar la fecha seleccionada y mostrada en los componentes como de de colorear
//los paneles seg?n las reservas/ocupaciones (de colorear se encarga otra funci?n a parte).

procedure TPrincipal.CargarDia();
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
LabelHabitacion: TLabel;
i: integer;    //ser? el n? de habitaci?n
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
tipohabitacion: string;
begin
    //Label1.Caption:= 'Fecha seleccionada: '+DateToStr(FechaSeleccionada);
    Label2.Caption:= 'Fecha actual: '+DateToStr(FechaActual);

    DatePicker1.Date:= FechaSeleccionada;
    CalendarView1.Date := FechaSeleccionada;

    ActualizarColores();

end;


//se encarga de colorear los paneles

procedure TPrincipal.ActualizarColores();
var
i: integer;
fecha: TDate;
stringFecha: String;
begin
   i:=0;
   fecha:=FechaSeleccionada;
   stringFecha := IntToStr(YearOf(fecha))+'-'+IntToStr(MonthOfTheYear(fecha))+'-'+IntToStr(DayOfTheMonth(fecha));//hay que formatear la fecha

    //ponemos todos en verde (habitaciones libres)
    for i := 0 to Length(PanelesHabitaciones)-1 do
    begin
      PanelesHabitaciones[i].Color:=clWebLawnGreen;
    end;


    // COLOREAR RESERVAS
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from entradas where estado='+quotedstr('reservada')+' and fecha='+quotedStr(stringFecha);
    Tablas.FDQuery1.Open;

   for i := 0 to Length(HabitacionesBD)-1 do
     begin
      if Tablas.FDQuery1.Locate('numerohabitacion', HabitacionesBD[i], []) then //si la habitaci?n esta reservada para la fecha seleccionada
       begin
         PanelesHabitaciones[i].Color:=clYellow;
       end;

     end;

     //COLOREAR OCUPACIONES
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from entradas where estado='+quotedstr('ocupada')+' and fecha='+quotedStr(stringFecha);
    Tablas.FDQuery1.Open;

   for i := 0 to Length(HabitacionesBD)-1 do
     begin
      if Tablas.FDQuery1.Locate('numerohabitacion', HabitacionesBD[i], []) then //si la habitaci?n esta reservada para la fecha seleccionada
      begin
         PanelesHabitaciones[i].Color:=clRed;
      end;

     end;



end;


 // atajos de teclado
 //nota: hay que poner Principal.keyPreview := true; para que funcionen las teclas en principal

procedure TPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
seleccion : integer;
begin
  if Key = VK_ESCAPE then
    begin
       seleccion := messagedlg('?Salir de la aplicaci?n?',mtConfirmation, mbOKCancel, 0);

       if seleccion = mrOK then
       begin
          Principal.Close;
       end;
    end;

  if Key = VK_UP then    // flecha arriba -> volver al primer d?a
    begin
      FechaSeleccionada := Now();
      cargarDia();
    end;
end;


procedure TPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_LEFT then     //flecha izquierda -> dia anterior
    begin
      FechaSeleccionada := IncDay(Fechaseleccionada, -1);
      cargarDia();
    end;
  if Key = VK_RIGHT then   //flecha derecha -> d?a siguiente
    begin
      FechaSeleccionada := IncDay(Fechaseleccionada, 1);
      cargarDia();
    end;
end;





end.
