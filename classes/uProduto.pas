unit uProduto;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, uEntidade;

type

   TProdutoData = class(TEntidadeData)
   public
      CodigoFornecedor: Integer;
      Descricao: String;
      Preco: Currency;
      Ativo: Boolean;
   end;

   TProduto = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
   public
      function Pesquisar(Codigo: Integer): TEntidadeData; override;
      function Pesquisar(Pesquisa: String): TEntidadeData; override;
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
            Raise Exception.Create('Erro ao atualizar produto.');
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
      Query.Parameters.ParamByName('CodigoFornecedor').Value := TProdutoData(Entidade).CodigoFornecedor;
      Query.Parameters.ParamByName('Descricao').Value        := TProdutoData(Entidade).Descricao;
      Query.Parameters.ParamByName('Preco').Value            := TProdutoData(Entidade).Preco;
      Query.Parameters.ParamByName('Ativo').Value            := TProdutoData(Entidade).Ativo;
      Query.Parameters.ParamByName('CodigoProduto').Value    := TProdutoData(Entidade).Codigo;
      Query.ExecSQL;
   except
      on E: Exception do
         Raise Exception.Create('Erro ao atualizar produto.');
   end;
end;

function TProduto.Pesquisar(Codigo: Integer): TEntidadeData;
begin
   inherited;
   Result := TProdutoData.Create;
   Query.SQL.Text := ' select CodigoFornecedor, Descricao, Preco, Ativo '
                   + ' from Produto                                     '
                   + ' where CodigoProduto = :CodigoProduto             ';
   try
      try
         Query.Parameters.ParamByName('CodigoProduto').Value := Codigo;
         Query.Open;

         if Query.IsEmpty then
            Result.Codigo := 0
         else
         begin
            Result.Codigo                         := Codigo;
            TProdutoData(Result).CodigoFornecedor := Query.FieldByName('CodigoFornecedor').AsInteger;
            TProdutoData(Result).Descricao        := Query.FieldByName('Descricao').AsString;
            TProdutoData(Result).Preco            := Query.FieldByName('Preco').AsFloat;
            TProdutoData(Result).Ativo            := Query.FieldByName('Ativo').AsBoolean;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar produto.');
      end;
   finally
      Query.Close;
   end;
end;

function TProduto.Pesquisar(Pesquisa: String): TEntidadeData;
begin
   inherited;
   Result := TProdutoData.Create;
   Query.SQL.Text := ' select CodigoProduto, CodigoFornecedor, Descricao, Preco, Ativo '
                   + ' from Produto                                                    '
                   + ' where Descricao like ''%' + Pesquisa + '%''                     ';

   try
      try
         Query.Open;

         if Query.IsEmpty then
            Result.Codigo := 0
         else
         begin
            Result.Codigo                         := Query.FieldByName('CodigoProduto').AsInteger;
            TProdutoData(Result).CodigoFornecedor := Query.FieldByName('CodigoFornecedor').AsInteger;
            TProdutoData(Result).Descricao        := Query.FieldByName('Descricao').AsString;
            TProdutoData(Result).Preco            := Query.FieldByName('Preco').AsFloat;
            TProdutoData(Result).Ativo            := Query.FieldByName('Ativo').AsBoolean;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar produto.');
      end;
   finally
      Query.Close;
   end;
end;

end.
