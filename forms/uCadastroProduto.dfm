inherited frmProduto: TfrmProduto
  Caption = 'Produto'
  ClientHeight = 137
  OnCreate = FormCreate
  ExplicitHeight = 166
  PixelsPerInch = 96
  TextHeight = 13
  object lblFornecedor: TLabel [0]
    Left = 143
    Top = 80
    Width = 55
    Height = 13
    Caption = 'Fornecedor'
  end
  object edtDescricao: TLabeledEdit
    Left = 143
    Top = 56
    Width = 286
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 100
    ReadOnly = True
    TabOrder = 2
  end
  object edtPreco: TLabeledEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Pre'#231'o'
    MaxLength = 14
    ReadOnly = True
    TabOrder = 3
  end
  object cbxAtivo: TCheckBox
    Left = 304
    Top = 98
    Width = 97
    Height = 17
    Caption = 'Ativo'
    Enabled = False
    TabOrder = 5
  end
  object cmbFornecedor: TComboBox
    Left = 143
    Top = 96
    Width = 145
    Height = 21
    Enabled = False
    TabOrder = 4
  end
end
