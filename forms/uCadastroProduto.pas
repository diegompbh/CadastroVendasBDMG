unit uCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.UITypes;

type
  TfrmProduto = class(TfrmPadrao)
    edtDescricao: TLabeledEdit;
    edtPreco: TLabeledEdit;
    cbxAtivo: TCheckBox;
    cmbFornecedor: TComboBox;
    lblFornecedor: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  public

  end;

var
  frmProduto: TfrmProduto;

implementation

uses uPrincipal, uUtils, uEntidade, uProduto, uFornecedor;

{$R *.dfm}

procedure TfrmProduto.btnSalvarClick(Sender: TObject);
begin
   if cmbFornecedor.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um fornecedor!', mtWarning, [mbOk], 0);
      Abort;
   end;

   inherited;
end;

procedure TfrmProduto.FormCreate(Sender: TObject);
var
   Fornecedores: TList;
   FornecedorData: TFornecedorData;
   Fornecedor: TFornecedor;
begin
   inherited;
   Entidade := TProduto.Create(frmPrincipal.Conexao, 'Produto', 'Descricao');

   try
      Fornecedor := TFornecedor.Create(frmPrincipal.Conexao, 'Fornecedor', 'NomeFantasia');
      Fornecedores := Fornecedor.CarregarFornecedores;

      for FornecedorData in Fornecedores do
         cmbFornecedor.AddItem(FornecedorData.NomeFantasia, FornecedorData);
   finally
      FreeAndNil(Fornecedor);
      FreeAndNil(Fornecedores);
   end;
end;

procedure TfrmProduto.AtivarCampos(Ativo: Boolean);
begin
   inherited;
   edtDescricao.ReadOnly  := not Ativo;
   edtPreco.ReadOnly      := not Ativo;
   cmbFornecedor.Enabled  := Ativo;
   cbxAtivo.Enabled       := Ativo;
end;

procedure TfrmProduto.LimparCampos;
begin
   inherited;
   edtDescricao.Clear;
   edtPreco.Clear;
   cmbFornecedor.ItemIndex := -1;
   cmbFornecedor.Text := EmptyStr;
   cbxAtivo.Checked := False;
end;

procedure TfrmProduto.PreencherCampos;
var
   i: Integer;
begin
   inherited;
   if EntidadeData = nil then
      Exit;
   edtDescricao.Text := TProdutoData(EntidadeData).Descricao;
   edtPreco.Text     := FormatFloat('R$ #,##0.00', TProdutoData(EntidadeData).Preco);
   cbxAtivo.Checked  := TProdutoData(EntidadeData).Ativo;

   for i := 0 to cmbFornecedor.Items.Count - 1 do
   begin
      if TFornecedorData(cmbFornecedor.Items.Objects[i]).Codigo =  TProdutoData(EntidadeData).CodigoFornecedor then
         cmbFornecedor.ItemIndex := i;
   end;
end;

procedure TfrmProduto.SalvarDados;
var
   produto: TProdutoData;
begin
   produto := TProdutoData.Create;
   produto.Codigo           := StrToIntDef(edtCodigo.Text, 0);
   produto.Descricao        := edtDescricao.Text;
   produto.Preco            := RemoverMascara(edtPreco.Text);
   produto.CodigoFornecedor := TFornecedorData(cmbFornecedor.Items.Objects[cmbFornecedor.ItemIndex]).Codigo;
   produto.Fornecedor       := TFornecedorData(cmbFornecedor.Items.Objects[cmbFornecedor.ItemIndex]);
   produto.Ativo            := cbxAtivo.Checked;

   Entidade.Salvar(TEntidadeData(produto));
   EntidadeData := produto;
end;

end.
