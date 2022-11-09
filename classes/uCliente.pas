unit uCliente;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, uEntidade;

type

   TClienteData = class(TEntidadeData)
   public
      Nome: String;
      CPF: String;
      Ativo: Boolean;
      DataNascimento: TDateTime;
   end;

   TCliente = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
   public
      function Pesquisar(Codigo: Integer): TEntidadeData; override;
      function Pesquisar(Pesquisa: String): TEntidadeData; override;
      function PesquisarCPF(CPF: String): Boolean;
   end;

implementation

{ TCliente }

procedure TCliente.Inserir(var Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' insert into Cliente                            '
                   + ' values (:Nome, :CPF, :Ativo, :DataNascimento) '
                   + ' select CodigoCliente = SCOPE_IDENTITY()        ';

   try
      try
         Query.Parameters.ParamByName('Nome').Value           := TClienteData(Entidade).Nome;
         Query.Parameters.ParamByName('CPF').Value            := TClienteData(Entidade).CPF;
         Query.Parameters.ParamByName('Ativo').Value          := TClienteData(Entidade).Ativo;
         Query.Parameters.ParamByName('DataNascimento').Value := TClienteData(Entidade).DataNascimento;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoCliente').AsInteger;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar cliente.');
      end;
   finally
      Query.Close;
   end;
end;

procedure TCliente.Atualizar(Entidade: TEntidadeData);
begin
   Query.SQL.Text := ' update Cliente set                   '
                   + '    Nome           = :Nome,           '
                   + '    CPF            = :CPF,            '
                   + '    Ativo          = :Ativo,          '
                   + '    DataNascimento = :DataNascimento  '
                   + ' where CodigoCliente = :CodigoCliente ';

   try
      try
         Query.Parameters.ParamByName('CodigoCliente').Value  := Entidade.Codigo;
         Query.Parameters.ParamByName('Nome').Value           := TClienteData(Entidade).Nome;
         Query.Parameters.ParamByName('CPF').Value            := TClienteData(Entidade).CPF;
         Query.Parameters.ParamByName('Ativo').Value          := TClienteData(Entidade).Ativo;
         Query.Parameters.ParamByName('DataNascimento').Value := TClienteData(Entidade).DataNascimento;
         Query.ExecSQL;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar cliente.');
      end;
   finally
      Query.Close;
   end;
end;

function TCliente.Pesquisar(Codigo: Integer): TEntidadeData;
begin
   Result := TClienteData.Create;
   Query.SQL.Text := ' select Nome, CPF, Ativo, DataNascimento '
                   + ' from Cliente                            '
                   + ' where CodigoCliente = :CodigoCliente    ';
   try
      try
         Query.Parameters.ParamByName('CodigoCliente').Value := Codigo;
         Query.Open;

         if Query.IsEmpty then
            Result.Codigo := 0
         else
         begin
            Result.Codigo                       := Codigo;
            TClienteData(Result).Nome           := Query.FieldByName('Nome').AsString;
            TClienteData(Result).CPF            := Query.FieldByName('CPF').AsString;
            TClienteData(Result).Ativo          := Query.FieldByName('Ativo').AsBoolean;
            TClienteData(Result).DataNascimento := Query.FieldByName('DataNascimento').AsDateTime;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar cliente.');
      end;
   finally
      Query.Close;
   end;
end;

function TCliente.Pesquisar(Pesquisa: String): TEntidadeData;
begin
   Result := TClienteData.Create;
   Query.SQL.Text := ' select top 1 CodigoCliente, Nome, CPF, Ativo, DataNascimento '
                   + ' from Cliente                                                 '
                   + ' where Nome like ''%' + Pesquisa + '%''                       ';

   try
      try
         Query.Open;

         if Query.IsEmpty then
            Result.Codigo := 0
         else
         begin
            Result.Codigo                       := Query.FieldByName('CodigoCliente').AsInteger;
            TClienteData(Result).Nome           := Query.FieldByName('Nome').AsString;
            TClienteData(Result).CPF            := Query.FieldByName('CPF').AsString;
            TClienteData(Result).Ativo          := Query.FieldByName('Ativo').AsBoolean;
            TClienteData(Result).DataNascimento := Query.FieldByName('DataNascimento').AsDateTime;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar cliente.');
      end;
   finally
      Query.Close;
   end;
end;

function TCliente.PesquisarCPF(CPF: String): Boolean;
begin
   Query.SQL.Text := ' select top 1 1 from Cliente where CPF = :CPF ';

   try
      try
         Query.Parameters.ParamByName('CPF').Value := CPF;
         Query.Open;

         Result := not Query.IsEmpty;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao pesquisar CPF.');
      end;
   finally
      Query.Close;
   end;
end;

end.
