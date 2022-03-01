program Project1;

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
  Unit7 in 'Unit7.pas' {NuevaHabitacion},
  Unit8 in 'Unit8.pas' {CrearTemporada},
  Unit9 in 'Unit9.pas' {AltaServicio},
  Unit10 in 'Unit10.pas' {InformeClientes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('TabletDark');
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TPantallaMes, PantallaMes);
  Application.CreateForm(TTablas, Tablas);
  Application.CreateForm(TFormularioDiario, FormularioDiario);
  Application.CreateForm(TFormularioPeriodo, FormularioPeriodo);
  Application.CreateForm(TAltaCliente, AltaCliente);
  Application.CreateForm(TNuevaHabitacion, NuevaHabitacion);
  Application.CreateForm(TCrearTemporada, CrearTemporada);
  Application.CreateForm(TAltaServicio, AltaServicio);
  Application.CreateForm(TInformeClientes, InformeClientes);
  Application.Run;
end.
