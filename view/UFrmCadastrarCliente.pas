unit UFrmCadastrarCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, UClienteController,
  UClientModel,UDmCliente;

type
  TOperacao = (opNovo, opAlterar, opNavegar);

  TUFormCadastrarCliente = class(TForm)
    PanelRodape: TPanel;
    PageControlPrincipal: TPageControl;
    TabSheetPesquisa: TTabSheet;
    TabSheetDados: TTabSheet;
    PanelFiltro: TPanel;
    LabeledEditPesquisar: TLabeledEdit;
    ButtonPesqusiar: TButton;
    PanelButtonPesquisar: TPanel;
    ButtonNovo: TButton;
    ButtonDetalhar: TButton;
    ButtonExcluir: TButton;
    DBGrid1: TDBGrid;
    DataSourcePesq: TDataSource;
    ComboBoxTipo: TComboBox;
    LabeledEditCodigo: TLabeledEdit;
    LabeledEditNome: TLabeledEdit;
    LabeledEditDocumento: TLabeledEdit;
    LabeledEditTelefone: TLabeledEdit;
    LabelTipo: TLabel;
    PanelBtnsCad: TPanel;
    ButtonListar: TButton;
    ButtonAlterar: TButton;
    ButtonGravar: TButton;
    ButtonCancelar: TButton;
    ButtonFechar: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonPesqusiarClick(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonDetalharClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonListarClick(Sender: TObject);
    procedure ButtonAlterarClick(Sender: TObject);
    procedure ButtonGravarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    FOperacao: TOperacao;
    procedure Novo;
    procedure Detalhar;
    procedure Configuracoes;
    procedure Pesquisar;
    procedure CarregarCliente;
    procedure Listar;
    procedure Alterar;
    procedure Excluir;
    procedure Inserir;
    procedure Gravar;
    procedure HabilitarControles(aOperacao: TOperacao);
  public

  end;

var
  UFormCadastrarCliente: TUFormCadastrarCliente;

implementation

{$R *.dfm}

procedure TUFormCadastrarCliente.Alterar;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
  sErro: string;
begin
  oCliente := TCliente.Create;
  oClienteController := TClienteController.Create;
  try
    oCliente.ID := StrToIntDef(LabeledEditCodigo.Text, 0);
    oCliente.Nome := LabeledEditNome.Text;
    if ComboBoxTipo.ItemIndex = 0 then
      oCliente.Tipo := 'F'
    else if ComboBoxTipo.ItemIndex = 1 then
      oCliente.Tipo := 'J'
    else
      oCliente.Tipo := EmptyStr;
    oCliente.Documento := LabeledEditDocumento.Text;
    oCliente.Telefone := LabeledEditTelefone.Text;

    if oClienteController.Alterar(oCliente, sErro) = False then
      raise Exception.Create(sErro);
  finally
    FreeAndNil(oClienteController);
    FreeAndNil(oCliente);
  end;
end;

procedure TUFormCadastrarCliente.ButtonAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  HabilitarControles(opAlterar);
end;

procedure TUFormCadastrarCliente.ButtonCancelarClick(Sender: TObject);
begin
  HabilitarControles(opNavegar);
end;

procedure TUFormCadastrarCliente.ButtonDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TUFormCadastrarCliente.ButtonExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TUFormCadastrarCliente.ButtonFecharClick(Sender: TObject);
begin
  close;
end;

procedure TUFormCadastrarCliente.ButtonGravarClick(Sender: TObject);
begin
  Gravar;
  HabilitarControles(opNavegar);
end;

procedure TUFormCadastrarCliente.ButtonListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TUFormCadastrarCliente.ButtonNovoClick(Sender: TObject);
begin
  Novo;
  HabilitarControles(opNovo);
end;

procedure TUFormCadastrarCliente.ButtonPesqusiarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TUFormCadastrarCliente.CarregarCliente;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
begin
  if not Assigned(DataSourcePesq.DataSet) then
    raise Exception.Create('DataSet não está ligado');

  if DataSourcePesq.DataSet.IsEmpty then
    raise Exception.Create('Nenhum registro selecionado');

  oCliente := TCliente.Create;
  oClienteController := TClienteController.Create;
  try
    oClienteController.CarregarCliente(
      oCliente,
      DataSourcePesq.DataSet.FieldByName('id').AsInteger
    );

    LabeledEditCodigo.Text := IntToStr(oCliente.ID);
    LabeledEditNome.Text := oCliente.Nome;

    if oCliente.Tipo = 'F' then
      ComboBoxTipo.ItemIndex := 0
    else if oCliente.Tipo = 'J' then
      ComboBoxTipo.ItemIndex := 1
    else
      ComboBoxTipo.ItemIndex := -1;

    LabeledEditDocumento.Text := oCliente.Documento;
    LabeledEditTelefone.Text := oCliente.Telefone;

  finally
    FreeAndNil(oClienteController);
    FreeAndNil(oCliente);
  end;
end;

procedure TUFormCadastrarCliente.Configuracoes;
begin
  DataSourcePesq.DataSet := DmCliente.DataSetPesquisa;
  TabSheetPesquisa.TabVisible := False;
  TabSheetDados.TabVisible := False;
  PageControlPrincipal.activePage := TabSheetPesquisa;
end;

procedure TUFormCadastrarCliente.DBGrid1DblClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TUFormCadastrarCliente.Detalhar;
begin
  CarregarCliente;
  HabilitarControles(opNavegar);
  FOperacao := opNavegar;
  PageControlPrincipal.activePage := TabSheetDados;
end;

procedure TUFormCadastrarCliente.Excluir;
var
  oClienteController: TClienteController;
  sErro: string;
begin
  oClienteController := TClienteController.Create;
  try
    if (DataSourcePesq.DataSet.Active) and
      (DataSourcePesq.DataSet.RecordCount > 0) then
    begin
      if MessageDlg('Deseja realmente excluir este cliente?', mtConfirmation,
        [mbYes, mbNo], 0) = IDYES then
      begin
        if oClienteController.Excluir(DataSourcePesq.DataSet.FieldByName('id').AsInteger, sErro)
          = False then
          raise Exception.Create(sErro);
        oClienteController.Pesquisar(LabeledEditPesquisar.Text);
      end;

    end
    else
      raise Exception.Create('Nao ha registros para ser excluido! ');
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TUFormCadastrarCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0)
  end;

end;

procedure TUFormCadastrarCliente.FormShow(Sender: TObject);
begin
  Configuracoes;
end;

procedure TUFormCadastrarCliente.Gravar;
var
  oClienteController: TClienteController;
begin
  oClienteController := TClienteController.Create;
  try
    case FOperacao of
      opNovo:
        Inserir;
      opAlterar:
        Alterar;
    end;
    oClienteController.Pesquisar(LabeledEditPesquisar.Text);
  finally
    FreeAndNil(oClienteController);
  end;
end;

procedure TUFormCadastrarCliente.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
    opNovo, opAlterar:
      begin
        LabeledEditNome.Enabled := True;
        ComboBoxTipo.Enabled := True;
        LabeledEditDocumento.Enabled := True;
        LabeledEditTelefone.Enabled := True;

        ButtonListar.Enabled := False;
        ButtonFechar.Enabled := False;
        ButtonAlterar.Enabled := False;
        ButtonGravar.Enabled := True;
        ButtonCancelar.Enabled := True;
      end;
    opNavegar:
      begin
        LabeledEditNome.Enabled := False;
        ComboBoxTipo.Enabled := False;
        LabeledEditDocumento.Enabled := False;
        LabeledEditTelefone.Enabled := False;

        ButtonListar.Enabled := True;
        ButtonFechar.Enabled := True;
        ButtonAlterar.Enabled := True;
        ButtonGravar.Enabled := False;
        ButtonCancelar.Enabled := False;
      end;
  end;
end;

procedure TUFormCadastrarCliente.Inserir;
var
  oCliente: TCliente;
  oClienteController: TClienteController;
  sErro: string;
begin
  oCliente := TCliente.Create;
  oClienteController := TClienteController.Create;
  try
    oCliente.ID := 0;
    oCliente.Nome := LabeledEditNome.Text;
    if ComboBoxTipo.ItemIndex = 0 then
      oCliente.Tipo := 'F'
    else if ComboBoxTipo.ItemIndex = 1 then
      oCliente.Tipo := 'J'
    else
      oCliente.Tipo := EmptyStr;
    oCliente.Documento := LabeledEditDocumento.Text;
    oCliente.Telefone := LabeledEditTelefone.Text;

    if oClienteController.Inserir(oCliente, sErro) = False then
      raise Exception.Create('Erro ao inserir o cliente');
  finally
    FreeAndNil(oCliente);
    FreeAndNil(oClienteController);
  end;


end;

procedure TUFormCadastrarCliente.Listar;
begin
  PageControlPrincipal.activePage := TabSheetPesquisa;
end;

procedure TUFormCadastrarCliente.Novo;
begin
  FOperacao := opNovo;
  PageControlPrincipal.activePage := TabSheetDados;
end;

procedure TUFormCadastrarCliente.Pesquisar;
var
  oClienteController: TClienteController;
begin
  oClienteController := TClienteController.Create;
  try
    oClienteController.Pesquisar(LabeledEditPesquisar.Text)
  finally
    FreeAndNil(oClienteController);
  end;
end;

end.
