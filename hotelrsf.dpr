program hotelrsf;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Principal},
  Unit2 in 'Unit2.pas' {PantallaMes},
  Unit3 in 'Unit3.pas' {Tablas},
  Unit4 in 'Unit4.pas' {FormularioDiario},
  Vcl.Themes,
  Vcl.Styles,
  Unit5 in 'Unit5.pas' {FormularioPeriodo},
  Unit6 in 'Unit6.pas' {AltaCliente},
  Unit7 in 'Unit7.pas' {AltaHabitacion},
  Unit8 in 'Unit8.pas' {AltaTemporada},
  Unit9 in 'Unit9.pas' {AltaServicio},
  Unit10 in 'Unit10.pas' {InformeClientes},
  Unit11 in 'Unit11.pas' {Factura},
  Unit12 in 'Unit12.pas' {FacturaParametros},
  Unit13 in 'Unit13.pas' {ItinerarioServicios},
  Unit14 in 'Unit14.pas' {InformeDinamicoGenerador},
  Unit15 in 'Unit15.pas' {InformeDinamico},
  Unit16 in 'Unit16.pas' {GraficosReservas},
  Unit17 in 'Unit17.pas' {GraficosServicios},
  Unit18 in 'Unit18.pas' {AltaUsuario},
  Unit19 in 'Unit19.pas' {Login};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('TabletDark');
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TLogin, Login);
  Application.CreateForm(TPantallaMes, PantallaMes);
  Application.CreateForm(TTablas, Tablas);
  Application.CreateForm(TFormularioDiario, FormularioDiario);
  Application.CreateForm(TFormularioPeriodo, FormularioPeriodo);
  Application.CreateForm(TAltaCliente, AltaCliente);
  Application.CreateForm(TAltaHabitacion, AltaHabitacion);
  Application.CreateForm(TAltaTemporada, AltaTemporada);
  Application.CreateForm(TAltaServicio, AltaServicio);
  Application.CreateForm(TInformeClientes, InformeClientes);
  Application.CreateForm(TFactura, Factura);
  Application.CreateForm(TFacturaParametros, FacturaParametros);
  Application.CreateForm(TItinerarioServicios, ItinerarioServicios);
  Application.CreateForm(TInformeDinamicoGenerador, InformeDinamicoGenerador);
  Application.CreateForm(TInformeDinamico, InformeDinamico);
  Application.CreateForm(TGraficosReservas, GraficosReservas);
  Application.CreateForm(TGraficosServicios, GraficosServicios);
  Application.CreateForm(TAltaUsuario, AltaUsuario);
  Application.Run;
end.
