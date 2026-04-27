object UFormCadastrarCliente: TUFormCadastrarCliente
  Left = 0
  Top = 0
  Caption = 'Cadastrar Cliente'
  ClientHeight = 531
  ClientWidth = 885
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object PanelRodape: TPanel
    Left = 0
    Top = 490
    Width = 885
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 775
    object ButtonFechar: TButton
      Left = 795
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = ButtonFecharClick
    end
  end
  object PageControlPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 885
    Height = 490
    ActivePage = TabSheetPesquisa
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 775
    object TabSheetPesquisa: TTabSheet
      Caption = 'tbPesq'
      object PanelFiltro: TPanel
        Left = 0
        Top = 0
        Width = 877
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 767
        object LabeledEditPesquisar: TLabeledEdit
          Left = 11
          Top = 22
          Width = 369
          Height = 23
          EditLabel.Width = 110
          EditLabel.Height = 15
          EditLabel.Caption = 'Digite para pesquisar'
          TabOrder = 0
          Text = ''
        end
        object ButtonPesqusiar: TButton
          Left = 791
          Top = 14
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = ButtonPesqusiarClick
        end
      end
      object PanelButtonPesquisar: TPanel
        Left = 0
        Top = 419
        Width = 877
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        ExplicitLeft = 3
        ExplicitTop = 422
        ExplicitWidth = 848
        object ButtonNovo: TButton
          Left = 597
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Novo'
          TabOrder = 0
          OnClick = ButtonNovoClick
        end
        object ButtonDetalhar: TButton
          Left = 694
          Top = 10
          Width = 75
          Height = 25
          Align = alCustom
          Caption = 'Detalhar'
          TabOrder = 1
          OnClick = ButtonDetalharClick
        end
        object ButtonExcluir: TButton
          Left = 791
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Excluir'
          TabOrder = 2
          OnClick = ButtonExcluirClick
        end
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 60
        Width = 871
        Height = 356
        Align = alClient
        DataSource = DataSourcePesq
        DrawingStyle = gdsGradient
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
      end
    end
    object TabSheetDados: TTabSheet
      Caption = 'tbDados'
      ImageIndex = 1
      object LabelTipo: TLabel
        Left = 3
        Top = 110
        Width = 50
        Height = 15
        Caption = 'Tipo (F/J)'
      end
      object ComboBoxTipo: TComboBox
        Left = 3
        Top = 128
        Width = 140
        Height = 23
        DropDownWidth = 118
        ItemIndex = 0
        MaxLength = 10
        TabOrder = 2
        Text = 'Fisico'
        Items.Strings = (
          'Fisico'
          'Juridico')
      end
      object LabeledEditCodigo: TLabeledEdit
        Left = 3
        Top = 24
        Width = 62
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'Codigo'
        Enabled = False
        TabOrder = 0
        Text = ''
      end
      object LabeledEditNome: TLabeledEdit
        Left = 3
        Top = 70
        Width = 500
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        TabOrder = 1
        Text = ''
      end
      object LabeledEditDocumento: TLabeledEdit
        Left = 179
        Top = 128
        Width = 140
        Height = 23
        EditLabel.Width = 127
        EditLabel.Height = 15
        EditLabel.Caption = 'Documento (CPF/CNPJ)'
        MaxLength = 15
        TabOrder = 3
        Text = ''
      end
      object LabeledEditTelefone: TLabeledEdit
        Left = 363
        Top = 128
        Width = 140
        Height = 23
        EditLabel.Width = 45
        EditLabel.Height = 15
        EditLabel.Caption = 'Telefone'
        MaxLength = 10
        TabOrder = 4
        Text = ''
      end
      object PanelBtnsCad: TPanel
        Left = 0
        Top = 419
        Width = 877
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 5
        ExplicitWidth = 767
        object ButtonListar: TButton
          Left = 445
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Listar'
          TabOrder = 3
          OnClick = ButtonListarClick
        end
        object ButtonAlterar: TButton
          Left = 526
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Alterar'
          TabOrder = 0
          OnClick = ButtonAlterarClick
        end
        object ButtonGravar: TButton
          Left = 607
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Gravar'
          TabOrder = 1
          OnClick = ButtonGravarClick
        end
        object ButtonCancelar: TButton
          Left = 688
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = ButtonCancelarClick
        end
      end
    end
  end
  object DataSourcePesq: TDataSource
    DataSet = DmCliente.fdPesquisar
    Left = 388
    Top = 34
  end
end
