unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.DateUtils,
  Vcl.Buttons, Vcl.WinXPickers;

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
    procedure FormActivate(Sender: TObject);
    function DevolverDiasMes(): integer;
    function DevolverDiaSemana(): integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure cargarMes();
    procedure BitBtn2Click(Sender: TObject);
    procedure ActualizarColores2();
    procedure DatePicker1Change(Sender: TObject);
    procedure PulsarBotonDia(Sender: TObject);
    function DevolverFechaSeleccionada1():TDate;
    function DevolverDiaSeleccionado():Integer;
    function DevolverHabitacionSeleccionada1():Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PantallaMes: TPantallaMes;
  FechaSeleccionada1: TDate;
  diaSeleccionado: integer;
  HabitacionSeleccionada1: integer;
  PanelesDia: Array of TPanel;
  BotonesDia: Array of TButton;

implementation

{$R *.dfm}
 uses Unit1, Unit3, Unit4;

procedure TPantallaMes.FormActivate(Sender: TObject);
begin
  FechaSeleccionada1:= Principal.DevolverFechaSeleccionada;
  HabitacionSeleccionada1:= Principal.DevolverHabitacionSeleccionada;
  Label1.Caption:= 'Fecha seleccionada: '+ DateToStr(FechaSeleccionada1);
  Label2.Caption:= 'Habitación seleccionada: '+ IntToStr(HabitacionSeleccionada1);

  CargarMes();
end;

procedure TPantallaMes.FormClose(Sender: TObject; var Action: TCloseAction);
var
I: integer;
begin{
  if Length(PanelesDia) > 0 then
      begin
       for i := 0 to Length(PanelesDia)-1 do
          begin
          PanelesDia[i].Free;
          end;
      end;
    }

end;

function TPantallaMes.DevolverDiasMes(): Integer;
var
mes: integer;
mesnum: integer;
añonum: integer;
  begin
    mesnum:=MonthOfTheYear(FechaSeleccionada1);
    añonum:=YearOf(FechaSeleccionada1);

    mes:= DaysInAMonth(añonum, mesnum); //devuelve la cantidad de días de cierto mes.

    DevolverDiasMes := mes;
  end;



function TPantallaMes.DevolverDiaSemana(): Integer;
var
dia: integer;
mesnum: integer;
añonum: integer;
begin
    mesnum:=MonthOfTheYear(FechaSeleccionada1);
    añonum:=YearOf(FechaSeleccionada1);
    dia:= DayOfTheWeek(EncodeDate(añonum, mesnum, 1));//devuelve el índice del día de semana (1 = lunes) del primer dia de mes
    //nos sirve para posicionar el primer dia en el calendario.
    DevolverDiaSemana := dia;
end;

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
      Label1.Caption:= 'Fecha seleccionada: '+ DateToStr(FechaSeleccionada1);

      //primero borrar el calendario
      if Length(PanelesDia) > 0 then
      begin
       for i := 0 to Length(PanelesDia)-1 do
          begin
          PanelesDia[i].Free;
          end;
      end;

    //creación de los días
     dia:=1;
     i:= 1;
     fila := 0;
     diasemana:= DevolverDiaSemana - 1; //nos interesa que el lunes sea 0

     cantidadDias:= DevolverDiasMes();
     SetLength(PanelesDia, cantidadDias);
     SetLength(BotonesDia, cantidadDias);


    for i:= 0 to (cantidadDias-1) do   //la cantidad de dias se especifica aquí
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
        PanelDia.Caption:='Día '+Inttostr(dia);
        PanelDia.ParentBackground:= false;
        if DayOfTheMonth(FechaSeleccionada) = dia then
          begin
            PanelDia.Font.Style := [fsBold];
          end;

        BotonDia:=TButton.Create(self);
        BotonDia.Parent:=PanelDia;
        BotonDia.Top:=1;
        BotonDia.Tag:=dia;
        BotonDia.Left:=1;
        BotonDia.Width:=98;
        BotonDia.Height:=40;
        BotonDia.Caption:='Día '+Inttostr(dia);

        dia := dia + 1;
        diasemana:= diasemana +1;
        PanelesDia[i]:= PanelDia; //guardamos los paneles en un array global
        BotonesDia[i]:=BotonDia;
    end;

      for i := 0 to (Length(BotonesDia) - 1) do
      begin
         BotonesDia[i].OnClick := PulsarBotonDia;
      end;
     ActualizarColores2();
     DatePicker1.Date := FechaSeleccionada1;
end;


procedure TPantallaMes.PulsarBotonDia(Sender: TObject);
var
boton : TButton;
begin
  boton := TButton(Sender);
  //Showmessage('Has clickado el día'+ IntToStr(boton.Tag));
  diaSeleccionado := boton.Tag;
  FormularioDiario.showmodal();
end;

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
   if length(mes) < 2 then  //hay que formatear dias y meses para que tengan 2 dígitos
    mes:= '0'+ mes;

   //construimos el año y mes, pero el dia se lo vamos pasando uno a uno
   stringFecha := IntToStr(YearOf(fecha))+'-'+mes+'-';//+IntToStr(DayOfTheMonth(fecha));

    //ponemos todos en verde (habitaciones libres)
    for i := 0 to Length(PanelesDia)-1 do
    begin
      PanelesDia[i].Color:=clGreen;
    end;



    // COLOREAR RESERVAS
    Tablas.FDQuery1.Close;
    Tablas.FDQuery1.SQL.Text := 'select * from entradas where estado='+quotedstr('reservada')+' and numerohabitacion='+quotedStr(IntToStr(HabitacionSeleccionada1));
    Tablas.FDQuery1.Open;
    //Label4.Caption:=  quotedStr(stringFecha+'01');

   for i := 0 to Length(PanelesDia)-1 do
     begin
        dia:= IntToStr(i+1); //hay que formatear dias y meses para que tengan 2 dígitos
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

      if Tablas.FDQuery1.Locate('fecha', stringFecha+dia, []) then //si la habitación esta ocupada para la habitacion seleccionada
      begin
         PanelesDia[i].Color:=clRed;
      end;

     end;

end;

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

end.
