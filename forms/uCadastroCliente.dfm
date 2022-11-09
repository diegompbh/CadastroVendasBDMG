inherited frmCliente: TfrmCliente
  Caption = 'Cliente'
  ClientHeight = 148
  OnCreate = FormCreate
  ExplicitHeight = 177
  PixelsPerInch = 96
  TextHeight = 13
  inherited ToolBar1: TToolBar
    ExplicitWidth = 457
  end
  object edtCPF: TLabeledEdit
    Left = 16
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'CPF'
    MaxLength = 11
    ReadOnly = True
    TabOrder = 3
  end
  object edtNascimento: TLabeledEdit
    Left = 143
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Nascimento'
    MaxLength = 10
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
  object edtNome: TLabeledEdit
    Left = 143
    Top = 56
    Width = 286
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    MaxLength = 100
    ReadOnly = True
    TabOrder = 2
  end
end
