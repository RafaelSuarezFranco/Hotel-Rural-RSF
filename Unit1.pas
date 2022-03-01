unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.DateUtils,
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
    CrearTemporada1: TMenuItem;
    Creartemp1: TMenuItem;
    creartemp: TMenuItem;
    Servicio1: TMenuItem;
    Habitacin1: TMenuItem;
    CalendarView1: TCalendarView;
    Clientes1: TMenuItem;



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
    procedure FormCreate(Sender: TObject);
    procedure administrarpopupClick(Sender: TObject);
    procedure CrearHabitacin1Click(Sender: TObject);
    procedure CrearPanelesHabitaciones();
    procedure creartempClick(Sender: TObject);
    procedure Habitacin1Click(Sender: TObject);
    procedure Servicio1Click(Sender: TObject);
    procedure CalendarView1Change(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);

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
    HabitacionesBD : Array of integer; //contiene los n� de habitaciones
implementation

{$R *.dfm}
 uses  Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10;


procedure TPrincipal.FormActivate(Sender: TObject);
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
LabelHabitacion: TLabel;
i: integer;    //ser� el n� de habitaci�n
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
tipohabitacion: string;

begin
 //apertura de tablas
    Tablas.FDTableHabitaciones.Open;
    Tablas.FDTableEntradas.Open;
    Tablas.FDQuery1.Open;
    Tablas.FDTableTemporadas.Open;
    Tablas.FDTableServicios.Open;
    Tablas.FDTableEntradasservicios.Open;
    Tablas.FDTableClientes.Open;
    Tablas.FDTableHistoricoentradas.Open;

    FechaActual := Now();
    FechaSeleccionada:= Now();
     {
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

        //como tenemos la opci�n de crear habitaciones, en lugar de crear sus paneles en el activate, lo haremos
        // en la funci�n de cargardia,


    //creaci�n de las habitaciones
     i:= 1;
     columna := 1;
     fila := 0;


     SetLength(PanelesHabitaciones, cantidadHabitaciones);
     SetLength(BotonesHabitaciones, cantidadHabitaciones);


    for i:=0 to (cantidadHabitaciones-1) do   //la cantidad de habitaciones se especifica aqu�
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

        PanelHabitacion:=TPanel.create(self);
        PanelHabitacion.Parent:=ScrollBox1;
        PanelHabitacion.Width := 100;
        PanelHabitacion.Height := 150;
        PanelHabitacion.Tag:=HabitacionesBD[i];
        PanelHabitacion.Top:=fila*155+5;
        PanelHabitacion.Left:=columna+5;
        PanelHabitacion.Caption:='Habitaci�n '+Inttostr(HabitacionesBD[i]);
        PanelHabitacion.ParentBackground:=false;
        PanelHabitacion.StyleElements := [seBorder];
        PanelHabitacion.Color:=clGreen;
        PanelHabitacion.PopupMenu:= PopupMenu1;

        BotonHabitacion:=TButton.Create(self);
        BotonHabitacion.Parent:=PanelHabitacion;
        BotonHabitacion.Top:=1;
        BotonHabitacion.Tag:=HabitacionesBD[i];
        BotonHabitacion.Left:=1;
        BotonHabitacion.Width:=98;
        BotonHabitacion.Height:=50;
        BotonHabitacion.Caption:= 'Abrir mes'; //'Habitaci�n'+Inttostr(HabitacionesBD[i]);

        LabelHabitacion:=TLabel.Create(self);
        LabelHabitacion.Parent:=PanelHabitacion;
        LabelHabitacion.Top:=90;
        LabelHabitacion.Caption:= '('+tipohabitacion+')';
        LabelHabitacion.Left:=30;
        LabelHabitacion.StyleElements := [seBorder];
        LabelHabitacion.Font.Color := clblack;

        columna := columna + 105;
        PanelesHabitaciones[i]:= PanelHabitacion; //guardamos los paneles en un array global
        BotonesHabitaciones[i]:=BotonHabitacion;
    end;

    for i := 0 to (Length(BotonesHabitaciones) - 1) do
      begin
         BotonesHabitaciones[i].OnClick := PulsarBotonHabitacion;
      end;

           }
    CrearPanelesHabitaciones();
    CargarDia();
end;

procedure TPrincipal.CrearPanelesHabitaciones();
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
LabelHabitacion: TLabel;
i: integer;    //ser� el n� de habitaci�n
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
tipohabitacion: string;

begin
  //primero borrar los paneles
  if Length(PanelesHabitaciones) > 0 then
      begin
       for i := 0 to Length(PanelesHabitaciones)-1 do
          begin
          PanelesHabitaciones[i].Free;
          end;
      end;

   //a partir de aqui es copiado del activate.
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

        //como tenemos la opci�n de crear habitaciones, en lugar de crear sus paneles en el activate, lo haremos
        // en la funci�n de cargardia,


    //creaci�n de las habitaciones
     i:= 1;
     columna := 1;
     fila := 0;


     SetLength(PanelesHabitaciones, cantidadHabitaciones);
     SetLength(BotonesHabitaciones, cantidadHabitaciones);


    for i:=0 to (cantidadHabitaciones-1) do   //la cantidad de habitaciones se especifica aqu�
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

        PanelHabitacion:=TPanel.create(self);
        PanelHabitacion.Parent:=ScrollBox1;
        PanelHabitacion.Width := 100;
        PanelHabitacion.Height := 150;
        PanelHabitacion.Tag:=HabitacionesBD[i];
        PanelHabitacion.Top:=fila*155+5;
        PanelHabitacion.Left:=columna+5;
        PanelHabitacion.Caption:='Habitaci�n '+Inttostr(HabitacionesBD[i]);
        PanelHabitacion.ParentBackground:=false;
        PanelHabitacion.StyleElements := [seBorder];
        PanelHabitacion.Color:=clGreen;
        PanelHabitacion.PopupMenu:= PopupMenu1;

        BotonHabitacion:=TButton.Create(self);
        BotonHabitacion.Parent:=PanelHabitacion;
        BotonHabitacion.Top:=1;
        BotonHabitacion.Tag:=HabitacionesBD[i];
        BotonHabitacion.Left:=1;
        BotonHabitacion.Width:=98;
        BotonHabitacion.Height:=50;
        BotonHabitacion.Caption:= 'Abrir mes'; //'Habitaci�n'+Inttostr(HabitacionesBD[i]);

        LabelHabitacion:=TLabel.Create(self);
        LabelHabitacion.Parent:=PanelHabitacion;
        LabelHabitacion.Top:=90;
        LabelHabitacion.Caption:= '('+tipohabitacion+')';
        LabelHabitacion.Left:=30;
        LabelHabitacion.StyleElements := [seBorder];
        LabelHabitacion.Font.Color := clblack;

        columna := columna + 105;
        PanelesHabitaciones[i]:= PanelHabitacion; //guardamos los paneles en un array global
        BotonesHabitaciones[i]:=BotonHabitacion;
    end;

    for i := 0 to (Length(BotonesHabitaciones) - 1) do
      begin
         BotonesHabitaciones[i].OnClick := PulsarBotonHabitacion;
      end;



    CargarDia();
end;


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

procedure TPrincipal.FormCreate(Sender: TObject);
begin   {
    //apertura de tablas
    Tablas.FDTableHabitaciones.Open;
    Tablas.FDTableEntradas.Open;
    Tablas.FDQuery1.Open;
    Tablas.FDTableTemporadas.Open;
    Tablas.FDTableServicios.Open;
    Tablas.FDTableEntradasservicios.Open;
    Tablas.FDTableClientes.Open;
    Tablas.FDTableHistoricoentradas.Open;  }
end;

procedure TPrincipal.Habitacin1Click(Sender: TObject);
begin
  NuevaHabitacion.ShowModal;
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
    //si clickamos en el mismo d�a, esto da un error, es como si se deseleccionase el d�a y por
    //tanto la fecha selecionada es igual a 00/00/0000
  end;
end;

procedure TPrincipal.CargarDia();
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
LabelHabitacion: TLabel;
i: integer;    //ser� el n� de habitaci�n
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
tipohabitacion: string;
begin
    Label1.Caption:= 'Fecha seleccionada: '+DateToStr(FechaSeleccionada);
    Label2.Caption:= 'Fecha actual: '+DateToStr(FechaActual);

    DatePicker1.Date:= FechaSeleccionada;
    CalendarView1.Date := FechaSeleccionada;

    ActualizarColores();

end;

procedure TPrincipal.Clientes1Click(Sender: TObject);
begin
   InformeClientes.QuickRep1.Preview;
end;

procedure TPrincipal.CrearHabitacin1Click(Sender: TObject);
var
seleccion: integer;
begin
      seleccion := messagedlg('�Quieres dar de alta una nueva habitaci�n?',mtConfirmation, mbOKCancel, 0);

      if seleccion = mrCancel then
      begin
       //ShowMessage('Acci�n cancelada.');
      end;

       if seleccion = mrOK then
       begin
          NuevaHabitacion.ShowModal;
       end;
    //crear habitaci�n
end;

procedure TPrincipal.PulsarBotonHabitacion(Sender: TObject);
var
boton : TButton;
begin
  boton := TButton(Sender);
  //Showmessage('Has clickado la habitacion'+ IntToStr(boton.Tag));
  HabitacionSeleccionada := boton.Tag;
  PantallaMes.showmodal();
end;

procedure TPrincipal.Servicio1Click(Sender: TObject);
begin
  AltaServicio.showmodal;
end;

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
  FormularioDiario.a�o:= YearOf(FechaSeleccionada);
  FormularioDiario.Habitacion := etiqueta;
  FormularioDiario.showmodal();


end;

procedure TPrincipal.BitBtn1Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, 1); //nos permite navegar al d�a siguente
  CargarDia();
end;

procedure TPrincipal.BitBtn2Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, -1); //nos permite navegar al d�a anterior
  CargarDia();
end;

procedure TPrincipal.creartempClick(Sender: TObject);
begin
   CrearTemporada.showmodal;
end;

procedure TPrincipal.Button1Click(Sender: TObject);
begin
  FechaSeleccionada:= FechaActual;
  CargarDia();
end;

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



procedure TPrincipal.DatePicker1Change(Sender: TObject);
begin
   FechaSeleccionada:= DatePicker1.Date;
   CargarDia();
end;

function TPrincipal.DevolverFechaSeleccionada(): TDate;  //usamos estas funciones para pasar la habitacion y fecha al otro form
begin
    DevolverFechaSeleccionada := FechaSeleccionada;
end;

function TPrincipal.DevolverHabitacionSeleccionada(): Integer;
begin
    DevolverHabitacionSeleccionada := HabitacionSeleccionada;
end;




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
      if Tablas.FDQuery1.Locate('numerohabitacion', HabitacionesBD[i], []) then //si la habitaci�n esta reservada para la fecha seleccionada
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
      if Tablas.FDQuery1.Locate('numerohabitacion', HabitacionesBD[i], []) then //si la habitaci�n esta reservada para la fecha seleccionada
      begin
         PanelesHabitaciones[i].Color:=clRed;
      end;

     end;





end;

end.
