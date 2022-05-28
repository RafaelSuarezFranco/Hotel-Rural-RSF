  unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  System.DateUtils,
  FireDAC.Comp.Client, Vcl.StdCtrls, IdGlobal, IdHash, System.RegularExpressions,
  IdHashMessageDigest;

type
  TTablas = class(TForm)
    FDConnection1: TFDConnection;
    FDTableHabitaciones: TFDTable;
    DataSource1: TDataSource;
    FDTableEntradas: TFDTable;
    FDTableEntradasid: TFDAutoIncField;
    FDTableEntradasnumerohabitacion: TIntegerField;
    FDTableEntradasfecha: TDateField;
    FDTableEntradasestado: TStringField;
    FDTableEntradascliente: TStringField;
    FDTableEntradaspreciofinal: TSingleField;
    DataSource2: TDataSource;
    FDTableHabitacionesid: TFDAutoIncField;
    FDTableHabitacionesnumero: TIntegerField;
    FDTableHabitacionestipo: TStringField;
    FDTableHabitacionespreciobase: TSingleField;
    FDQuery1: TFDQuery;
    DataSourceQuery: TDataSource;
    FDTableTemporadas: TFDTable;
    DataSource3: TDataSource;
    FDTableTemporadasid: TFDAutoIncField;
    FDTableTemporadasfechainicio: TDateField;
    FDTableTemporadasfechafin: TDateField;
    FDTableTemporadasprecioadicional: TFloatField;
    FDTableTemporadasnombretemporada: TStringField;
    FDTableServicios: TFDTable;
    DataSource4: TDataSource;
    FDTableEntradasservicios: TFDTable;
    DataSource5: TDataSource;
    FDTableServiciosid: TFDAutoIncField;
    FDTableServiciosnombreservicio: TStringField;
    FDTableServiciosprecioservicio: TFloatField;
    FDTableEntradasserviciosid: TFDAutoIncField;
    FDTableEntradasserviciosnumerohabitacion: TIntegerField;
    FDTableEntradasserviciosfecha: TDateField;
    FDTableEntradasserviciosnombreservicio: TStringField;
    FDTableHistoricoentradas: TFDTable;
    DataSource6: TDataSource;
    FDTableHistoricoentradasid: TFDAutoIncField;
    FDTableHistoricoentradasnumerohabitacion: TIntegerField;
    FDTableHistoricoentradasfecha: TDateField;
    FDTableHistoricoentradascliente: TStringField;
    FDTableHistoricoentradaspreciofinal: TSingleField;
    FDTableHistoricoentradasestado: TStringField;
    FDTableClientes: TFDTable;
    FDTableClientesid: TFDAutoIncField;
    FDTableClientesidentificador: TStringField;
    FDTableClientesnombre: TStringField;
    FDTableClientesapellidos: TStringField;
    DataSource7: TDataSource;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FDQuery4: TFDQuery;
    FDQuery5: TFDQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    FDQuery6: TFDQuery;
    Label8: TLabel;
    FDQuery7: TFDQuery;
    Label9: TLabel;
    FDQuery8: TFDQuery;
    FDTableUsuarios: TFDTable;
    FDTableUsuariosid: TFDAutoIncField;
    FDTableUsuariosusuario: TStringField;
    FDTableUsuarioscorreo: TStringField;
    FDTableUsuarioscliente: TStringField;
    FDTableUsuariosperfil: TStringField;
    FDTableUsuariospassword: TStringField;

    function formatearFechaSQL(fecha: TDate): String;
    function rellenarComboHabitaciones(combo: TComboBox): TComboBox;
    function passwordHash(password: String): String;
    function IsMatch(const Input, Pattern: string): boolean;
    function emailFormatoValido(const EmailAddress: string): boolean;
    function EncriptarString(const S :WideString; Key: Word): String;
    function DesencriptarString(const S: String; Key: Word): String;
  private
    { Private declarations }
  public
    { Public declarations }

    //datos del usuario logeado.
    perfil: string;
    cliente: string;
    usuario: string;
    passwordcorreo: string;
  end;

var
  Tablas: TTablas;

implementation

{$R *.dfm}
// formatea una fecha de tipo TDate a una String que se pueda usar en las FDQueries.

function TTablas.formatearFechaSQL(fecha: TDate): String;
var
  diabusqueda: String;
  mesbusqueda: String;
  fechabusqueda: String;
begin
  diabusqueda := IntToStr(DayOfTheMonth(fecha));
  mesbusqueda := IntToStr(MonthOfTheYear(fecha));
  if length(diabusqueda) < 2 then
    diabusqueda := '0' + diabusqueda;
  if length(mesbusqueda) < 2 then
    mesbusqueda := '0' + mesbusqueda;
  fechabusqueda := IntToStr(YearOf(fecha)) + '-' + mesbusqueda + '-' +
    diabusqueda; // fecha formateada para buscarla con SQL

  formatearFechaSQL := fechabusqueda;
end;



// recibe un combobox a rellenar, lo vacía y lo rellena con los números de habitación.

function TTablas.rellenarComboHabitaciones(combo: TComboBox): TComboBox;
var
  cantidadHabitaciones: integer;
  i: integer;
begin
  i := 0;
  cantidadHabitaciones := Tablas.FDTableHabitaciones.RecordCount;

  combo.Items.Clear; // vaciar el combobox para rellenarlo con las habitaciones
  Tablas.FDTableHabitaciones.First;
  while not Tablas.FDTableHabitaciones.Eof do
  begin
    combo.Items.Add(IntToStr(Tablas.FDTableHabitacionesnumero.Value));
    i := i + 1;
    Tablas.FDTableHabitaciones.Next;
  end;

  combo.Style := csDropDownList; // readonly
  combo.ItemIndex := 0; // selecciona el primero

  rellenarComboHabitaciones := combo;
end;



  //convierte una cadena en un hash MD5

function TTablas.passwordHash(password: String): String;
var
    hashString : TIdHashMessageDigest5;
begin
 hashString  := nil;
    try
        hashString  := TIdHashMessageDigest5.Create;
        passwordHash := IdGlobal.IndyLowerCase ( hashString .HashStringAsHex ( password ) );
    finally
        hashString.Free;
    end;
end;








//validar el formato de un correo
function TTablas.IsMatch(const Input, Pattern: string): boolean;
begin
  Result := TRegEx.IsMatch(Input, Pattern);
end;


function TTablas.emailFormatoValido(const EmailAddress: string): boolean;
const
  EMAIL_REGEX = '^((?>[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+\x20*|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*"\x20*)*(?<angle><))?((?!\.)'
             +'(?>\.?[a-zA-Z\d!#$%&''*+\-/=?^_`{|}~]+)+|"((?=[\x01-\x7f])'
             +'[^"\\]|\\[\x01-\x7f])*")@(((?!-)[a-zA-Z\d\-]+(?<!-)\.)+[a-zA-Z]'
             +'{2,}|\[(((?(?<!\[)\.)(25[0-5]|2[0-4]\d|[01]?\d?\d))'
             +'{4}|[a-zA-Z\d\-]*[a-zA-Z\d]:((?=[\x01-\x7f])[^\\\[\]]|\\'
             +'[\x01-\x7f])+)\])(?(angle)>)$';
begin
  Result := IsMatch(EmailAddress, EMAIL_REGEX);
end;




//encriptar y desencriptar strings
const CKEY1 = 53761;
      CKEY2 = 32618;

function TTablas.EncriptarString(const S :WideString; Key: Word): String;
var   i          :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);
  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function TTablas.DesencriptarString(const S: String; Key: Word): String;
var   i, tmpKey  :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
      tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;
  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result:= UTF8Decode(RStr);
end;

end.
