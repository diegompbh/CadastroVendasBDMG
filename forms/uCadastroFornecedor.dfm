inherited frmFornecedor: TfrmFornecedor
  Caption = 'Fornecedor'
  ClientHeight = 148
  OnCreate = FormCreate
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 13
  object edtNomeFantasia: TLabeledEdit
    Left = 143
    Top = 56
    Width = 286
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome Fantasia'
    MaxLength = 100
    ReadOnly = True
    TabOrder = 2
  end
  object edtRazaoSocial: TLabeledEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'Raz'#227'o Social'
    MaxLength = 100
    ReadOnly = True
    TabOrder = 3
  end
  object edtCNPJ: TLabeledEdit
    Left = 143
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'CNPJ'
    MaxLength = 14
    ReadOnly = True
    TabOrder = 4
  end
  object cbxAtivo: TCheckBox
    Left = 288
    Top = 98
    Width = 97
    Height = 17
    Caption = 'Ativo'
    Enabled = False
    TabOrder = 5
  end
end
