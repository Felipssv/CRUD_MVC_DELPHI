unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UFrmCadastrarCliente;

type
  TFormPrincipal = class(TForm)
    ButtonCliente: TButton;
    procedure ButtonClienteClick(Sender: TObject);
  private
    procedure AbrirCliente;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.AbrirCliente;
begin
  UFormCadastrarCliente := TUFormCadastrarCliente.Create(nil);
  try
    UFormCadastrarCliente.ShowModal;
  finally
    FreeAndNil(UFormCadastrarCliente);
  end;
end;

procedure TFormPrincipal.ButtonClienteClick(Sender: TObject);
begin
  AbrirCliente;
end;

end.
