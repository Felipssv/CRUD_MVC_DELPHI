unit UDmConexao;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, Data.SqlExpr;

type
  TDmConexao = class(TDataModule)
    FDConexao: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  DmConexao: TDmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDmConexao.DataModuleCreate(Sender: TObject);
begin
  FdConexao.DriverName                    := 'PG';
  FdConexao.Params.Values['Server']       := 'localhost';
  FdConexao.Params.Values['Port']         := '5432';
  FdConexao.Params.Values['Database']     := 'exemploMVC';
  FdConexao.Params.Values['User_Name']    := 'postgres';
  FdConexao.Params.Values['Password']     := 'root';
  FdConexao.Params.Values['CharacterSet'] := 'UTF8';
  FdConexao.Params.Values['SSLMode']      := 'require';
  FdConexao.LoginPrompt                   := False;
  FdConexao.Connected                     := True;
end;

end.
