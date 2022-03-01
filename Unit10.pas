unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuickRpt, QRCtrls, Vcl.ExtCtrls;

type
  TInformeClientes = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand3: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel1: TQRLabel;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRBand4: TQRBand;
    QRSysData1: TQRSysData;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRSysData2: TQRSysData;
    QRLabel7: TQRLabel;
    QRSysData3: TQRSysData;
    procedure FormActivate(Sender: TObject);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InformeClientes: TInformeClientes;
  i: integer;

implementation

{$R *.dfm}
uses
  Unit3;


procedure TInformeClientes.FormActivate(Sender: TObject);
begin
  i:= 1;
end;


procedure TInformeClientes.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);

var
  banda : TQRBand;
begin
banda := TQRBand(Sender);
  if i mod 2 = 0 then
    begin
      banda.Color:= TColor(RGB(220,237,252));
    end else
    begin
     banda.Color:=  TColor(RGB(207,231,252));
    end;
  i:= i + 1;

end;

end.
