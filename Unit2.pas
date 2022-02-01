unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, System.DateUtils,
  Vcl.Buttons;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    function DevolverDiasMes(): integer;
    function DevolverDiaSemana(): integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure cargarMes();
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  FechaSeleccionada1: TDate;
  HabitacionSeleccionada1: integer;
  PanelesDia: Array of TPanel;
  BotonesDia: Array of TButton;

implementation

{$R *.dfm}
 uses Unit1;

procedure TForm2.FormActivate(Sender: TObject);
begin
  FechaSeleccionada1:= Form1.DevolverFechaSeleccionada;
  HabitacionSeleccionada1:= Form1.DevolverHabitacionSeleccionada;
  Label1.Caption:= 'Fecha seleccionada: '+ DateToStr(FechaSeleccionada1);
  Label2.Caption:= 'Habitación seleccionada: '+ IntToStr(HabitacionSeleccionada1);

  CargarMes();
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
I: integer;
begin
  for I := 0 to Length(PanelesDia)-1 do
  begin
     PanelesDia[I].Free; //debemos borrar los paneles de los días, si hemos creado uno de 31 y luego
     //abrimos un mes de 30, se siguen viendo 31
  end;

end;

function TForm2.DevolverDiasMes(): Integer;
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



function TForm2.DevolverDiaSemana(): Integer;
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

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  FechaSeleccionada1:= IncMonth(FechaSeleccionada1, -1);
  CargarMes();
end;


procedure TForm2.BitBtn2Click(Sender: TObject);
begin
  FechaSeleccionada1:= IncMonth(FechaSeleccionada1, 1);
  CargarMes();
end;

procedure TForm2.CargarMes();
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
       for i := 0 to Length(PanelesDia)-1 do
          begin
          PanelesDia[i].Free;
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

        BotonDia:=TButton.Create(self);
        BotonDia.Parent:=PanelDia;
        BotonDia.Top:=1;
        BotonDia.Tag:=dia;
        BotonDia.Left:=1;
        BotonDia.Width:=98;
        BotonDia.Height:=50;
        BotonDia.Caption:='Día '+Inttostr(dia);

        dia := dia + 1;
        diasemana:= diasemana +1;
        PanelesDia[i]:= PanelDia; //guardamos los paneles en un array global
        BotonesDia[i]:=BotonDia;
    end;

      for i := 0 to (Length(BotonesHabitaciones) - 1) do
      begin
         //BotonesHabitaciones[i].OnClick := PulsarBotonHabitacion;
      end;

end;

end.
