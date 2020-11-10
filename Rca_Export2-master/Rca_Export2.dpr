program Rca_Export2;

uses
  FixBDE4GbBug in 'FixBDE4GbBug.pas',
  Forms,
  main in 'main.pas' {frmMain},
  Export_SQL in 'Export_SQL.pas',
  Export_Text in 'Export_Text.pas',
  FtpSend in 'FtpSend.pas' {Form1},
  ClassRealEstateDotComFeatures in 'ClassRealEstateDotComFeatures.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
