unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.DateUtils,
  Vcl.Buttons, Vcl.WinXPickers, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.WinXCalendars, Vcl.ComCtrls;

type
  TPantallaMes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    DatePicker1: TDatePicker;
    ComboBox1: TComboBox;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
    function DevolverDiasMes(): integer;
    function DevolverDiaSemana(): integer;
    procedure BitBtn1Click(Sender: TObject);
    procedure cargarMes();
    procedure BitBtn2Click(Sender: TObject);
    procedure ActualizarColores2();
    procedure DatePicker1Change(Sender: TObject);
    procedure PulsarBotonDia(Sender: TObject);
    function DevolverFechaSeleccionada1():TDate;
    function DevolverDiaSeleccionado():Integer;
    function DevolverHabitacionSeleccionada1():Integer;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
    BotonesDia: Array of TButton;
  end;

var
  PantallaMes: TPantallaMes;
  FechaSeleccionada1: TDate;
  diaSeleccionado: integer;
  HabitacionSeleccionada1: integer;
  PanelesDia: Array of TPanel;
  //BotonesDia: Array of TButton;
  HabitacionesTodas: Array of Integer; //contiene los n? de habitaciones
  indiceHabitacion: integer;

implementation

{$R *.dfm}
 uses Unit1, Unit3, Unit4;


 //recoge la fecha y la habitaci?n seleccionada
 //crea un combobox con las habitaciones para poder cambiar de habitaci?n sin salir de la pantalla.

procedure TPantallaMes.FormActivate(Sender: TObject);
var
i: integer;
cantidadHabitaciones : integer;
begin
  FechaSeleccionada1:= Principal.DevolverFechaSeleccionada;
  HabitacionSeleccionada1:= Principal.DevolverHabitacionSeleccionada;
  Label1.Caption:= 'Fecha seleccionada: '+ DateToStr(FechaSeleccionada1);
  Label2.Caption:= 'Habitaci?n seleccionada: '+ IntToStr(HabitacionSeleccionada1);

    CargarMes();

//COMBO HABITACIONES
 // en este caso no vamos a llamar al generador de combos de Tablas porque queremos que al crearse se seleccione una habitaci?n
 //concreta (aunque podr?amos crearlo y luego seleccionarlo aqu? haciendo otra b?squeda)
  ComboBox1.Style := csDropDownList;
   i:=0;
    cantidadHabitaciones:= Tablas.FDTableHabitaciones.RecordCount;
    SetLength(Habitacionestodas, cantidadHabitaciones);
    Combobox1.Items.Clear;
    Tablas.FDTableHabitaciones.First;
      while not  Tablas.FDTableHabitaciones.Eof do
        begin
          Habitacionestodas[i]:= Tablas.FDTableHabitacionesnumero.Value;
          Combobox1.Items.Add(IntToStr(Tablas.FDTableHabitacionesnumero.Value));
          if HabitacionSeleccionada1 = Tablas.FDTableHabitacionesnumero.Value then
            begin
              Combobox1.ItemIndex := i; //seleccionamos el de la habitaci?n actual
            end;

          i:=i+1;
          Tablas.FDTableHabitaciones.Next;
        end;


end;



// para construir el calendario, debemos conseguir varios datos de la fecha (o el mes) en el que estamos,
//en primer lugar: su cantidad de d?as

function TPantallaMes.DevolverDiasMes(): Integer;
var
mes: integer;
mesnum: integer;
a?onum: integer;
  begin
    mesnum:=MonthOfTheYear(FechaSeleccionada1);
    a?onum:=YearOf(FechaSeleccionada1);

    mes:= DaysInAMonth(a?onum, mesnum); //devuelve la cantidad de d?as de cierto mes.

    DevolverDiasMes := mes;
  end;


//en segundo lugar, qu? d?a de la semana empieza el d?a 1.

function TPantallaMes.DevolverDiaSemana(): Integer;
var
dia: integer;
mesnum: integer;
a?onum: integer;
begin
    mesnum:=MonthOfTheYear(FechaSeleccionada1);
    a?onum:=YearOf(FechaSeleccionada1);
    dia:= DayOfTheWeek(EncodeDate(a?onum, mesnum, 1));
    //devuelve el ?ndice del d?a de semana (1 = lunes) del primer dia de mes
    //nos sirve para posicionar el primer dia en el calendario.
    DevolverDiaSemana := dia;
end;


//navegar entre fechas, igual que en la pantalla principal

procedure TPantallaMes.BitBtn1Click(Sender: TObject);
begin
  FechaSeleccionada1:= IncMonth(FechaSeleccionada1, -1);
  CargarMes();
end;


procedure TPantallaMes.BitBtn2Click(Sender: TObject);
begin
  FechaSeleccionada1:= IncMonth(FechaSeleccionada1, 1);
  CargarMes();
end;


procedure TPantallaMes.DatePicker1Change(Sender: TObject);
begin
  FechaSeleccionada1:= DatePicker1.Date;
  CargarMes();
end;


//se encarga de borrar y crear los paneles del mes, de manera que queden ordenados y colocados como si se
//tratase de un calendario real

procedure TPantallaMes.CargarMes();
var
PanelDia: TPanel;
BotonDia: TButton;
i: integer;    //cantidad de dias
fila: integer;
cantidadDias: integer;
diasemana: integer;
dia: integer;

begin
  //esconder el panel y mostrarlo cuando termina de cargar parece que a?ade bastante velocidad de carga.
  panel1.visible := false;


      Label1.Caption:= 'Fecha seleccionada: '+ DateToStr(FechaSeleccionada1);

      //primero borrar el calendario

  if Length(PanelesDia) > 0 then
      begin
       for i := 0 to Length(PanelesDia)-1 do
          begin
              PanelesDia[i].Free;
          end;
      end;


    //creaci?n de los d?as (paneles)
     dia:=1;
     i:= 1;
     fila := 0;
     diasemana:= DevolverDiaSemana - 1; //nos interesa que el lunes sea 0

     cantidadDias:= DevolverDiasMes();
     SetLength(PanelesDia, cantidadDias);
     SetLength(BotonesDia, cantidadDias);


    for i:= 0 to (cantidadDias-1) do   //la cantidad de dias se especifica aqu?
     begin
      if (diasemana mod 7 = 0) and (i <> 0) then
        begin
          fila:= fila + 1;
          diasemana := diasemana - 7;
        end;

        PanelDia:=TPanel.create(self);
        PanelDia.Parent:=Panel1;
        PanelDia.Width := 100;
        PanelDia.Height := 100;
        PanelDia.Tag:=dia;
        PanelDia.Top:=fila*100;
        PanelDia.Left:=diasemana*100;
        PanelDia.Caption:='D?a '+Inttostr(dia);
        PanelDia.ParentBackground:= false;
        PanelDia.StyleElements := [seBorder]; // esta l?nea hace que tarden en cargar bastante m?s.
        if DayOfTheMonth(FechaSeleccionada) = dia then
          begin
            PanelDia.Font.Style := [fsBold];
          end;
       {
        BotonDia:=TButton.Create(self);
        BotonDia.Parent:=PanelDia;
        BotonDia.Top:=1;
        BotonDia.Tag:=dia;
        BotonDia.Left:=1;
        BotonDia.Width:=98;
        BotonDia.Height:=40;
        BotonDia.Caption:='D?a '+Inttostr(dia);
         }
         //para no sobrecargar mucho esta pantalla, mejor quitar los botones y ponerle el click a los paneles



        dia := dia + 1;
        diasemana:= diasemana +1;
        PanelesDia[i]:= PanelDia; //guardamos los paneles en un array global
        //BotonesDia[i]:=BotonDia;
    end;

    //en este caso, cada panel abre el formulario de administraci?n de un d?a concreto
      for i := 0 to (Length(PanelesDia) - 1) do
      begin
         //BotonesDia[i].OnClick := PulsarBotonDia;
         PanelesDia[i].OnClick := PulsarBotonDia;
      end;
     ActualizarColores2();
     DatePicker1.Date := FechaSeleccionada1;


   panel1.visible := true;
end;


//permite cambiar la habitaci?n seleccionada.

procedure TPantallaMes.ComboBox1Change(Sender: TObject);
begin
  HabitacionSeleccionada1:= HabitacionesTodas[Combobox1.ItemIndex];
  Label2.Caption:= 'Habitaci?n seleccionada: '+ IntToStr(HabitacionSeleccionada1);
  CargarMes;
end;


//click en el panel, abre el formulario diario

procedure TPantallaMes.PulsarBotonDia(Sender: TObject);
var
panel : TPanel;
boton : TButton;
begin
  panel := TPanel(Sender);
  diaSeleccionado := panel.Tag;

  //boton := TButton(Sender);
  //Showmessage('Has clickado el d?a'+ IntToStr(boton.Tag));
  //diaSeleccionado := boton.Tag;

  //cambio de planes, para poder usar el formulario diario desde le pantalla mes y la pantalla principal,
  // he hecho que algunas de sus variables sean p?blicas, para poder asignarlas desde el origen.
  // El resultado es el mismo dado que a partir de dichas variables,
  //se hacen consultas para inferir el resto de variables necesarias en dicho formulario.

  FormularioDiario.dia:= diaSeleccionado;
  FormularioDiario.mes:= MonthOfTheYear(FechaSeleccionada1);
  FormularioDiario.a?o:= YearOf(FechaSeleccionada1);
  FormularioDiario.Habitacion := HabitacionSeleccionada1;
  FormularioDiario.origen := 'pantallames';
  FormularioDiario.showmodal();
end;



//pinta los paneles seg?n las reservas, ocupaciones y temporadas

procedure TPantallaMes.ActualizarColores2();
var
i: integer;
fecha: TDate;
stringFecha: String;
mes: String;
dia: String;
begin
   i:=0;
   fecha:=FechaSeleccionada1;

   mes:= IntToStr(MonthOfTheYear(fecha));
   if length(mes) < 2 then  //hay que formatear dias y meses para que tengan 2 d?gitos
    mes:= '0'+ mes;

   //construimos el a?o y mes, pero el dia se lo vamos pasando uno a uno
   stringFecha := IntToStr(YearOf(fecha))+'-'+mes+'-';//+IntToStr(DayOfTheMonth(fecha));

    //ponemos todos en verde (habitaciones libres)
    for i := 0 to Length(PanelesDia)-1 do
    begin
      PanelesDia[i].Color:=clWebLawnGreen;
    end;




    //COLOREAR TEMPORADAS

   for i := 0 to Length(PanelesDia)-1 do
     begin
      dia:= IntToStr(i+1);
        if length(dia) < 2 then
          dia:= '0'+ dia;

      //buscamos si la fecha se encuentra entre la fecha inicio y la fecha fin de alg?n registro
      Tablas.FDQuery1.Close;
      Tablas.FDQuery1.SQL.Text := 'select * from temporadas where fechainicio<='+quotedStr(stringFecha+dia)+' and fechafin>='+quotedStr(stringFecha+dia);
      Tablas.FDQuery1.Open;

     if Tablas.FDQuery1.Locate('nombretemporada', 'media', []) then
      begin
         PanelesDia[i].Color:=clWebLimeGreen;
      end;

     if Tablas.FDQuery1.Locate('nombretemporada', 'alta', []) then
      begin
         PanelesDia[i].Color:=clWebForestGreen;
      end;


     end;


    // COLOREAR RESERVAS
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from entradas where estado='+quotedstr('reservada')+' and numerohabitacion='+quotedStr(IntToStr(HabitacionSeleccionada1));
    Tablas.FDQuery1.Open;
    //Label4.Caption:=  quotedStr(stringFecha+'01');

   for i := 0 to Length(PanelesDia)-1 do
     begin
        dia:= IntToStr(i+1); //hay que formatear dias y meses para que tengan 2 d?gitos
        if length(dia) < 2 then
         dia:= '0'+ dia;

      if Tablas.FDQuery1.Locate('fecha', stringFecha+dia, []) then //recorremos cada dia del mes para la habitacion seleccionada
       begin
         PanelesDia[i].Color:=clYellow;
       end;

     end;

     //COLOREAR OCUPACIONES
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from entradas where estado='+quotedstr('ocupada')+' and numerohabitacion='+quotedStr(IntToStr(HabitacionSeleccionada1));
    Tablas.FDQuery1.Open;


   for i := 0 to Length(PanelesDia)-1 do
     begin
      dia:= IntToStr(i+1);
        if length(dia) < 2 then
          dia:= '0'+ dia;

      if Tablas.FDQuery1.Locate('fecha', stringFecha+dia, []) then //si la habitaci?n esta ocupada para la habitacion seleccionada
      begin
         PanelesDia[i].Color:=clRed;
      end;

     end;




end;



//probablemente estas funciones no las necesito.

function TPantallaMes.DevolverFechaSeleccionada1(): TDate;
begin
    DevolverFechaSeleccionada1 := FechaSeleccionada1;
end;

function TPantallaMes.DevolverDiaSeleccionado(): Integer;
begin
    DevolverDiaSeleccionado := diaSeleccionado;
end;

function TPantallaMes.DevolverHabitacionSeleccionada1(): Integer;
begin
    DevolverHabitacionSeleccionada1 := HabitacionSeleccionada1;
end;




 // atajos de teclado
 //nota: hay que poner Principal.keyPreview := true; para que funcionen las teclas en principal

procedure TPantallaMes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    begin
      Pantallames.Close;
    end;

  if Key = VK_UP then    // flecha arriba -> volver a la fecha actual
    begin
      FechaSeleccionada1 := Now();
      cargarMes();
    end;
end;


procedure TPantallaMes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_LEFT then     //flecha izquierda -> mes anterior
    begin
      FechaSeleccionada1 := IncMonth(Fechaseleccionada1, -1);
      cargarMes();
    end;
  if Key = VK_RIGHT then   //flecha derecha -> mes siguiente
    begin
      FechaSeleccionada1 := IncMonth(Fechaseleccionada1, 1);
      cargarMes();
    end;

end;

end.
