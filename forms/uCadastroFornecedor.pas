unit uCadastroFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.UITypes, Math;

type
  TfrmFornecedor = class(TfrmPadrao)
    edtNomeFantasia: TLabeledEdit;
    edtRazaoSocial: TLabeledEdit;
    edtCNPJ: TLabeledEdit;
    cbxAtivo: TCheckBox;
    procedure FormCreate(Sender: TObject);
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  public

  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses uPrincipal, uEntidade, uFornecedor;

{$R *.dfm}

{ TfrmFornecedor }

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
   inherited;
   Entidade := TFornecedor.Create(frmPrincipal.Conexao, 'Fornecedor', 'NomeFantasia');
end;

procedure TfrmFornecedor.AtivarCampos(Ativo: Boolean);
begin
   inherited;
   edtNomeFantasia.ReadOnly := not Ativo;
   edtRazaoSocial.ReadOnly  := not Ativo;
   edtCNPJ.ReadOnly         := not Ativo;
   cbxAtivo.Enabled         := Ativo;
end;

procedure TfrmFornecedor.LimparCampos;
begin
   inherited;
   edtNomeFantasia.Clear;
   edtRazaoSocial.Clear;
   edtCNPJ.Clear;
   cbxAtivo.Checked := False;
end;

procedure TfrmFornecedor.PreencherCampos;
begin
   inherited;
   if EntidadeData = nil then
      Exit;
   edtNomeFantasia.Text := TFornecedorData(EntidadeData).NomeFantasia;
   edtRazaoSocial.Text  := TFornecedorData(EntidadeData).RazaoSocial;
   edtCNPJ.Text         := TFornecedorData(EntidadeData).CNPJ;
   cbxAtivo.Checked     := TFornecedorData(EntidadeData).Ativo;
end;

procedure TfrmFornecedor.SalvarDados;
var
   fornecedor: TFornecedorData;
begin
   fornecedor := TFornecedorData.Create;
   fornecedor.Codigo       := StrToIntDef(edtCodigo.Text, 0);
   fornecedor.NomeFantasia := edtNomeFantasia.Text;
   fornecedor.RazaoSocial  := edtRazaoSocial.Text;
   fornecedor.CNPJ         := edtCNPJ.Text;
   fornecedor.Ativo        := cbxAtivo.Checked;

   Entidade.Salvar(TEntidadeData(fornecedor));
   EntidadeData := fornecedor;
end;

end.
