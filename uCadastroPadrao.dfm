object frmPadrao: TfrmPadrao
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Padr'#227'o'
  ClientHeight = 211
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 457
    Height = 29
    Caption = 'ToolBar1'
    Images = frmPrincipal.ImageList1
    TabOrder = 0
    ExplicitWidth = 447
    object btnNovo: TToolButton
      Left = 0
      Top = 0
      Hint = 'Novo'
      Caption = 'btnNovo'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = btnNovoClick
    end
    object btnEditar: TToolButton
      Left = 23
      Top = 0
      Hint = 'Editar'
      Caption = 'btnEditar'
      Enabled = False
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = btnEditarClick
    end
    object btnExcluir: TToolButton
      Left = 46
      Top = 0
      Hint = 'Excluir'
      Caption = 'btnExcluir'
      Enabled = False
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnExcluirClick
    end
    object btnSalvar: TToolButton
      Left = 69
      Top = 0
      Hint = 'Salvar'
      Caption = 'btnSalvar'
      Enabled = False
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSalvarClick
    end
    object btnCancelar: TToolButton
      Left = 92
      Top = 0
      Hint = 'Cancelar'
      Caption = 'btnCancelar'
      Enabled = False
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCancelarClick
    end
    object btnPesquisar: TToolButton
      Left = 115
      Top = 0
      Hint = 'Pesquisar'
      Caption = 'btnPesquisar'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPesquisarClick
    end
  end
  object edtCodigo: TLabeledEdit
    Left = 16
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo'
    ReadOnly = True
    TabOrder = 1
  end
end
