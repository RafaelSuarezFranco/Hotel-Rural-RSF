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


implementation

{$R *.dfm}
 uses Unit2, Unit3;

procedure TFormularioDiario.Button1Click(Sender: TObject);
var
seleccion: integer;
begin
  if (RadioGroup1.ItemIndex = 0) and (Estado <> 'libre') then
  //si vamos a liberar una habitacion, significa que vamos a borrar su registro
    begin
      seleccion := messagedlg('Vas a dejar libre una habitación que estaba reservada/ocupada. Esto borrará su registro y los correspondientes datos. ¿Estás seguro?',mtWarning , mbOKCancel, 0);


      if seleccion = mrCancel then ShowMessage('Acción cancelada.');
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
            ShowMessage('El registo de esta habitación para la fecha concreta ha sido borrado.');
            end;
          Tablas.FDTableEntradas.Next;
          end;
        Tablas.FDTableEntradas.Filtered:=False;

       end;
    end;
    // RESERVAR UNA HABITACION QUE ESTABA LIBRE


    //OCUPAR UNA HABITACION QUE ESTABA RESERVADA



    //cerramos y actualizamos la pantalla del mes.
    FormularioDiario.Close;
    PantallaMes.cargarMes;
end;

procedure TFormularioDiario.FormActivate(Sender: TObject);
var

diabusqueda: String;
mesbusqueda: String;

dia: integer;
mes: integer;
año: integer;
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

    Label6.Caption:= IntToStr(Habitacion);
    Label7.Caption:= DateToStr(Fecha);
    Edit1.Text:=Cliente;
    Label3.Caption:=FloatToStr(Preciofinal);

    if Estado = 'libre' then
      RadioGroup1.ItemIndex:=0;
    if Estado = 'reservada' then
      RadioGroup1.ItemIndex:=1;
    if Estado = 'ocupada' then
      RadioGroup1.ItemIndex:=2;



    //showmessage(Estado+Cliente);
end;

end.
