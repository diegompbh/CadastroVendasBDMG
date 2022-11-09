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
    procedure FormCreate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    function RemoverMascara(Valor: String): Double;
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

uses uPrincipal, uEntidade, uProduto, uFornecedor;

{$R *.dfm}

procedure TfrmProduto.btnSalvarClick(Sender: TObject);
begin
   if RemoverMascara(edtPreco.Text) <= 0 then
   begin
      MessageDlg('O valor do produto deve ser maior do que R$ 0,00!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if cmbFornecedor.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um fornecedor!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if not TFornecedorData(cmbFornecedor.Items.Objects[cmbFornecedor.ItemIndex]).Ativo then
   begin
      MessageDlg('O fornecedor selecionado não está ativo!', mtWarning, [mbOk], 0);
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
   Entidade := TProduto.Create(frmPrincipal.Conexao, 'Produto');

   try
      Fornecedor := TFornecedor.Create(frmPrincipal.Conexao, 'Fornecedor');
      Fornecedores := Fornecedor.CarregarFornecedores;

      for FornecedorData in Fornecedores do
         cmbFornecedor.AddItem(FornecedorData.NomeFantasia, FornecedorData);
   finally
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
   cbxAtivo.Checked := False;
end;

procedure TfrmProduto.PreencherCampos;
var
   i: Integer;
begin
   if EntidadeData = nil then
      Exit;
   inherited;
   edtDescricao.Text := TProdutoData(EntidadeData).Descricao;
   edtPreco.Text     := FormatFloat('R$ #,##0.00', TProdutoData(EntidadeData).Preco);
   cbxAtivo.Checked  := TProdutoData(EntidadeData).Ativo;

   for i := 0 to cmbFornecedor.Items.Count - 1 do
   begin
      if TFornecedorData(cmbFornecedor.Items.Objects[i]).Codigo =  TProdutoData(EntidadeData).CodigoFornecedor then
         cmbFornecedor.ItemIndex := i;
   end;
end;

function TfrmProduto.RemoverMascara(Valor: String): Double;
begin
   Valor := StringReplace(Valor, 'R', '', [rfReplaceAll]);
   Valor := StringReplace(Valor, '$', '', [rfReplaceAll]);
   Valor := StringReplace(Valor, ' ', '', [rfReplaceAll]);

   Result := StrToCurrDef(Valor, 0);
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
   produto.Ativo            := cbxAtivo.Checked;

   Entidade.Salvar(TEntidadeData(produto));
   EntidadeData := produto;
end;

end.
