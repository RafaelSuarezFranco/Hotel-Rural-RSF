unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, System.DateUtils,
  Vcl.WinXPickers;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DatePicker1: TDatePicker;
    Label3: TLabel;
    Button1: TButton;



    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CargarDia();
    procedure PulsarBotonHabitacion(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DatePicker1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function DevolverFechaSeleccionada():TDate;
    function DevolverHabitacionSeleccionada():Integer;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  var
    Form1: TForm1;
    FechaActual: TDate;
    FechaSeleccionada: TDate;
    //arLbl : Array[1..8] of TLabel;
    PanelesHabitaciones : Array of TPanel;
    BotonesHabitaciones : Array of TButton;
    HabitacionSeleccionada: integer;

implementation

{$R *.dfm}
 uses  Unit2;


procedure TForm1.FormActivate(Sender: TObject);
var
PanelHabitacion: TPanel;
BotonHabitacion: TButton;
i: integer;    //será el nº de habitación
columna:integer;
fila: integer;
cantidadHabitaciones: integer;
begin
    FechaActual := Now();
    FechaSeleccionada:= Now();

    //creación de las habitaciones
     i:= 1;
     columna := 1;
     fila := 0;

     cantidadHabitaciones:= 10;  //esta variable recogera la cantidad de habitaciones de la bbdd
     SetLength(PanelesHabitaciones, cantidadHabitaciones);
     SetLength(BotonesHabitaciones, cantidadHabitaciones);


    for i:=0 to (cantidadHabitaciones-1) do   //la cantidad de habitaciones se especifica aquí
     begin
      if (i mod 5 = 0) and (i <> 0) then
        begin
          fila:= fila + 1;
          columna:= 1 ;
        end;
        PanelHabitacion:=TPanel.create(self);
        PanelHabitacion.Parent:=ScrollBox1;
        PanelHabitacion.Width := 100;
        PanelHabitacion.Height := 150;
        PanelHabitacion.Tag:=i+1;
        PanelHabitacion.Top:=fila*155+5;
        PanelHabitacion.Left:=columna+5;
        PanelHabitacion.Caption:='Habitación'+Inttostr(i+1);

        BotonHabitacion:=TButton.Create(self);
        BotonHabitacion.Parent:=PanelHabitacion;
        BotonHabitacion.Top:=1;
        BotonHabitacion.Tag:=i+1;
        BotonHabitacion.Left:=1;
        BotonHabitacion.Width:=98;
        BotonHabitacion.Height:=50;
        BotonHabitacion.Caption:='Habitación'+Inttostr(i+1);

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



procedure TForm1.CargarDia();
begin
    Label1.Caption:= 'Fecha seleccionada: '+DateToStr(FechaSeleccionada);
    Label2.Caption:= 'Fecha actual: '+DateToStr(FechaActual);

    DatePicker1.Date:= FechaSeleccionada;

end;

procedure TForm1.PulsarBotonHabitacion(Sender: TObject);
var
boton : TButton;
begin
  boton := TButton(Sender);
  //Showmessage('Has clickado la habitacion'+ IntToStr(boton.Tag));
  HabitacionSeleccionada := boton.Tag;
  Form2.showmodal();
end;

 procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, 1); //nos permite navegar al día siguente
  CargarDia();
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  FechaSeleccionada:= IncDay(FechaSeleccionada, -1); //nos permite navegar al día siguente
  CargarDia();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FechaSeleccionada:= FechaActual;
  CargarDia();
end;

procedure TForm1.DatePicker1Change(Sender: TObject);
begin
   FechaSeleccionada:= DatePicker1.Date;
   CargarDia();
end;

function TForm1.DevolverFechaSeleccionada(): TDate;  //usamos estas funciones para pasar la habitacion y fecha al otro form
begin
    DevolverFechaSeleccionada := FechaSeleccionada;
end;

function TForm1.DevolverHabitacionSeleccionada(): Integer;
begin
    DevolverHabitacionSeleccionada := HabitacionSeleccionada;
end;

end.
