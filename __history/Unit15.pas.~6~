unit Unit15;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QRCtrls, QuickRpt, Vcl.ExtCtrls;

type
  TInformeDinamico = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRShape1: TQRShape;
    QRBand3: TQRBand;
    QRShape2: TQRShape;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  InformeDinamico: TInformeDinamico;
  listacampos: Array of String;
  tabla: String;

  arraylabel: Array of TQRLabel;
  arraytext: Array of TQRDBText;

implementation

{$R *.dfm}

 uses
  Unit3, Unit14;


procedure TInformeDinamico.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var
cantidadcampos: integer;
i: integer;
separador: integer;
nuevolabel:TQRLabel;
nuevotext:TQRDBText;

begin

  //lo borramos todo, campos y etiquetas
  if Length(arraylabel) > 0 then
      begin
       for i := 0 to Length(arraylabel)-1 do
          begin
          arraylabel[i].Free;
          end;
      end;

   if Length(arraytext) > 0 then
      begin
       for i := 0 to Length(arraytext)-1 do
          begin
          arraytext[i].Free;
          end;
      end;


  cantidadcampos := InformeDinamicoGenerador.DevolverCantidadCampos();
  tabla := InformeDinamicoGenerador.DevolverTabla();

  separador := Round(700 / cantidadcampos);

  SetLength(listacampos, cantidadcampos);
  SetLength(arraylabel, cantidadcampos);
  SetLength(arraytext, cantidadcampos);

  for i := 0 to Length(listacampos)-1 do
    begin
      listacampos[i] :=  InformeDinamicoGenerador.DevolverCampo(i);
    end;

  //ahora que tenemos los campos y la tabla, construimos los elementos del informe
  // QRBand3 = banda cabecera
  // QRBand2 = banda detalle

  QRLabel2.Caption := 'De la tabla ' + tabla;

  for i := 0 to Length(listacampos)-1 do
    begin
    //labels
      nuevolabel := TQRLabel.create(self);
      nuevolabel.Parent := QRBand3;
      nuevolabel.Caption := AnsiUpperCase(listacampos[i]);
      nuevolabel.Top := 12;
      nuevolabel.Left := i*separador + 5;
      nuevolabel.Transparent := true;
      nuevolabel.Width := 100;
      nuevolabel.Height := 20;
      nuevolabel.Font.Size := 8;
      arraylabel[i] := nuevolabel;

      //QRtexts
      nuevotext := TQRDBText.create(self);
      nuevotext.Parent := QRBand2;
      nuevotext.DataSet := Tablas.FDQuery6;
      nuevotext.DataField := listacampos[i];
      nuevotext.Top := 12;
      nuevotext.Left := i*separador + 5;
      nuevotext.Transparent := true;
      nuevotext.Width := 100;
      nuevotext.Height := 20;
      nuevotext.Font.Size := 8;
      arraytext[i] := nuevotext;
    end;

end;

end.
