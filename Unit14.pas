unit Unit14;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TInformeDinamicoGenerador = class(TForm)
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function DevolverCampo(i: integer): String;
    function DevolverCantidadCampos(): Integer;
    function DevolverTabla(): String;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InformeDinamicoGenerador: TInformeDinamicoGenerador;
  listatablas : Array of String;
  listacampos : Array of String;
  listacheckbox : Array of Tcheckbox;

  cantidadcampos: integer;
  camposseleccionados: Array of String;
  tablaseleccionada: string;

implementation

{$R *.dfm}

  uses
      Unit3, Unit15;



//sacamos las tablas de la base de datos y las guardamos en un array, rellenamos el radio group con ese array

procedure TInformeDinamicoGenerador.FormActivate(Sender: TObject);
var
  i: Integer;

begin
  RadioGroup1.Items.Clear;

  Tablas.FDQuery6.Close;
  Tablas.FDQuery6.SQL.Text := ('show tables from hotelrsf');
  Tablas.FDQuery6.Open;

  SetLength(listatablas, Tablas.FDQuery6.RecordCount);

  Tablas.FDQuery6.first;
  i := 0;
  while not Tablas.FDQuery6.Eof do
      begin
        listatablas[i] := Tablas.FDQuery6.FieldByName('Tables_in_hotelrsf').Value;
        RadioGroup1.Items.Add(listatablas[i]);

        Tablas.FDQuery6.next;
        i := i + 1;
      end;


  RadioGroup1.ItemIndex := 0; //seleccionamos el primero por defecto
end;




//genera checkboxes para los campos de la tabla seleccionada

procedure TInformeDinamicoGenerador.RadioGroup1Click(Sender: TObject);
var
i: integer;
campocheck: TCheckbox;
saltodelinea: integer;

begin

  //borramos los campos primero
  if Length(listacheckbox) > 0 then
      begin
       for i := 0 to Length(listacheckbox)-1 do
          begin
          listacheckbox[i].Free;
          end;
      end;
  RadioGroup2.Items.Clear;

  tablaseleccionada :=  Radiogroup1.Items[Radiogroup1.ItemIndex];

  Tablas.FDQuery6.Close;
  Tablas.FDQuery6.SQL.Text := ('SHOW COLUMNS FROM ' + tablaseleccionada);
  Tablas.FDQuery6.Open;

  SetLength(listacampos, Tablas.FDQuery6.RecordCount);
  SetLength(listacheckbox, Tablas.FDQuery6.RecordCount);

  saltodelinea:= Round(370 / Tablas.FDQuery6.RecordCount); //para que los campos salgan repartidos

  Tablas.FDQuery6.first;
  i := 0;
  while not Tablas.FDQuery6.Eof do
      begin
        listacampos[i] := Tablas.FDQuery6.FieldByName('Field').Value;

        //crear los checkboxes
        campocheck:=TCheckbox.create(self);
        campocheck.Parent:=Scrollbox1;

        campocheck.Tag:=i;
        campocheck.Top:=i*saltodelinea+5;
        campocheck.Left:=5;
        campocheck.Caption:= listacampos[i];
        campocheck.Width:= 170;
        campocheck.Checked:= true;
        listacheckbox[i]:= campocheck;

        RadioGroup2.Items.Add(listacampos[i]);

        Tablas.FDQuery6.next;
        i := i + 1;
      end;

  RadioGroup2.Itemindex := 0;

end;



//construimos el SQL con lo que hemos seleccionado

procedure TInformeDinamicoGenerador.Button1Click(Sender: TObject);
var
sql: string;
i : integer;
j : integer;
contadorcampos : integer;
contadorcomas : integer;
begin

  //primero de todo, quiero guardar los campos que he seleccionado
  contadorcampos := 0;

   for i := 0 to Length(listacheckbox)-1 do
      begin
        if listacheckbox[i].Checked then  contadorcampos := contadorcampos + 1;
      end;



  SetLength(camposseleccionados, contadorcampos);
   j := 0;
   for i := 0 to Length(listacampos)-1 do
      begin
         if listacheckbox[i].Checked then
            begin
              camposseleccionados[j] := listacampos[i];
              j := j + 1;
            end;
      end;


  //select
  sql := 'select ';

  //campos
  contadorcomas := contadorcampos-1; //si seleccionamos 4 campos, sabemos que hay que poner 3 comas

  for i := 0 to Length(listacampos)-1 do
    begin
      if listacheckbox[i].Checked then
        begin
          sql := sql + ' ' + listacampos[i];

          if contadorcomas <> 0 then  //gastamos una coma por cada campo, salvo en el último
            begin
               sql := sql + ',';
               contadorcomas := contadorcomas - 1;
            end;

        end;

    end;

  //from
  sql := sql + ' from ';

  //tabla
  sql := sql + RadioGroup1.Items[Radiogroup1.ItemIndex];

  //order by
  sql := sql + ' order by ';

  //campo orderby
  sql := sql + RadioGroup2.Items[Radiogroup2.ItemIndex];

  //asc o desc
  if Radiogroup3.ItemIndex = 0 then sql := sql + ' asc';
  if Radiogroup3.ItemIndex = 1 then sql := sql + ' desc';

  //showmessage(sql);
  if contadorcampos > 0 then   //ejecutamos si hay algún campo seleccionado
    begin
       Tablas.FDQuery6.Close;
       Tablas.FDQuery6.SQL.Text := sql;
       Tablas.FDQuery6.Open;
    end;

  cantidadcampos := contadorcampos;

  if contadorcampos > 0 then
   begin
    InformeDinamico.QuickRep1.Preview;
   end else
   begin
     showmessage('El informe debe contener al menos un campo.');
   end;
end;


//estas funciones se utilizan para mandar información al informe

function TInformeDinamicoGenerador.DevolverCampo(i: integer): String;
begin

    DevolverCampo := camposseleccionados[i];
end;

function TInformeDinamicoGenerador.DevolverCantidadCampos(): integer;
begin
    DevolverCantidadCampos := cantidadcampos;
end;

function TInformeDinamicoGenerador.DevolverTabla(): String;
begin
    DevolverTabla := tablaseleccionada;
end;


procedure TInformeDinamicoGenerador.Button2Click(Sender: TObject);
begin
  InformeDinamicoGenerador.Close;
end;



procedure TInformeDinamicoGenerador.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then  InformeDinamicoGenerador.Close;
end;

end.
