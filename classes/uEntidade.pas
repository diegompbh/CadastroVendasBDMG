unit uEntidade;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB;

type

   TValidacaoException = class(Exception);

   TEntidadeData = class
   public
      Codigo: Integer;
   end;

   TEntidade = class
   protected
      Query: TADOQuery;
      NomeEntidade: String;
      NomeColunaPesquisa: String;
      procedure Inserir(var Entidade: TEntidadeData); virtual; abstract;
      procedure Atualizar(Entidade: TEntidadeData); virtual; abstract;
      procedure ValidarObjeto(Entidade: TEntidadeData); virtual; abstract;
      function CarregarObjeto: TEntidadeData; virtual; abstract;
   public
      constructor Create(Conexao: TADOConnection; NomeEntidade, NomeColunaPesquisa: String);
      procedure Salvar(var Entidade: TEntidadeData);
      procedure Excluir(Codigo: Integer); virtual;
      function Pesquisar(Codigo: Integer): TEntidadeData; overload;
      function Pesquisar(Pesquisa: String): TEntidadeData; overload;
   end;

implementation

{ TEntidade }

constructor TEntidade.Create(Conexao: TADOConnection; NomeEntidade, NomeColunaPesquisa: String);
begin
   Query := TADOQuery.Create(nil);
   Query.Connection := Conexao;

   Self.NomeEntidade       := NomeEntidade;
   Self.NomeColunaPesquisa := NomeColunaPesquisa;
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
   ValidarObjeto(Entidade);

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

function TEntidade.Pesquisar(Codigo: Integer): TEntidadeData;
begin
   Query.SQL.Text := ' select top 1 * from ' + NomeEntidade + ' where Codigo' + NomeEntidade + ' = :Codigo ';

   try
      try
         Query.Parameters.ParamByName('Codigo').Value := Codigo;
         Query.Open;

         Result := CarregarObjeto;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar registro.');
      end;
   finally
      Query.Close;
   end;
end;

function TEntidade.Pesquisar(Pesquisa: String): TEntidadeData;
begin
   Result := nil;

   if NomeColunaPesquisa = EmptyStr then
      Exit;

   Query.SQL.Text := ' select top 1 * from ' + NomeEntidade + ' where ' + NomeColunaPesquisa + ' like ''%' + Pesquisa + '%'' ';

   try
      try
         Query.Open;

         Result := CarregarObjeto;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar registro.');
      end;
   finally
      Query.Close;
   end;
end;

end.
