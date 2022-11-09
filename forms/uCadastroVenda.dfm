inherited frmVenda: TfrmVenda
  Caption = 'Venda'
  ClientHeight = 382
  ClientWidth = 494
  OnCreate = FormCreate
  ExplicitWidth = 500
  ExplicitHeight = 411
  PixelsPerInch = 96
  TextHeight = 13
  object lblCliente: TLabel [0]
    Left = 16
    Top = 93
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  inherited ToolBar1: TToolBar
    Width = 494
    ExplicitWidth = 494
    object btnEfetivar: TToolButton
      Left = 138
      Top = 0
      Hint = 'Efetivar Venda'
      Caption = 'btnEfetivar'
      Enabled = False
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = btnEfetivarClick
    end
  end
  inherited edtCodigo: TLabeledEdit
    Top = 69
    EditLabel.ExplicitLeft = 16
    EditLabel.ExplicitTop = 53
    EditLabel.ExplicitWidth = 33
    ExplicitTop = 69
  end
  object edtDataHora: TLabeledEdit
    Left = 143
    Top = 69
    Width = 202
    Height = 21
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'Data Hora'
    ReadOnly = True
    TabOrder = 2
  end
  object cmbCliente: TComboBox
    Left = 16
    Top = 109
    Width = 221
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object rgpStatus: TRadioGroup
    Left = 360
    Top = 39
    Width = 117
    Height = 92
    Caption = 'Status'
    Enabled = False
    Items.Strings = (
      'Pendente'
      'Efetivada')
    TabOrder = 5
  end
  object grpProdutos: TGroupBox
    Left = 16
    Top = 137
    Width = 461
    Height = 234
    Caption = 'Produtos'
    TabOrder = 6
    object lblProduto: TLabel
      Left = 5
      Top = 42
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object lsvProdutos: TListView
      Left = 2
      Top = 82
      Width = 457
      Height = 150
      Align = alBottom
      Columns = <
        item
          Width = 25
        end
        item
          Caption = 'CodigoVendaProduto'
          Width = 0
        end
        item
          Caption = 'CodigoProduto'
          Width = 0
        end
        item
          Caption = 'Produto'
          Width = 170
        end
        item
          Caption = 'Quantidade'
          Width = 70
        end
        item
          Caption = 'Pre'#231'o'
          Width = 80
        end
        item
          Caption = 'Total'
          Width = 80
        end>
      ReadOnly = True
      RowSelect = True
      StateImages = frmPrincipal.Imagens
      TabOrder = 4
      ViewStyle = vsReport
      OnClick = lsvProdutosClick
    end
    object ToolBar2: TToolBar
      Left = 2
      Top = 15
      Width = 457
      Height = 29
      Caption = 'ToolBar1'
      Images = frmPrincipal.Imagens
      TabOrder = 0
      object btnNovoItem: TToolButton
        Left = 0
        Top = 0
        Hint = 'Novo'
        Caption = 'btnNovo'
        Enabled = False
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
      end
      object btnEditarItem: TToolButton
        Left = 23
        Top = 0
        Hint = 'Editar'
        Caption = 'btnEditar'
        Enabled = False
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
      end
      object btnExcluirItem: TToolButton
        Left = 46
        Top = 0
        Hint = 'Excluir'
        Caption = 'btnExcluir'
        Enabled = False
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
      end
      object btnSalvarItem: TToolButton
        Left = 69
        Top = 0
        Hint = 'Salvar'
        Caption = 'btnSalvar'
        Enabled = False
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = btnSalvarItemClick
      end
      object btnCancelarItem: TToolButton
        Left = 92
        Top = 0
        Hint = 'Cancelar'
        Caption = 'btnCancelar'
        Enabled = False
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
      end
    end
    object cmbProduto: TComboBox
      Left = 5
      Top = 58
      Width = 245
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object edtPreco: TLabeledEdit
      Left = 256
      Top = 58
      Width = 102
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Pre'#231'o'
      MaxLength = 14
      ReadOnly = True
      TabOrder = 2
    end
    object edtQuantidade: TLabeledEdit
      Left = 363
      Top = 58
      Width = 93
      Height = 21
      EditLabel.Width = 56
      EditLabel.Height = 13
      EditLabel.Caption = 'Quantidade'
      MaxLength = 14
      ReadOnly = True
      TabOrder = 3
    end
  end
  object edtTotal: TLabeledEdit
    Left = 243
    Top = 109
    Width = 102
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Total'
    MaxLength = 14
    ReadOnly = True
    TabOrder = 4
  end
end
