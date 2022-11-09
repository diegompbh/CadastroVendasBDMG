unit uCadastroVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroPadrao, Vcl.StdCtrls, Math,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, System.UITypes;

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
    procedure btnExcluirItemClick(Sender: TObject);
    procedure btnNovoItemClick(Sender: TObject);
    procedure btnEditarItemClick(Sender: TObject);
    procedure btnCancelarItemClick(Sender: TObject);
  private
    procedure LimparCamposItem;
    procedure AtivarCamposItem(Ativo: Boolean);
    procedure PreencherCamposItem;
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

procedure TfrmVenda.btnCancelarItemClick(Sender: TObject);
begin
   inherited;
   AtivarCamposItem(True);
   LimparCamposItem;
   if lsvProdutos.Selected <> nil then
      PreencherCamposItem;
end;

procedure TfrmVenda.btnEditarItemClick(Sender: TObject);
begin
   inherited;
   AtivarCamposItem(False);
end;

procedure TfrmVenda.btnEfetivarClick(Sender: TObject);
begin
   if MessageDlg('Confirmar efetivação do registro atual?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
   begin
      if (EntidadeData = nil) or (EntidadeData.Codigo = 0) then
         Exit;

      TVenda(Entidade).EfetivarVenda(EntidadeData.Codigo);
      rgpStatus.ItemIndex := 1;
      AtivarCampos(False);
   end;
end;

procedure TfrmVenda.btnExcluirItemClick(Sender: TObject);
begin
   if MessageDlg('Confirmar exclusão do registro atual?', mtConfirmation,[mbYes, mbNo], 0) = mrYes then
   begin
       lsvProdutos.Selected.StateIndex := 4;
       AtivarCamposItem(True);
   end;
end;

procedure TfrmVenda.btnNovoItemClick(Sender: TObject);
begin
   inherited;
   lsvProdutos.Selected := nil;
   LimparCamposItem;
   AtivarCamposItem(False);
end;

procedure TfrmVenda.btnSalvarClick(Sender: TObject);
begin
   if btnSalvarItem.Enabled then
      btnSalvarItem.Click;

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
   Item: TListItem;
begin
   if cmbProduto.ItemIndex = -1 then
   begin
      MessageDlg('É necessário selecionar um produto!', mtWarning, [mbOk], 0);
      Abort;
   end;

   if RemoverMascara(edtPreco.Text) <= 0 then
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
      if lsvProdutos.Selected = lsvProdutos.Items[i] then
         Continue;

      if IntToStr(TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Codigo) = lsvProdutos.Items[i].SubItems[cCodigoProduto] then
      begin
         MessageDlg('Produto já adicionado a esta compra.', mtWarning, [mbOk], 0);
         Abort;
      end;
   end;

   if lsvProdutos.Selected = nil then
   begin
      Item := lsvProdutos.Items.Add;
      Item.Caption := EmptyStr;
      Item.SubItems.Add(EmptyStr);
      Item.SubItems.Add(IntToStr(TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Codigo));
      Item.SubItems.Add(TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Descricao);
      Item.SubItems.Add(edtQuantidade.Text);
      Item.SubItems.Add(FormatFloat('R$ #,##0.00', RemoverMascara(edtPreco.Text)));
      Item.SubItems.Add(FormatFloat('R$ #,##0.00', StrToIntDef(edtQuantidade.Text, 0) * RemoverMascara(edtPreco.Text)));
   end
   else
   begin
      Item := lsvProdutos.Selected;
      Item.SubItems[cProduto]    := TProdutoData(cmbProduto.Items.Objects[cmbProduto.ItemIndex]).Descricao;
      Item.SubItems[cQuantidade] := edtQuantidade.Text;
      Item.SubItems[cPreco]      := FormatFloat('R$ #,##0.00', RemoverMascara(edtPreco.Text));
      Item.SubItems[cTotal]      := FormatFloat('R$ #,##0.00', StrToIntDef(edtQuantidade.Text, 0) * RemoverMascara(edtPreco.Text));
   end;

   AtivarCamposItem(True);
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

   AtivarCamposItem(btnSalvar.Enabled);
end;

procedure TfrmVenda.AtivarCamposItem(Ativo: Boolean);
begin
   Ativo := Ativo and btnSalvar.Enabled;

   btnNovoItem.Enabled     := Ativo;
   btnEditarItem.Enabled   := Ativo and (cmbProduto.ItemIndex > -1) and (lsvProdutos.Selected <> nil) and (lsvProdutos.Selected.StateIndex = -1);
   btnExcluirItem.Enabled  := Ativo and (cmbProduto.ItemIndex > -1) and (lsvProdutos.Selected <> nil) and (lsvProdutos.Selected.StateIndex = -1);
   btnSalvarItem.Enabled   := (not Ativo) and btnSalvar.Enabled;
   btnCancelarItem.Enabled := (not Ativo) and btnSalvar.Enabled;
   cmbProduto.Enabled      := (not Ativo) and btnSalvar.Enabled;
   edtPreco.ReadOnly       := Ativo or (not btnSalvar.Enabled);
   edtQuantidade.ReadOnly  := Ativo or (not btnSalvar.Enabled);
end;

procedure TfrmVenda.LimparCampos;
begin
   inherited;
   edtDataHora.Clear;
   cmbCliente.ItemIndex := -1;
   cmbCliente.Text := EmptyStr;
   edtTotal.Clear;
   rgpStatus.ItemIndex := 0;
   lsvProdutos.Items.Clear;

   LimparCamposItem;
end;

procedure TfrmVenda.LimparCamposItem;
begin
   cmbProduto.ItemIndex := -1;
   cmbProduto.Text := EmptyStr;
   edtPreco.Clear;
   edtQuantidade.Clear;
end;

procedure TfrmVenda.lsvProdutosClick(Sender: TObject);
begin
   inherited;
   PreencherCamposItem;
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

procedure TfrmVenda.PreencherCamposItem;
var
   i: Integer;
begin
   if lsvProdutos.Selected = nil then
      Exit;

   for i := 0 to cmbProduto.Items.Count - 1 do
   begin
      if TVendaProdutoData(cmbProduto.Items.Objects[i]).Codigo = StrToInt(lsvProdutos.Selected.SubItems[cCodigoProduto]) then
         cmbProduto.ItemIndex := i;
   end;

   edtPreco.Text      := lsvProdutos.Selected.SubItems[cPreco];
   edtQuantidade.Text := lsvProdutos.Selected.SubItems[cQuantidade];

   AtivarCamposItem(True);
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
      VendaProduto.Codigo           := StrToIntDef(lsvProdutos.Items[i].SubItems[cCodigoVendaProduto], 0);
      VendaProduto.CodigoVenda      := Venda.Codigo;
      VendaProduto.CodigoProduto    := StrToInt(lsvProdutos.Items[i].SubItems[cCodigoProduto]);
      VendaProduto.Preco            := RemoverMascara(lsvProdutos.Items[i].SubItems[cPreco]);
      VendaProduto.Quantidade       := StrToIntDef(lsvProdutos.Items[i].SubItems[cQuantidade], 0);
      VendaProduto.Produto          := TProdutoData(Produto.Pesquisar(VendaProduto.CodigoProduto));
      VendaProduto.DescricaoProduto := VendaProduto.Produto.Descricao;
      VendaProduto.Excluir          := lsvProdutos.Items[i].StateIndex = 4;

      Venda.Produtos.Add(VendaProduto);
   end;

   Entidade.Salvar(TEntidadeData(Venda));
   EntidadeData := Venda;

   PreencherCampos;
end;

end.
