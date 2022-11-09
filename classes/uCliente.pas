unit uCliente;

interface

uses System.SysUtils, Data.DB, Data.Win.ADODB, Classes, uEntidade;

type

   TClienteData = class(TEntidadeData)
   public
      Nome: String;
      CPF: String;
      DataNascimento: TDateTime;
      Ativo: Boolean;
   end;

   TCliente = class(TEntidade)
   protected
      procedure Inserir(var Entidade: TEntidadeData); override;
      procedure Atualizar(Entidade: TEntidadeData); override;
      procedure ValidarObjeto(Entidade: TEntidadeData); override;
      function CarregarObjeto: TEntidadeData; override;
   public
      function PesquisarCPF(CPF: String): Boolean;
      function CarregarClientes: TList;
   end;

implementation

uses uUtils;

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
         Query.Parameters.ParamByName('DataNascimento').Value := TClienteData(Entidade).DataNascimento;
         Query.Parameters.ParamByName('Ativo').Value          := TClienteData(Entidade).Ativo;
         Query.Open;

         Entidade.Codigo := Query.FieldByName('CodigoCliente').AsInteger;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao inserir cliente.');
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
         Query.Parameters.ParamByName('DataNascimento').Value := TClienteData(Entidade).DataNascimento;
         Query.Parameters.ParamByName('Ativo').Value          := TClienteData(Entidade).Ativo;
         Query.ExecSQL;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao atualizar cliente.');
      end;
   finally
      Query.Close;
   end;
end;

function TCliente.CarregarObjeto: TEntidadeData;
begin
   inherited;
   Result := TClienteData.Create;

   if Query.IsEmpty then
      Result.Codigo := 0
   else
   begin
      Result.Codigo                       := Query.FieldByName('CodigoCliente').AsInteger;
      TClienteData(Result).Nome           := Query.FieldByName('Nome').AsString;
      TClienteData(Result).CPF            := Query.FieldByName('CPF').AsString;
      TClienteData(Result).DataNascimento := Query.FieldByName('DataNascimento').AsDateTime;
      TClienteData(Result).Ativo          := Query.FieldByName('Ativo').AsBoolean;
   end;
end;

procedure TCliente.ValidarObjeto(Entidade: TEntidadeData);
begin
   inherited;
   if Trim(TClienteData(Entidade).Nome) = EmptyStr then
      Raise TValidacaoException.Create('É necessário preencher o Nome!');

   if not IsValidCPF(TClienteData(Entidade).CPF) then
      Raise TValidacaoException.Create('CPF inválido!');

   if TClienteData(Entidade).Codigo = 0 then
      Raise TValidacaoException.Create('CPF já cadastrado!');

   if TClienteData(Entidade).DataNascimento = 0 then
      Raise TValidacaoException.Create('Data de nascimento inválida!');
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

function TCliente.CarregarClientes: TList;
var
   ClienteData: TClienteData;
begin
   Result := TList.Create;

   Query.SQL.Text := ' select CodigoCliente, Nome, CPF, DataNascimento, Ativo '
                   + ' from Cliente                                           '
                   + ' order by Nome                                          ';

   try
      try
         Query.Open;

         while not Query.Eof do
         begin
            ClienteData := TClienteData.Create;
            ClienteData.Codigo         := Query.FieldByName('CodigoCliente').AsInteger;
            ClienteData.Nome           := Query.FieldByName('Nome').AsString;
            ClienteData.CPF            := Query.FieldByName('CPF').AsString;
            ClienteData.DataNascimento := Query.FieldByName('DataNascimento').AsDateTime;
            ClienteData.Ativo          := Query.FieldByName('Ativo').AsBoolean;

            Result.Add(ClienteData);

            Query.Next;
         end;
      except
         on E: Exception do
            Raise Exception.Create('Erro ao carregar clientes.');
      end;
   finally
      Query.Close;
   end;
end;

end.
