program ExemploMVC;

uses
  Vcl.Forms,
  UFormPrincipal in 'view\UFormPrincipal.pas' {FormPrincipal},
  UFrmCadastrarCliente in 'view\UFrmCadastrarCliente.pas' {UFormCadastrarCliente},
  UClientModel in 'model\UClientModel.pas',
  UClienteController in 'controller\UClienteController.pas',
  UDmConexao in 'dao\UDmConexao.pas' {DmConexao: TDataModule},
  UDmCliente in 'dao\UDmCliente.pas' {DmCliente: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmCliente, DmCliente);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
