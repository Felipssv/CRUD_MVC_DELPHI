unit UClientModel;

interface
  uses
    System.SysUtils;
type
  TCliente = class
  private
    FDocumento: string;
    FID: Integer;
    FNome: string;
    FTipo: string;
    FTelefone: string;
    procedure SetNome(const Value: string);
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write SetNome;
    property Tipo: string read FTipo write FTipo;
    property Documento: string read FDocumento write FDocumento;
    property Telefone: string read FTelefone write FTelefone;
  end;
implementation

{ TCliente }

procedure TCliente.SetNome(const Value: string);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('Nome precisa ser preenchido');
  FNome := Value;
end;

end.
