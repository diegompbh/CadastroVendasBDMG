unit uRelatorios;

interface

uses Data.DB, Data.Win.ADODB;

type
   TRelatorios = class
   public
      class function RetornarClientesAtivos(Conexao: TADOConnection): TADOQuery;
      class function RetornasVendasEfetivadasCliente(Conexao: TADOConnection; CodigoCliente: Integer): TADOQuery;
   end;

implementation

{ TRelatorios }

class function TRelatorios.RetornarClientesAtivos(Conexao: TADOConnection): TADOQuery;
var
   Query: TADOQuery;
begin
   Query := TADOQuery.Create(nil);
   Query.Connection := Conexao;

   Query.SQL.Text := ' select CodigoCliente, Nome,                                   '
                   + '       Ativo = case Ativo when 1 then ''Sim'' else ''Não'' end '
                   + ' from Cliente                                                  '
                   + ' where Ativo = 1                                               '
                   + ' order by Nome                                                 ';
   Query.Open;

   Result := Query;
end;

class function TRelatorios.RetornasVendasEfetivadasCliente(Conexao: TADOConnection; CodigoCliente: Integer): TADOQuery;
var
   Query: TADOQuery;
begin
   Query := TADOQuery.Create(nil);
   Query.Connection := Conexao;

   Query.SQL.Text := ' select Venda.CodigoVenda,                                                '
                   + '        Venda.DataHora,                                                   '
                   + '	      Produto.Descricao,                                                '
                   + '        VendaProduto.Quantidade,                                          '
                   + '        VendaProduto.Preco,                                               '
                   + '        Total = VendaProduto.Quantidade * VendaProduto.Preco              '
                   + ' from Venda                                                               '
                   + ' inner join Cliente on Cliente.CodigoCliente = Venda.CodigoCliente        '
                   + ' inner join VendaProduto on VendaProduto.CodigoVenda = Venda.CodigoVenda  '
                   + ' inner join Produto on Produto.CodigoProduto = VendaProduto.CodigoProduto '
                   + ' where Venda.Status = 1                                                   '
                   + '   and Cliente.CodigoCliente = :CodigoCliente                             '
                   + ' order by Venda.DataHora, Produto.Descricao                               ';

   Query.Parameters.ParamByName('CodigoCliente').Value := CodigoCliente;
   Query.Open;

   Result := Query;
end;

end.
