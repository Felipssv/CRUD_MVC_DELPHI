unit UDmCliente;

interface

uses
  System.SysUtils, System.Classes, UDmConexao, Data.DB, UClientModel,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmCliente = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    fdInserir:   TFDQuery;
    fdAlterar:   TFDQuery;
    fdExcluir:   TFDQuery;
  public
    fdPesquisar: TFDQuery;
    procedure Pesquisar(sNome: string);
    procedure CarregarCliente(oCliente: TCliente; iCodigo: Integer);
    function Inserir(oCliente: TCliente; out sErro: string): Boolean;
    function Alterar(oCliente: TCliente; out sErro: string): Boolean;
    function Excluir(iCodigo: Integer; out sErro: string): Boolean;
  end;

var
  dmCliente: TDmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TdmCliente }


procedure TDmCliente.Pesquisar(sNome: string);
begin
  fdPesquisar.Close;
  fdPesquisar.SQL.Text := 'SELECT * FROM cliente WHERE nome ILIKE :nome ORDER BY nome';
  fdPesquisar.ParamByName('nome').AsString := '%' + sNome + '%';
  fdPesquisar.Open;
  fdPesquisar.First;
end;

procedure TDmCliente.CarregarCliente(oCliente: TCliente; iCodigo: Integer);
var
  fdCliente: TFDQuery;
begin
  if not Assigned(oCliente) then
    raise Exception.Create('O Cliente está NIL');

  fdCliente := TFDQuery.Create(nil);
  try
    fdCliente.Connection := DmConexao.FDConexao;
    fdCliente.SQL.Text   := 'SELECT * FROM cliente WHERE id = :id';
    fdCliente.ParamByName('id').AsInteger := iCodigo;
    fdCliente.Open;

    oCliente.ID        := fdCliente.FieldByName('id').AsInteger;
    oCliente.Nome      := fdCliente.FieldByName('nome').AsString;
    oCliente.Tipo      := fdCliente.FieldByName('tipo').AsString;
    oCliente.Documento := fdCliente.FieldByName('documento').AsString;
    oCliente.Telefone  := fdCliente.FieldByName('telefone').AsString;

  finally
    FreeAndNil(fdCliente);
  end;
end;

procedure TDmCliente.DataModuleCreate(Sender: TObject);
begin
  fdPesquisar := TFDQuery.Create(Self);
  fdPesquisar.Name := 'fdPesquisar';
  fdPesquisar.Connection := DmConexao.FDConexao;

  fdInserir := TFDQuery.Create(Self);
  fdInserir.Name := 'fdInserir';
  fdInserir.Connection   := DmConexao.FDConexao;

  fdAlterar := TFDQuery.Create(Self);
  fdAlterar.Name := 'fdAlterar';
  fdAlterar.Connection   := DmConexao.FDConexao;

  fdExcluir := TFDQuery.Create(Self);
  fdExcluir.Name := 'fdExcluir';
  fdExcluir.Connection   := DmConexao.FDConexao;
end;

function TDmCliente.Inserir(oCliente: TCliente; out sErro: string): Boolean;
begin
  if not Assigned(oCliente) then
    raise Exception.Create('O Cliente está NIL');

  try
    fdInserir.Close;
    fdInserir.SQL.Text :=
      'INSERT INTO cliente (nome, tipo, documento, telefone) ' +
      'VALUES (:nome, :tipo, :documento, :telefone) ' +
      'RETURNING id';

    fdInserir.ParamByName('nome').AsString      := oCliente.Nome;
    fdInserir.ParamByName('tipo').AsString      := oCliente.Tipo;
    fdInserir.ParamByName('documento').AsString := oCliente.Documento;
    fdInserir.ParamByName('telefone').AsString  := oCliente.Telefone;
    fdInserir.Open;
    oCliente.ID := fdInserir.FieldByName('id').AsInteger;
    Result := True;

  except
    on E: Exception do
    begin
      sErro  := 'Ocorreu um erro ao inserir cliente: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDmCliente.Alterar(oCliente: TCliente; out sErro: string): Boolean;
begin
  if not Assigned(oCliente) then
    raise Exception.Create('O Cliente está NIL');

  try
    fdAlterar.Close;
    fdAlterar.SQL.Text :=
      'UPDATE cliente SET nome=:nome, tipo=:tipo, documento=:documento, ' +
      'telefone=:telefone WHERE id=:id';

    fdAlterar.ParamByName('nome').AsString      := oCliente.Nome;
    fdAlterar.ParamByName('tipo').AsString      := oCliente.Tipo;
    fdAlterar.ParamByName('documento').AsString := oCliente.Documento;
    fdAlterar.ParamByName('telefone').AsString  := oCliente.Telefone;
    fdAlterar.ParamByName('id').AsInteger       := oCliente.ID;

    fdAlterar.ExecSQL;
    Result := True;

  except
    on E: Exception do
    begin
      sErro  := 'Ocorreu um erro ao alterar cliente: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

function TDmCliente.Excluir(iCodigo: Integer; out sErro: string): Boolean;
begin
  try
    fdExcluir.Close;
    fdExcluir.SQL.Text := 'DELETE FROM cliente WHERE id=:id';
    fdExcluir.ParamByName('id').AsInteger := iCodigo;
    fdExcluir.ExecSQL;
    Result := True;

  except
    on E: Exception do
    begin
      sErro := 'Ocorreu um erro ao excluir o cliente: ' + sLineBreak + E.Message;
      Result := False;
    end;
  end;
end;

end.
