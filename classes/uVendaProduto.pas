unit uVendaProduto;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, Classes, uEntidade, uProduto;

type

   TVendaProdutoData = class(TEntidadeData)
   public
      CodigoVenda: Integer;
      CodigoProduto: Integer;
      DescricaoProduto: String;
      Produto: TProdutoData;
      Quantidade: Integer;
      Preco: Double;
      Excluir: Boolean;
   end;

   TVendaProduto = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
      procedure ValidarObjeto(Entidade: TEntidadeData); override;
      function CarregarObjeto: TEntidadeData; override;
   public
      function CarregarProdutos(CodigoVenda: Integer): TList;
   end;

implementation

{ TVendaProduto }

procedure TVendaProduto.Inserir(var Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' insert into VendaProduto                                   '
                   + ' values (:CodigoVenda, :CodigoProduto, :Quantidade, :Preco) '
                   + ' select CodigoVendaProduto = SCOPE_IDENTITY()               ';

   try
      try
         Query.Parameters.ParamByName('CodigoVenda').Value   := TVendaProdutoData(Entidade).CodigoVenda;
         Query.Parameters.ParamByName('CodigoProduto').Value := TVendaProdutoData(Entidade).CodigoProduto;
         Query.Parameters.ParamByName('Quantidade').Value    := TVendaProdutoData(Entidade).Quantidade;
         Query.Parameters.ParamByName('Preco').Value         := TVendaProdutoData(Entidade).Preco;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoVendaProduto').AsInteger;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao inserir produto da venda.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TVendaProduto.Atualizar(Entidade: TEntidadeData);
begin
   if TVendaProdutoData(Entidade).Excluir then
   begin
      Excluir(Entidade.Codigo);
      Exit;
   end;

   Query.SQL.Text := ' update VendaProduto set                        '
                   + '    Quantidade = :Quantidade,                   '
                   + '    Preco      = :Preco                         '
                   + ' where CodigoVendaProduto = :CodigoVendaProduto ';

   try
      try
         Query.Parameters.ParamByName('CodigoVendaProduto').Value := Entidade.Codigo;
         Query.Parameters.ParamByName('Quantidade').Value         := TVendaProdutoData(Entidade).Quantidade;
         Query.Parameters.ParamByName('Preco').Value              := TVendaProdutoData(Entidade).Preco;
         Query.ExecSQL;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar produto da venda.');
      end;
   finally
      Query.Close;
   end;

end;

function TVendaProduto.CarregarObjeto: TEntidadeData;
begin
   Result := TVendaProdutoData.Create;

   if Query.IsEmpty then
      Result.Codigo := 0
   else
   begin
      Result.Codigo                            := Query.FieldByName('CodigoVendaProduto').AsInteger;
      TVendaProdutoData(Result).CodigoVenda    := Query.FieldByName('CodigoVenda').AsInteger;
      TVendaProdutoData(Result).CodigoProduto  := Query.FieldByName('CodigoProduto').AsInteger;
      TVendaProdutoData(Result).Quantidade     := Query.FieldByName('Quantidade').AsInteger;
      TVendaProdutoData(Result).Preco          := Query.FieldByName('Preco').AsCurrency;
   end;
end;

procedure TVendaProduto.ValidarObjeto(Entidade: TEntidadeData);
begin
   inherited;
   if TVendaProdutoData(Entidade).CodigoVenda = 0 then
      Raise TValidacaoException.Create('Venda inválida!');

   if (TVendaProdutoData(Entidade).CodigoProduto = 0) or (TVendaProdutoData(Entidade).Produto = nil) then
      Raise TValidacaoException.Create('É necessário selecionar um produto!');

   if not TVendaProdutoData(Entidade).Produto.Ativo then
      Raise TValidacaoException.Create('O produto ' + TVendaProdutoData(Entidade).Produto.Descricao + ' não está ativo!');

   if TVendaProdutoData(Entidade).Quantidade <= 0 then
      Raise TValidacaoException.Create('A quantidade do produto ' + TVendaProdutoData(Entidade).Produto.Descricao + ' deve ser maior do que 0!');

   if TVendaProdutoData(Entidade).Preco <= 0 then
      Raise TValidacaoException.Create('O valor do produto ' + TVendaProdutoData(Entidade).Produto.Descricao + ' deve ser maior do que R$ 0,00!');
end;

function TVendaProduto.CarregarProdutos(CodigoVenda: Integer): TList;
var
   VendaProdutoData: TVendaProdutoData;
begin
   Result := TList.Create;

   Query.SQL.Text := ' select V.CodigoVendaProduto, V.CodigoVenda, V.CodigoProduto, '
                   + '        V.Quantidade, V.Preco, P.Descricao                    '
                   + ' from VendaProduto V                                          '
                   + ' inner join Produto  P on P.CodigoProduto = V.CodigoProduto   '
                   + ' where V.CodigoVenda = :CodigoVenda                           ';

   try
      try
         Query.Parameters.ParamByName('CodigoVenda').Value := CodigoVenda;
         Query.Open;

         while not Query.Eof do
         begin
            VendaProdutoData := TVendaProdutoData.Create;
            VendaProdutoData.Codigo           := Query.FieldByName('CodigoVendaProduto').AsInteger;
            VendaProdutoData.CodigoVenda      := Query.FieldByName('CodigoVenda').AsInteger;
            VendaProdutoData.DescricaoProduto := Query.FieldByName('Descricao').AsString;
            VendaProdutoData.CodigoProduto    := Query.FieldByName('CodigoProduto').AsInteger;
            VendaProdutoData.Quantidade       := Query.FieldByName('Quantidade').AsInteger;
            VendaProdutoData.Preco            := Query.FieldByName('Preco').AsCurrency;

            Result.Add(VendaProdutoData);

            Query.Next;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar produtos da venda.');
      end;
   finally
      Query.Close;
   end;
end;

end.
