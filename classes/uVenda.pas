unit uVenda;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, Classes,
     uEntidade, uCliente, uProduto, uVendaProduto;

type
   TVendaData = class(TEntidadeData)
   private
      function GetValorTotal: Double;
   public
      CodigoCliente: Integer;
      Cliente: TClienteData;
      DataHora: TDateTime;
      Status: Boolean;
      Produtos: TList;
      property ValorTotal: Double read GetValorTotal;
   end;

   TVenda = class(TEntidade)
   private
      procedure SalvarProdutos(Produtos: TList; CodigoVenda: Integer);
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
      procedure Excluir(Codigo: Integer); override;
      procedure ValidarObjeto(Entidade: TEntidadeData); override;
      function CarregarObjeto: TEntidadeData; override;
   public
      procedure EfetivarVenda(CodigoVenda: Integer);
   end;

implementation

{ TVendaData }

function TVendaData.GetValorTotal: Double;
var
   i: Integer;
   ProdutoData: TVendaProdutoData;
begin
   Result := 0;
   if Produtos = nil then
      Exit;

   for i := 0 to Produtos.Count -1 do
   begin
      ProdutoData := TVendaProdutoData(Produtos[i]);
      Result := Result + (ProdutoData.Quantidade * ProdutoData.Preco);
   end;
end;

{ TVenda }

procedure TVenda.Inserir(var Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' insert into Venda (CodigoCliente)          '
                   + ' values (:CodigoCliente)                    '
                   + ' select CodigoFornecedor = SCOPE_IDENTITY() ';

   try
      try
         Query.Parameters.ParamByName('CodigoCliente').Value := TVendaData(Entidade).CodigoCliente;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoFornecedor').AsInteger;

         SalvarProdutos(TVendaData(Entidade).Produtos, Entidade.Codigo);
      except
         on E: Exception do
            Raise Exception.Create('Erro ao inserir venda.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TVenda.Atualizar(Entidade: TEntidadeData);
begin
   try
      try
         SalvarProdutos(TVendaData(Entidade).Produtos, Entidade.Codigo);
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar venda.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TVenda.EfetivarVenda(CodigoVenda: Integer);
begin
   Query.SQL.Text := ' update Venda set Status = 1 where CodigoVenda = :CodigoVenda ';

   try
      try
         Query.Parameters.ParamByName('CodigoVenda').Value := CodigoVenda;
         Query.ExecSQL;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao efetivar venda.');
      end;
   finally
      Query.Close;
   end;
end;

function TVenda.CarregarObjeto: TEntidadeData;
var
   VendaProduto: TVendaProduto;
begin
   Result := TVendaData.Create;

   if Query.IsEmpty then
      Result.Codigo := 0
   else
   begin
      try
         VendaProduto := TVendaProduto.Create(Query.Connection, 'VendaProduto', EmptyStr);

         Result.Codigo                    := Query.FieldByName('CodigoVenda').AsInteger;
         TVendaData(Result).CodigoCliente := Query.FieldByName('CodigoCliente').AsInteger;
         TVendaData(Result).DataHora      := Query.FieldByName('DataHora').AsDateTime;
         TVendaData(Result).Status        := Query.FieldByName('Status').AsBoolean;
         TVendaData(Result).Produtos      := VendaProduto.CarregarProdutos(Result.Codigo)
      finally
         FreeAndNil(VendaProduto);
      end;
   end;
end;

procedure TVenda.Excluir(Codigo: Integer);
begin
   Query.SQL.Text := ' delete from VendaProduto where CodigoVenda = :CodigoVenda';

   try
      Query.Parameters.ParamByName('CodigoVenda').Value := Codigo;
      Query.ExecSQL;
   except
      on E: Exception do
         Raise Exception.Create('Erro ao excluir registro.');
   end;
   inherited;
end;

procedure TVenda.ValidarObjeto(Entidade: TEntidadeData);
begin
   inherited;
   if (TVendaData(Entidade).CodigoCliente = 0) or (TVendaData(Entidade).Cliente = nil) then
      Raise TValidacaoException.Create('É necessário selecionar um cliente!');

   if not TVendaData(Entidade).Cliente.Ativo then
      Raise TValidacaoException.Create('O cliente selecionado não está ativo!');

   if (TVendaData(Entidade).Produtos = nil) or (TVendaData(Entidade).Produtos.Count = 0) then
      Raise TValidacaoException.Create('É necessário selecionar pelo menos um produto!');
end;

procedure TVenda.SalvarProdutos(Produtos: TList; CodigoVenda: Integer);
var
   i: Integer;
   VendaProduto: TVendaProduto;
   ProdutoData: TVendaProdutoData;
begin
   try
      VendaProduto := TVendaProduto.Create(Query.Connection, 'VendaProduto', EmptyStr);
      for i := 0 to Produtos.Count -1 do
      begin
         ProdutoData := TVendaProdutoData(Produtos[i]);
         ProdutoData.CodigoVenda := CodigoVenda;
         VendaProduto.Salvar(TEntidadeData(ProdutoData));
      end;
   finally
      FreeAndNil(VendaProduto);
   end;
end;

end.
