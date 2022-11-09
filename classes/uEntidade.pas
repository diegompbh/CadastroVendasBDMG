unit uEntidade;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB;

type

   TEntidadeData = class
   public
      Codigo: Integer;
   end;

   TEntidade = class
   protected
      Query: TADOQuery;
      NomeEntidade: String;
      procedure Inserir(var Entidade: TEntidadeData); virtual; abstract;
      procedure Atualizar(Entidade: TEntidadeData); virtual; abstract;
   public
      constructor Create(Conexao: TADOConnection; NomeEntidade: String);
      procedure Salvar(var Entidade: TEntidadeData);
      procedure Excluir(Codigo: Integer);
      function Pesquisar(Codigo: Integer): TEntidadeData; overload; virtual; abstract;
      function Pesquisar(Pesquisa: String): TEntidadeData; overload; virtual; abstract;
   end;

implementation

{ TEntidade }

constructor TEntidade.Create(Conexao: TADOConnection; NomeEntidade: String);
begin
   Query := TADOQuery.Create(nil);
   Query.Connection := Conexao;

   Self.NomeEntidade := NomeEntidade;
end;

procedure TEntidade.Excluir(Codigo: Integer);
begin
   Query.SQL.Text := ' delete from ' + NomeEntidade + ' where Codigo' + NomeEntidade + ' = :Codigo';

   try
      Query.Parameters.ParamByName('Codigo').Value := Codigo;
      Query.ExecSQL;
   except
      on E: Exception do
         Raise Exception.Create('Erro ao excluir registro.');
   end;
end;

procedure TEntidade.Salvar(var Entidade: TEntidadeData);
begin
   try
      if Entidade.Codigo = 0 then
         Inserir(Entidade)
      else
         Atualizar(Entidade);
   except
      on E: Exception do
         Raise Exception.Create('Erro ao salvar registro.');
   end;
end;

end.
