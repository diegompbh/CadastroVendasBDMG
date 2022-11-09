unit uProduto;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, Classes, uEntidade, uFornecedor;

type

   TProdutoData = class(TEntidadeData)
   public
      CodigoFornecedor: Integer;
      Fornecedor: TFornecedorData;
      Descricao: String;
      Preco: Currency;
      Ativo: Boolean;
   end;

   TProduto = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
      procedure ValidarObjeto(Entidade: TEntidadeData); override;
      function CarregarObjeto: TEntidadeData; override;
   public
      function CarregarProdutos: TList;
   end;

implementation

{ TProduto }

procedure TProduto.Inserir(var Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' insert into Produto                                    '
                   + ' values (:CodigoFornecedor, :Descricao, :Preco, :Ativo) '
                   + ' select CodigoProduto = SCOPE_IDENTITY()                ';

   try
      try
         Query.Parameters.ParamByName('CodigoFornecedor').Value := TProdutoData(Entidade).CodigoFornecedor;
         Query.Parameters.ParamByName('Descricao').Value        := TProdutoData(Entidade).Descricao;
         Query.Parameters.ParamByName('Preco').Value            := TProdutoData(Entidade).Preco;
         Query.Parameters.ParamByName('Ativo').Value            := TProdutoData(Entidade).Ativo;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoProduto').AsInteger;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao inserir produto.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TProduto.Atualizar(Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' update Produto set                       '
                   + '    CodigoFornecedor = :CodigoFornecedor, '
                   + '    Descricao        = :Descricao,        '
                   + '    Preco            = :Preco,            '
                   + '    Ativo            = :Ativo             '
                   + ' where CodigoProduto = :CodigoProduto     ';

   try
      Query.Parameters.ParamByName('CodigoProduto').Value    := TProdutoData(Entidade).Codigo;
      Query.Parameters.ParamByName('CodigoFornecedor').Value := TProdutoData(Entidade).CodigoFornecedor;
      Query.Parameters.ParamByName('Descricao').Value        := TProdutoData(Entidade).Descricao;
      Query.Parameters.ParamByName('Preco').Value            := TProdutoData(Entidade).Preco;
      Query.Parameters.ParamByName('Ativo').Value            := TProdutoData(Entidade).Ativo;
      Query.ExecSQL;
   except
      on E: Exception do
         Raise Exception.Create('Erro ao atualizar produto.');
   end;
end;

function TProduto.CarregarObjeto: TEntidadeData;
begin
   Result := TProdutoData.Create;

   if Query.IsEmpty then
      Result.Codigo := 0
   else
   begin
      Result.Codigo                         := Query.FieldByName('CodigoProduto').AsInteger;
      TProdutoData(Result).CodigoFornecedor := Query.FieldByName('CodigoFornecedor').AsInteger;
      TProdutoData(Result).Descricao        := Query.FieldByName('Descricao').AsString;
      TProdutoData(Result).Preco            := Query.FieldByName('Preco').AsCurrency;
      TProdutoData(Result).Ativo            := Query.FieldByName('Ativo').AsBoolean;
   end;
end;

procedure TProduto.ValidarObjeto(Entidade: TEntidadeData);
begin
   inherited;
   if Trim(TProdutoData(Entidade).Descricao) = EmptyStr then
      Raise TValidacaoException.Create('É necessário preencher o nome do produto!');

   if TProdutoData(Entidade).Preco <= 0 then
      Raise TValidacaoException.Create('O valor do produto deve ser maior do que R$ 0,00!');

   if (TProdutoData(Entidade).CodigoFornecedor = 0) or (TProdutoData(Entidade).Fornecedor = nil) then
      Raise TValidacaoException.Create('É necessário selecionar um fornecedor!');

   if not TProdutoData(Entidade).Fornecedor.Ativo then
      Raise TValidacaoException.Create('O fornecedor selecionado não está ativo!');
end;

function TProduto.CarregarProdutos: TList;
var
   ProdutoData: TProdutoData;
begin
   Result := TList.Create;

   Query.SQL.Text := ' select CodigoProduto, CodigoFornecedor, Descricao, Preco, Ativo '
                   + ' from Produto                                                    '
                   + ' order by Descricao                                              ';

   try
      try
         Query.Open;

         while not Query.Eof do
         begin
            ProdutoData := TProdutoData.Create;
            ProdutoData.Codigo           := Query.FieldByName('CodigoProduto').AsInteger;
            ProdutoData.CodigoFornecedor := Query.FieldByName('CodigoFornecedor').AsInteger;
            ProdutoData.Descricao        := Query.FieldByName('Descricao').AsString;
            ProdutoData.Preco            := Query.FieldByName('Preco').AsCurrency;
            ProdutoData.Ativo            := Query.FieldByName('Ativo').AsBoolean;

            Result.Add(ProdutoData);

            Query.Next;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar produtos.');
      end;
   finally
      Query.Close;
   end;
end;

end.
