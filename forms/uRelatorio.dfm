object frmRelatorio: TfrmRelatorio
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Relat'#243'rios'
  ClientHeight = 418
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcRelatorios: TPageControl
    Left = 0
    Top = 0
    Width = 719
    Height = 418
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Clientes ativos'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 711
        Height = 33
        Align = alTop
        TabOrder = 0
        DesignSize = (
          711
          33)
        object SpeedButton1: TSpeedButton
          Left = 642
          Top = 4
          Width = 62
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Listar'
          ImageIndex = 7
          Images = frmPrincipal.Imagens
          OnClick = SpeedButton1Click
          ExplicitLeft = 530
        end
      end
      object dbgClientesAtivos: TDBGrid
        Left = 0
        Top = 33
        Width = 711
        Height = 357
        Align = alClient
        DataSource = dtsClientesAtivos
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoCliente'
            Title.Caption = 'C'#243'digo Cliente'
            Width = 85
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 360
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Ativo'
            Width = 45
            Visible = True
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Venda efetivadas por cliente'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 711
        Height = 33
        Align = alTop
        TabOrder = 0
        DesignSize = (
          711
          33)
        object SpeedButton2: TSpeedButton
          Left = 642
          Top = 4
          Width = 62
          Height = 22
          Anchors = [akTop, akRight]
          Caption = 'Listar'
          ImageIndex = 7
          Images = frmPrincipal.Imagens
          OnClick = SpeedButton2Click
          ExplicitLeft = 530
        end
        object lblCliente: TLabel
          Left = 7
          Top = 9
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object cmbCliente: TComboBox
          Left = 49
          Top = 6
          Width = 221
          Height = 21
          TabOrder = 0
        end
      end
      object dbgVendasEfetivadasCliente: TDBGrid
        Left = 0
        Top = 33
        Width = 711
        Height = 357
        Align = alClient
        DataSource = dtsVendasEfetivadasCliente
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CodigoVenda'
            Title.Caption = 'C'#243'digo Venda'
            Width = 81
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DataHora'
            Title.Caption = 'Data Hora'
            Width = 128
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descricao'
            Title.Caption = 'Descri'#231#227'o'
            Width = 162
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Preco'
            Title.Caption = 'Pre'#231'o'
            Width = 96
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Total'
            Width = 101
            Visible = True
          end>
      end
    end
  end
  object dtsClientesAtivos: TDataSource
    Left = 148
    Top = 176
  end
  object dtsVendasEfetivadasCliente: TDataSource
    Left = 268
    Top = 176
  end
end
