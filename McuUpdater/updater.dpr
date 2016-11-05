program updater;

uses
  Vcl.Forms,
  mcuupdater in 'mcuupdater.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MCU Manager Updater';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
