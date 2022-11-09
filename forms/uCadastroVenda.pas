unit uCadastroVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls, Math,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmVenda = class(TfrmPadrao)
    edtDataHora: TLabeledEdit;
    lblCliente: TLabel;
    cmbCliente: TComboBox;
    rgpStatus: TRadioGroup;
    grpProdutos: TGroupBox;
    lsvProdutos: TListView;
    ToolBar2: TToolBar;
    btnNovoItem: TToolButton;
    btnEditarItem: TToolButton;
    btnExcluirItem: TToolButton;
    btnSalvarItem: TToolButton;
    btnCancelarItem: TToolButton;
    lblProduto: TLabel;
    cmbProduto: TComboBox;
    edtPreco: TLabeledEdit;
    edtQuantidade: TLabeledEdit;
    edtTotal: TLabeledEdit;
    btnEfetivar: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure lsvProdutosClick(Sender: TObject);
    procedure btnSalvarItemClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnEfetivarClick(Sender: TObject);
  protected
    procedure AtivarCampos(Ativo: Boolean); override;
    procedure LimparCampos; override;
    procedure PreencherCampos; override;
    procedure SalvarDados; override;
  end;

var
  frmVenda: TfrmVenda;

const
   cCodigoVendaProduto = 0;
   cCodigoProduto = 1;
   cProduto = 2;
   cQuantidade = 3;
   cPreco = 4;
   cTotal = 5;

implementation

uses uPrincipal, uUtils, uEntidade, uCliente, uProduto, uVenda, uVendaProduto;

{$R *.dfm}

{ TfrmVenda }

procedure TfrmVenda.btnEfetivarClick(Sender: TObject);
begin
   inherited;
   if (EntidadeData = nil) or (EntidadeData.Codigo = 0) then
      Exit;

   TVenda(Entidade).EfetivarVenda(EntidadeData.Codigo);
   rgpStatus.ItemIndex := 1;
end;

procedure TfrmVenda.btnSalvarClick(Sender: TObject);
begin
   if cmbCliente.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um cliente!', mtWarning, [mbOk], 0);
      Abort;
   end;

   inherited;
end;

procedure TfrmVenda.btnSalvarItemClick(Sender: TObject);
var
   i: Integer;
begin
   if cmbProduto.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um produto!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if StrToFloatDef(edtPreco.Text, 0) <= 0 then
   begin
      MessageDlg('O valor do produto deve ser maior do que R$ 0,00!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if StrToIntDef(edtQuantidade.Text, 0) <= 0 then
   begin
      MessageDlg('A quantidade deve ser maior do que 0!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if cmbProduto.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um produto!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if not TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Ativo then
   begin
      MessageDlg('O produto selecionado não está ativo!', mtWarning, [mbOk], 0);
      Abort;
   end;

   for i := 0 to lsvProdutos.Items.Count -1 do
   begin
      if IntToStr(TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Codigo) = lsvProdutos.Items[i].SubItems[cCodigoProduto] then
      begin
         MessageDlg('Produto já adicionado a esta compra.', mtWarning, [mbOk], 0);
         Abort;
      end;
   end;

   inherited;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
var
   Clientes: TList;
   ClienteData: TClienteData;
   Cliente: TCliente;
   Produtos: TList;
   ProdutoData: TProdutoData;
   Produto: TProduto;
begin
   inherited;
   Entidade := TVenda.Create(frmPrincipal.Conexao, 'Venda', EmptyStr);

   try
      Cliente := TCliente.Create(frmPrincipal.Conexao, 'Cliente', 'Nome');
      Clientes := Cliente.CarregarClientes;

      for ClienteData in Clientes do
         cmbCliente.AddItem(ClienteData.Nome, ClienteData);

      Produto := TProduto.Create(frmPrincipal.Conexao, 'Produto', 'Descricao');
      Produtos := Produto.CarregarProdutos;

      for ProdutoData in Produtos do
         cmbProduto.AddItem(ProdutoData.Descricao, ProdutoData);
   finally
      FreeAndNil(Cliente);
      FreeAndNil(Clientes);
      FreeAndNil(Produto);
      FreeAndNil(Produtos);
   end;
end;

procedure TfrmVenda.AtivarCampos(Ativo: Boolean);
begin
   inherited;
   btnEditar.Enabled   := btnEditar.Enabled and (rgpStatus.ItemIndex = 0);
   btnExcluir.Enabled  := btnExcluir.Enabled and (rgpStatus.ItemIndex = 0);
   btnEfetivar.Enabled := (not Ativo) and (rgpStatus.ItemIndex = 0);
   cmbCliente.Enabled  := Ativo;
end;

procedure TfrmVenda.LimparCampos;
begin
   inherited;
   edtDataHora.Clear;
   cmbCliente.ItemIndex := -1;
   cmbCliente.Text := EmptyStr;
   rgpStatus.ItemIndex := 0;

   cmbProduto.ItemIndex := -1;
   cmbProduto.Text := EmptyStr;
   edtPreco.Clear;
   edtQuantidade.Clear;
   lsvProdutos.Items.Clear;
end;

procedure TfrmVenda.lsvProdutosClick(Sender: TObject);
var
   i: Integer;
begin
   inherited;
   if lsvProdutos.Selected = nil then
      Exit;

   for i := 0 to cmbProduto.Items.Count - 1 do
   begin
      if TVendaProdutoData(cmbProduto.Items.Objects[i]).Codigo = StrToInt(lsvProdutos.Selected.SubItems[cCodigoProduto]) then
         cmbProduto.ItemIndex := i;
   end;

   edtPreco.Text      := lsvProdutos.Selected.SubItems[cPreco];
   edtQuantidade.Text := lsvProdutos.Selected.SubItems[cQuantidade];
end;

procedure TfrmVenda.PreencherCampos;
var
   i: Integer;
   item: TListItem;
   VendaProdutoData: TVendaProdutoData;
begin
   inherited;
   if EntidadeData = nil then
      Exit;
   edtDataHora.Text    := FormatDateTime('dd/mm/yyyy HH:nn:ss', TVendaData(EntidadeData).DataHora);
   edtTotal.Text       := FormatFloat('R$ #,##0.00', TVendaData(EntidadeData).ValorTotal);
   rgpStatus.ItemIndex := IfThen(TVendaData(EntidadeData).Status, 1, 0);

   for i := 0 to cmbCliente.Items.Count - 1 do
   begin
      if TClienteData(cmbCliente.Items.Objects[i]).Codigo = TVendaData(EntidadeData).CodigoCliente then
         cmbCliente.ItemIndex := i;
   end;

   lsvProdutos.Items.Clear;
   if TVendaData(EntidadeData).Produtos <> nil then
   begin
      for i := 0 to TVendaData(EntidadeData).Produtos.Count - 1 do
      begin
         VendaProdutoData := TVendaProdutoData(TVendaData(EntidadeData).Produtos[i]);

         Item := lsvProdutos.Items.Add;
         Item.Caption := IntToStr(VendaProdutoData.Codigo);
         Item.SubItems.Add(IntToStr(VendaProdutoData.Codigo));
         Item.SubItems.Add(IntToStr(VendaProdutoData.CodigoProduto));
         Item.SubItems.Add(VendaProdutoData.DescricaoProduto);
         Item.SubItems.Add(IntToStr(VendaProdutoData.Quantidade));
         Item.SubItems.Add(FormatFloat('R$ #,##0.00', VendaProdutoData.Preco));
         Item.SubItems.Add(FormatFloat('R$ #,##0.00', VendaProdutoData.Quantidade * VendaProdutoData.Preco));
      end;
   end;
end;

procedure TfrmVenda.SalvarDados;
var
   Venda: TVendaData;
   VendaProduto: TVendaProdutoData;
   Produto: TProduto;
   i: Integer;
begin
   Venda := TVendaData.Create;
   Venda.Codigo         := StrToIntDef(edtCodigo.Text, 0);
   Venda.CodigoCliente  := TClienteData(cmbCliente.Items.Objects[cmbCliente.ItemIndex]).Codigo;
   Venda.Cliente        := TClienteData(cmbCliente.Items.Objects[cmbCliente.ItemIndex]);
   Venda.DataHora       := Now;
   Venda.Produtos       := TList.Create;

   Produto := TProduto.Create(frmPrincipal.Conexao, 'Produto', 'Descricao');
   for i := 0 to lsvProdutos.Items.Count -1 do
   begin
      VendaProduto := TVendaProdutoData.Create;
      VendaProduto.Codigo           := StrToInt(lsvProdutos.Items[i].SubItems[cCodigoVendaProduto]);
      VendaProduto.CodigoVenda      := Venda.Codigo;
      VendaProduto.CodigoProduto    := StrToInt(lsvProdutos.Items[i].SubItems[cCodigoProduto]);
      VendaProduto.Preco            := RemoverMascara(lsvProdutos.Items[i].SubItems[cPreco]);
      VendaProduto.Quantidade       := StrToIntDef(lsvProdutos.Items[i].SubItems[cQuantidade], 0);
      VendaProduto.Produto          := TProdutoData(Produto.Pesquisar(VendaProduto.CodigoProduto));
      VendaProduto.DescricaoProduto := VendaProduto.Produto.Descricao;

      Venda.Produtos.Add(VendaProduto);
   end;

   Entidade.Salvar(TEntidadeData(Venda));
   EntidadeData := Venda;
end;

end.
